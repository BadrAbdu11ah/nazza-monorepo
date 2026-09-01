import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final String title;
  const CustomDivider({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // خط فاصل جهة اليمين
        const Expanded(child: Divider()),
        // كلمة الفاصل
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            title,
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
        ),
        // خط فاصل جهة اليسار
        const Expanded(child: Divider()),
      ],
    );
  }
}
