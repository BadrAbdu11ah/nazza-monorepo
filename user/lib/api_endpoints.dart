class ApiEndpoints {
  // رابط السيرفر المباشر لخدمات المستخدم
  static const String baseUrl = "http://[adderss_api]:8000/api/user";

  // -----------------------------------------------------------
  // 1. مسارات المصادقة (Auth)
  // -----------------------------------------------------------
  static const String googleLogin = "/google-login";
  static const String sendOtp = "/send-otp";
  static const String verifyOtp = "/verify-otp";
  static const String logout = "/logout";

  // -----------------------------------------------------------
  // 1. home
  // -----------------------------------------------------------
  static const String home = "/home";
  static const String offers = "/offers";
  static const String searchItems = "/search";
}
