import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  // تصميم الكلاس كـ Singleton لسهولة الوصول إليه في أي مكان بالمتجر
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  Map<String, dynamic> user = {};

  // 0 للمستخدم و 1 للآدمن
  String get role => user['users_role']?.toString() ?? '0';
  bool get isAdmin => role == '1';
  bool get isUserLoggedIn => user.isNotEmpty;

  // 1. حفظ التوكن وبيانات المستخدم في الذاكرة والتخزين الآمن
  Future<void> saveAuthData(Map<String, dynamic> responseData) async {
    final token = responseData['token']?.toString();
    if (token != null && token.isNotEmpty) {
      await storage.write(key: 'token', value: token);
    }

    final userData = responseData['data'];
    if (userData is Map<String, dynamic>) {
      user = userData;
      // حفظ الـ Role محلياً لحمايته عند إقلاع التطبيق المفاجئ
      if (user['users_role'] != null) {
        await storage.write(
          key: 'user_role',
          value: user['users_role'].toString(),
        );
      }
    }
  }

  // 2. دالة تُستدعى عند الإقلاع أو شاشة الـ Splash لاستعادة الصلاحيات مسبقاً
  Future<void> loadSavedRole() async {
    final savedRole = await storage.read(key: 'user_role');
    if (savedRole != null) {
      user = {'users_role': savedRole};
    }
  }

  // 3. تحديث بيانات المستخدم فقط في الذاكرة
  void setUserData(Map<String, dynamic> userData) {
    user = userData;
  }

  // 4. حذف البيانات بالكامل عند تسجيل الخروج
  Future<void> deleteAuthData() async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'user_role');
    user = {};
  }

  // 5. جلب التوكن
  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }
}
