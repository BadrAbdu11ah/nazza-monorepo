import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_user/core/constant/app_route.dart';
import 'package:frontend_user/core/id/injection.dart';
import 'package:frontend_user/core/services/app_service.dart';
import 'package:frontend_user/features/auth/login/bloc/login_bloc.dart';
import 'package:frontend_user/features/auth/login/view/login_view.dart';
import 'package:frontend_user/features/choose_language/view/choose_language.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // final AppService appService = AppService();
    // String? step = appService.sharedPreferences.getString("step");

    String? finalRouteName = settings.name;

    // // تطبيق منطق الـ Middleware عند الدخول للتطبيق
    // if (finalRouteName == AppRoute.chooseLanguage ||
    //     finalRouteName == AppRoute.onBoarding) {
    //   if (step == "2") {
    //     finalRouteName = AppRoute.homeScreen;
    //   } else if (step == "0") {
    //     finalRouteName = AppRoute.login;
    //   }
    // }

    switch (finalRouteName) {
      case AppRoute.chooseLanguage:
        return MaterialPageRoute(builder: (_) => const ChooseLanguage());
      case AppRoute.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<LoginBloc>(),
            child: LoginView(),
          ),
        );
      default:
        return null;
    }
  }
}
