import 'package:frontend_user/data/static/app_text.dart';
import 'package:frontend_user/app_translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<bool?> alertExitApp(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        AppTranslations.translate(context, AppText.alert), // "تنبيه"
      ),
      content: Text(
        AppTranslations.translate(
          context,
          AppText.exitMessage,
        ), // "هل تريد الخروج من التطبيق"
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            // الخروج من التطبيق نهائياً ونظام التشغيل
            SystemNavigator.pop();
          },
          child: Text(AppTranslations.translate(context, AppText.confirm)),
        ),

        const SizedBox(width: 80),

        ElevatedButton(
          onPressed: () {
            // إغلاق الدايلوج فقط والرجوع للخلف
            Navigator.of(context).pop(false);
          },
          child: Text(
            AppTranslations.translate(
              context,
              AppText.cancel,
            ), // "إلغاء" أو "Cancel"
          ),
        ),
      ],
    ),
  );
}
