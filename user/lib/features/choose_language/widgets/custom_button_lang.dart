import 'package:frontend_user/core/constant/app_color.dart';
import 'package:flutter/material.dart';

class CustomButtonLang extends StatelessWidget {
  final String lang;
  final void Function() onPressed;
  const CustomButtonLang({
    super.key,
    required this.lang,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 60),
      color: AppColor.themeBlackColor,
      textColor: AppColor.titleColor,
      onPressed: onPressed,
      child: Text(lang, style: TextStyle(fontSize: 16)),
    );
  }
}
