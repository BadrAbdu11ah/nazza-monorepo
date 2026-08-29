import 'package:frontend_user/data/static/app_text.dart';
import 'package:frontend_user/app_translations.dart';
import 'package:flutter/material.dart';

String? validInput(
  BuildContext context,
  String val,
  int min,
  int max,
  String type,
) {
  // 1. الفحص الأساسي للحقول الفارغة
  if (val.isEmpty) {
    return AppTranslations.translate(context, AppText.emptyField);
  }

  // 2. التحقق من نمط البيانات المدخلة بناءً على النوع (بديل GetUtils)
  if (type == "username") {
    // اسم المستخدم: يبدأ بحرف، ويسمح بالأرقام والشرطة السفلية، الطول بين 3 و30 حرفاً
    final RegExp usernameRegExp = RegExp(r'^[a-zA-Z][a-zA-Z0-9_]{2,29}$');
    if (!usernameRegExp.hasMatch(val)) {
      return AppTranslations.translate(context, AppText.invalidUsername);
    }
  }

  if (type == "email") {
    // التعبير النمطي القياسي للتحقق من البريد الإلكتروني
    final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (!emailRegExp.hasMatch(val)) {
      return AppTranslations.translate(context, AppText.invalidEmail);
    }
  }

  if (type == "phone") {
    // التحقق من أرقام الهواتف (يوافق الأرقام من 7 إلى 15 خانة مع إشارة + الاختيارية)
    final RegExp phoneRegExp = RegExp(r'^\+?[0-9]{7,15}$');
    if (!phoneRegExp.hasMatch(val)) {
      return AppTranslations.translate(context, AppText.invalidPhone);
    }
  }

  // 3. التحقق من طول النص المدخل
  if (val.length < min) {
    return AppTranslations.translate(context, AppText.inputTooShort);
  }

  if (val.length > max) {
    return AppTranslations.translate(context, AppText.inputTooLong);
  }

  return null;
}
