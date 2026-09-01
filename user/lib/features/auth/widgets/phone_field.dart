import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneField extends StatelessWidget {
  final String invalidMessage;
  final FocusNode focusNode;
  final TextEditingController controller;
  const PhoneField({
    super.key,
    required this.invalidMessage,
    required this.focusNode,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          TextDirection.ltr, // إجبار الاتجاه ليكون من اليسار إلى اليمين دائماً
      child: IntlPhoneField(
        controller: controller,
        focusNode: focusNode, // التحكم بالتركيز
        initialCountryCode: 'SA', // جعل السعودية (+966) الدولة الافتراضية
        textAlign: TextAlign.left, // محاذاة كتابة الرقم من اليسار
        decoration: InputDecoration(
          hintText: '5XXXXXXXX',
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 3),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        invalidNumberMessage: invalidMessage,
      ),
    );
  }
}
