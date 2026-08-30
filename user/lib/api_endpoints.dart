class ApiEndpoints {
  // رابط السيرفر المباشر لخدمات المستخدم
  static const String baseUrl = "https://badr-api.duckdns.org/api/user";

  // -----------------------------------------------------------
  // 1. مسارات المصادقة (Auth)
  // -----------------------------------------------------------
  static const String googleLogin = "/google-login";
  static const String sendOtp = "/send-otp";
  static const String verifyOtp = "/verify-otp";
  static const String login = "/login";
  static const String signup = "/signup";
  static const String verifyCode = "/auth/verify-code";
  static const String logout = "/logout";

  // استعادة كلمة المرور
  static const String checkEmail = "/forgetpassword/checkemail";
  static const String forgetVerifyCode = "/forgetpassword/verifycode";
  static const String resetPassword = "/forgetpassword/reset-password";
  static const String resetVerifyCode = "/forgetpassword/reset-verify-code";

  // -----------------------------------------------------------
  // 1. home
  // -----------------------------------------------------------
  static const String home = "/home";
  static const String offers = "/offers";
  static const String searchItems = "/search";
}
