import 'package:frontend_user/features/auth/data/auth_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  // ربط طبقة البيانات بالمتحكم
  final AuthData authData;

  LoginBloc(this.authData) : super(const LoginState.initial()) {
    // 1. الاستماع لحدث طلب إرسال رمز OTP
    on<_SendOtp>((event, emit) => _onSendOtp(event.phone, emit));

    // 2. الاستماع لحدث التحقق من رمز الـ OTP
    on<_VerifyOtp>(
      (event, emit) => _onVerifyOtp(event.phone, event.code, emit),
    );

    // 3. الاستماع لحدث تسجيل الدخول عبر قوقل
    on<_LoginWithGoogle>((event, emit) => _onLoginWithGoogle(emit));

    // 4. الاستماع لحدث إعادة ضبط الحالة إلى الوضع الابتدائي
    on<_Reset>((event, emit) => emit(const LoginState.initial()));
  }

  // معالجة طلب إرسال رمز OTP إلى رقم الهاتف
  Future<void> _onSendOtp(String phone, Emitter<LoginState> emit) async {
    // 1. تحديث الحالة إلى "جاري التحميل"
    emit(const LoginState.loading());

    // 2. طلب إرسال الرمز من طبقة authData
    final response = await authData.sendOtp(phone);

    // 3. معالجة الاستجابة المستلمة من السيرفر
    response.fold(
      // إرسال حالة الفشل في حال وجود خطأ في الاتصال
      (failure) => emit(LoginState.failure(failure.message)),
      // معالجة وصول الرد بنجاح
      (data) {
        // فحص الفشل المنطقي المسترجع من الباك إند
        if (data["status"] == "failure" || data["status"] == "error") {
          emit(
            LoginState.failure(data["message"] ?? data["errorKey"].toString()),
          );
          return;
        }

        // إرسال حالة نجاح إرسال رمز OTP لتوجيه المستخدم لشاشة الإدخال
        emit(const LoginState.otpSent());
      },
    );
  }

  // معالجة طلب التحقق من رمز OTP
  Future<void> _onVerifyOtp(
    String phone,
    String code,
    Emitter<LoginState> emit,
  ) async {
    // 1. تحديث الحالة إلى "جاري التحميل"
    emit(const LoginState.loading());

    // 2. إرسال الرمز ورقم الهاتف للمطابقة من طبقة authData
    final response = await authData.verifyOtp(phone, code);

    // 3. معالجة الاستجابة المستلمة
    await response.fold(
      // إرسال حالة الفشل في حال خطأ الشبكة
      (failure) async => emit(LoginState.failure(failure.message)),
      // معالجة رد السيرفر
      (data) async {
        // فحص خطأ مطابقة الرمز أو انتهاء الصلاحية
        if (data["status"] == "failure" || data["status"] == "error") {
          emit(LoginState.failure(data["message"] ?? "رمز التحقق غير صحيح"));
          return;
        }

        // التأكد من أن الـ Emitter ما زال نشطاً قبل إرسال الحالة
        if (!emit.isDone) {
          // إرسال حالة نجاح عملية التوثيق
          emit(const LoginState.success());
        }
      },
    );
  }

  // معالجة طلب تسجيل الدخول عبر قوقل
  Future<void> _onLoginWithGoogle(Emitter<LoginState> emit) async {
    // 1. تحديث الحالة إلى "جاري التحميل"
    emit(const LoginState.loading());

    // 2. تنفيذ طلب تسجيل الدخول بواسطة قوقل من طبقة البيانات
    final response = await authData.loginWithGoogle();

    // 3. معالجة النتيجة المسترجعة
    await response.fold(
      // إرسال حالة الفشل مع الرسالة
      (failure) async => emit(LoginState.failure(failure.message)),
      // معالجة نجاح الاستجابة من الباك إند
      (data) async {
        // فحص فشل الاستجابة المنطقية من السيرفر
        if (data['status'] == "fail" || data['status'] == "failure") {
          emit(
            LoginState.failure(data['message'] ?? data['errorKey'].toString()),
          );
          return;
        }

        // التأكد من عدم إغلاق الـ Handler قبل إرسال الحالة
        if (!emit.isDone) {
          // إرسال حالة نجاح تسجيل الدخول
          emit(const LoginState.success());
        }
      },
    );
  }
}
