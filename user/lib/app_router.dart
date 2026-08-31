import 'package:flutter/material.dart';
import 'package:frontend_user/core/constant/app_route.dart';
import 'package:frontend_user/features/choose_language/view/choose_language.dart';

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
      case AppRoute.chooseLanguage:
        return MaterialPageRoute(builder: (_) => const ChooseLanguage());
      default:
        return null;
    }
  }
}
