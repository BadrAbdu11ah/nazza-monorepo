import 'package:frontend_user/api_endpoints.dart';
import 'package:frontend_user/core/class/failure.dart';
import 'package:frontend_user/core/services/api_service.dart';
import 'package:frontend_user/core/services/app_service.dart';
import 'package:frontend_user/core/services/auth_service.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthData {
  final ApiService apiService;
  final AppService appService;
  final AuthService authService;

  AuthData(this.apiService)
    : appService = AppService(),
      authService = AuthService();

  // 1. طلب إرسال رمز OTP إلى رقم الهاتف
  Future<Either<Failure, Map<String, dynamic>>> sendOtp(String phone) async {
    try {
      // إرسال رقم الهاتف للباك إند لتوليد وإرسال رمز التحقق
      final response = await apiService.post(ApiEndpoints.sendOtp, {
        "phone": phone.trim(),
      }, auth: false);

      return response.fold((failure) => Left(failure), (data) async {
        if (data['status'] == "success") {
          // حفظ رقم الهاتف محلياً لاستخدامه في شاشة إدخال الرمز
          await appService.sharedPreferences.setString('phone', phone.trim());
        }
        return Right(data);
      });
    } catch (e) {
      return const Left(AuthFailure('حدث خطأ غير متوقع أثناء طلب رمز التحقق'));
    }
  }

  // 2. التحقق من صحة رمز الـ OTP
  Future<Either<Failure, Map<String, dynamic>>> verifyOtp(
    String phone,
    String code,
  ) async {
    try {
      // إرسال رقم الهاتف ورمز OTP للباك إند للمطابقة
      final response = await apiService.post(ApiEndpoints.verifyOtp, {
        "phone": phone.trim(),
        "code": code.trim(),
      }, auth: false);

      return response.fold((failure) => Left(failure), (data) async {
        if (data['status'] == "success") {
          // حفظ بيانات المصادقة والتوكن في حال إرجاعها من السيرفر
          if (data['token'] != null) {
            await authService.saveAuthData(data);
          }

          // تحديث الخطوة للميدل وير للتوجيه للرئيسية مباشرة
          await appService.sharedPreferences.setString('step', '2');
          await appService.sharedPreferences.setString('phone', phone.trim());

          // حفظ معرف المستخدم محلياً إذا توفر في الاستجابة
          if (data['user'] != null && data['user']['id'] != null) {
            await appService.sharedPreferences.setInt('id', data['user']['id']);
          }
        }
        return Right(data);
      });
    } catch (e) {
      return const Left(
        AuthFailure('حدث خطأ غير متوقع أثناء عملية التحقق من الرمز'),
      );
    }
  }

  // 3. طلب تسجيل الدخول عبر قوقل (Google Login)
  Future<Either<Failure, Map<String, dynamic>>> loginWithGoogle() async {
    try {
      // 1. فتح واجهة المصادقة واختيار الحساب
      final GoogleSignInAccount? googleUser = await GoogleSignIn.instance
          .authenticate();

      // فحص إلغاء العملية من قبل المستخدم
      if (googleUser == null) {
        return const Left(AuthFailure('تم إلغاء عملية تسجيل الدخول'));
      }

      // 2. استخراج توكين المصادقة من قوقل
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      if (googleAuth.idToken == null) {
        return const Left(
          AuthFailure('تعذر الحصول على توكين المصادقة من قوقل'),
        );
      }

      // 3. إرسال رمز id_token فقط للباك إند للتحقق منه
      final response = await apiService.post(ApiEndpoints.googleLogin, {
        "id_token": googleAuth.idToken,
      }, auth: false);

      return response.fold((failure) => Left(failure), (data) async {
        if (data['status'] == "fail" || data['status'] == "failure") {
          return Right(data);
        }

        // حفظ بيانات التوثيق والتوكن
        await authService.saveAuthData(data);
        // تحديث خطوة التوجيه في التطبيق
        await appService.sharedPreferences.setString('step', '2');

        final String userEmail = data['user']?['email'] ?? googleUser.email;
        final int? userId = data['user']?['id'];

        await appService.sharedPreferences.setString('email', userEmail);
        if (userId != null) {
          await appService.sharedPreferences.setInt('id', userId);
        }

        return Right(data);
      });
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return const Left(AuthFailure('تم إلغاء عملية تسجيل الدخول'));
      }
      return const Left(AuthFailure('حدث خطأ أثناء الاتصال بحساب قوقل'));
    } catch (e) {
      return const Left(
        AuthFailure('حدث خطأ غير متوقع أثناء تسجيل الدخول عبر قوقل'),
      );
    }
  }

  // 4. طلب تسجيل الخروج
  Future<Either<Failure, Map<String, dynamic>>> logout() async {
    // إرسال طلب الخروج وإلغاء التوكن من السيرفر
    final response = await apiService.post(ApiEndpoints.logout, {}, auth: true);

    return response.fold((failure) => Left(failure), (data) async {
      // إعادة ضبط خطوة الميدل وير وتفريغ البيانات المخزنة محلياً
      await appService.sharedPreferences.setString('step', "1");
      await appService.sharedPreferences.remove('id');
      await appService.sharedPreferences.remove('email');
      await appService.sharedPreferences.remove('phone');
      return Right(data);
    });
  }
}
