import 'package:flutter/material.dart';
import 'package:frontend_user/data/static/app_text/choose_language_text.dart';

class AppTranslations {
  // قاموس مركزي يحتوي على جميع النصوص المترجمة
  static final Map<String, Map<String, String>> keys = {
    "ar": {...chooseLanguageAr},
    "en": {...chooseLanguageEn},
  };

  // // دالة لجلب النص المترجم بصورة آمنة تمنع توقف التطبيق
  static String translate(
    BuildContext context,
    String key, {
    String defaultLang = 'ar',
  }) {
    // // استخدام maybeLocaleOf لفحص وجود اللغة بدون استثناءات
    final Locale? locale = Localizations.maybeLocaleOf(context);
    final String langCode = locale?.languageCode ?? defaultLang;

    // // إرجاع النص المترجم أو المفتاح في حال عدم وجوده
    return keys[langCode]?[key] ?? key;
  }
}
