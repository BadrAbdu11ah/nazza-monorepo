import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // final AppService appService = AppService();
    // String? step = appService.sharedPreferences.getString("step");

    String? finalRouteName = settings.name;

    // تطبيق منطق الـ Middleware عند الدخول للتطبيق
    // if (finalRouteName == AppRoute.chooseLanguage ||
    //     finalRouteName == AppRoute.onBoarding) {
    //   if (step == "2") {
    //     finalRouteName = AppRoute.homeScreen;
    //   } else if (step == "1") {
    //     finalRouteName = AppRoute.login;
    //   } else if (step == "0") {
    //     finalRouteName = AppRoute.onBoarding;
    //   }
    // }

    switch (finalRouteName) {
      default:
        return null;
    }
  }
}
