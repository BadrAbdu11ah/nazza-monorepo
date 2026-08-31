import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_user/app_translations.dart';
import 'package:frontend_user/core/constant/app_color.dart';
import 'package:frontend_user/core/constant/app_image_asset.dart';
import 'package:frontend_user/core/constant/app_route.dart';
import 'package:frontend_user/core/localization/bloc/localization_bloc.dart';
import 'package:frontend_user/data/static/app_text.dart';
import 'package:frontend_user/features/choose_language/widgets/custom_button_lang.dart';

class ChooseLanguage extends StatelessWidget {
  const ChooseLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColor.bgColorOnBoarding,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ---------- Choose Language ----------
            Image.asset(
              AppImageAsset.logo,
              height: screenWidth * 0.5,
              fit: BoxFit.contain,
            ),
            SizedBox(height: screenWidth * 0.1),
            Text(
              AppTranslations.translate(context, AppText.titleChooseLanguage),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: screenWidth * 0.1),

            // Arabic
            CustomButtonLang(
              lang: AppTranslations.translate(context, AppText.arabic),
              onPressed: () {
                context.read<LocalizationBloc>().add(
                  LocalizationEvent.changeLocalization("ar"),
                );
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoute.login,
                  (route) => false,
                );
              },
            ),

            // English
            CustomButtonLang(
              lang: AppTranslations.translate(context, AppText.english),
              onPressed: () {
                context.read<LocalizationBloc>().add(
                  LocalizationEvent.changeLocalization("en"),
                );
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoute.login,
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
