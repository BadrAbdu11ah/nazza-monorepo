import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend_user/core/class/failure.dart';
import 'package:frontend_user/core/function/check_internet.dart';

class ApiService {
  final String baseUrl;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  ApiService({required this.baseUrl});

  // جلب التوكن المخزن عند تسجيل الدخول
  Future<String?> getToken() async => await storage.read(key: 'token');

  // تجهيز الروأس لكل طلب
  Future<Map<String, String>> _getHeaders({bool auth = true}) async {
    final headers = <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    if (auth) {
      final token = await getToken();
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }

  // جلب البيانات (GET)
  Future<Either<Failure, Map<String, dynamic>>> get(
    String endpoint, {
    bool auth = true,
  }) async {
    try {
      if (!await checkInternet()) {
        return const Left(
          OfflineFailure('لا يوجد اتصال بالإنترنت، يرجى التحقق من الشبكة'),
        );
      }
      final url = Uri.parse('$baseUrl$endpoint');
      final headers = await _getHeaders(auth: auth);
      final response = await http.get(url, headers: headers);

      print("=========== API GET Request ===========");
      print("response: ${response.statusCode} - ${response.body}");

      return _handleResponse(response);
    } catch (e) {
      return Left(ServerFailure('حدث خطأ غير متوقع في السيرفر: $e'));
    }
  }

  // إرسال بيانات جديدة (POST)
  Future<Either<Failure, Map<String, dynamic>>> post(
    String endpoint,
    Map<String, dynamic> body, {
    bool auth = true,
  }) async {
    try {
      if (!await checkInternet()) {
        return const Left(
          OfflineFailure('لا يوجد اتصال بالإنترنت، يرجى التحقق من الشبكة'),
        );
      }
      final url = Uri.parse('$baseUrl$endpoint');
      final headers = await _getHeaders(auth: auth);
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      print("=========== API POST Request ===========");
      print("response: ${response.statusCode} - ${response.body}");

      return _handleResponse(response);
    } catch (e) {
      print("Error in POST request: $e");
      return Left(ServerFailure('فشل إرسال البيانات للسيرفر: $e'));
    }
  }

  // تحديث بيانات موجودة (PUT)
  Future<Either<Failure, Map<String, dynamic>>> put(
    String endpoint,
    Map<String, dynamic> body, {
    bool auth = true,
  }) async {
    try {
      if (!await checkInternet()) {
        return const Left(
          OfflineFailure('لا يوجد اتصال بالإنترنت، يرجى التحقق من الشبكة'),
        );
      }
      final url = Uri.parse('$baseUrl$endpoint');
      final headers = await _getHeaders(auth: auth);

      print("========== API PUT Debug ==========");
      print("URL: $url");
      print("Headers: $headers");
      print("Body: $body");
      print("===================================");

      final response = await http.put(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      return Left(ServerFailure('فشل تحديث البيانات: $e'));
    }
  }

  // حذف بيانات (DELETE)
  Future<Either<Failure, Map<String, dynamic>>> delete(
    String endpoint, {
    bool auth = true,
  }) async {
    try {
      if (!await checkInternet()) {
        return const Left(
          OfflineFailure('لا يوجد اتصال بالإنترنت، يرجى التحقق من الشبكة'),
        );
      }
      final url = Uri.parse('$baseUrl$endpoint');
      final headers = await _getHeaders(auth: auth);
      final response = await http.delete(url, headers: headers);
      return _handleResponse(response);
    } catch (e) {
      return Left(ServerFailure('فشل عملية الحذف من السيرفر: $e'));
    }
  }

  // المعالجة الذكية والتحليل لردود السيرفر
  Either<Failure, Map<String, dynamic>> _handleResponse(
    http.Response response,
  ) {
    final code = response.statusCode;

    // في حال نجاح الطلب واستلام البيانات
    if (code == 200 || code == 201) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) {
        return Right(decoded);
      }
      return const Left(EmptyDataFailure('استجابة السيرفر فارغة أو غير صالحة'));
    }

    // محاولة استخراج رسالة الخطأ المخصصة القادمة من Laravel API (إن وجدت)
    try {
      final errorBody = jsonDecode(response.body);
      if (errorBody is Map && errorBody.containsKey('message')) {
        return Left(
          ServerFailure(errorBody['message'].toString(), statusCode: code),
        );
      }
    } catch (_) {}

    // التعامل مع الأخطاء القياسية لـ HTTP Status Codes
    if (code == 401) {
      return const Left(
        ServerFailure('انتهت الجلسة، يرجى إعادة تسجيل الدخول', statusCode: 401),
      );
    }
    if (code == 403) {
      return const Left(
        ServerFailure('ليس لديك الصلاحية للوصول لهذا الإجراء', statusCode: 403),
      );
    }
    if (code == 404) {
      return const Left(
        ServerFailure('المورد المطلوب غير موجود على السيرفر', statusCode: 404),
      );
    }

    return Left(
      ServerFailure('فشل الطلب البرمجي، رمز الحالة: $code', statusCode: code),
    );
  }
}
