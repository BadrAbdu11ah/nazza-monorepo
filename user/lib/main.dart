import 'package:frontend_user/app_router.dart';
import 'package:frontend_user/core/constant/app_route.dart';
import 'package:frontend_user/core/id/injection.dart';
import 'package:frontend_user/core/localization/bloc/localization_bloc.dart';
import 'package:frontend_user/core/routes/app_route_observer.dart';
import 'package:frontend_user/core/services/app_service.dart';
import 'package:frontend_user/features/search/bloc/search_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة الخدمات الشاملة مثل SharedPreferences و Firebase
  await initialService();
  await initGetIt();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              LocalizationBloc()
                ..add(LocalizationEvent.loadSavedLocalization()),
        ),
        BlocProvider(create: (context) => sl<SearchBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationBloc, LocalizationState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'نزّا',

          // تطبيق اللغة والثيم القادمة من الـ State الخاص بالـ Bloc
          locale: state.locale,
          theme: state.themeData,

          // إعدادات الـ Localizations الافتراضية في فلاتر لدعم التوجه (RTL / LTR)
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          navigatorObservers: [AppRouteObserver()],
          supportedLocales: const [Locale('ar', ''), Locale('en', '')],
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: AppRoute.chooseLanguage,
        );
      },
    );
  }
}
