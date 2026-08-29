import 'package:frontend_user/app_translations.dart';
import 'package:frontend_user/data/static/app_text.dart';
import 'package:flutter/material.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: Colors.blueAccent),
    );
  }
}

class AppErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const AppErrorWidget({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text("إعادة المحاولة"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AppEmptyWidget extends StatelessWidget {
  final String text;
  final String? textButton;
  final VoidCallback? onTap;
  const AppEmptyWidget({
    super.key,
    this.text = "لا توجد بيانات لعرضها",
    this.onTap,
    this.textButton,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.layers_clear_outlined, color: Colors.grey, size: 48),
          const SizedBox(height: 10),
          Text(text, style: const TextStyle(fontSize: 18, color: Colors.grey)),
          if (onTap != null) ...[
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: onTap,
              icon: const Icon(Icons.add),
              label: Text(textButton ?? "إضافة"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class AppDialogs {
  static void dialogDelete({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppTranslations.translate(context, AppText.cancel)),
          ),
          TextButton(
            onPressed: onConfirm,
            child: Text(AppTranslations.translate(context, AppText.delete)),
          ),
        ],
      ),
    );
  }

  static void dialogMessage(
    BuildContext context, {
    required String title,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        actions: [
          TextButton(
            onPressed: onConfirm,
            child: Text(AppTranslations.translate(context, AppText.confirm)),
          ),
        ],
      ),
    );
  }

  static void dialogError({
    required BuildContext context,
    required String title,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        actions: [
          TextButton(
            onPressed: onConfirm,
            child: Text(AppTranslations.translate(context, AppText.confirm)),
          ),
        ],
      ),
    );
  }
}
