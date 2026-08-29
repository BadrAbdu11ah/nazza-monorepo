import 'package:frontend_user/core/constant/app_color.dart';
import 'package:flutter/material.dart';

ThemeData themeEnglish = ThemeData(
  fontFamily: "Cairo",
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      color: AppColor.themeColor,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColor.themeColor),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColor.themeColor,
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColor.titleColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 17,
      height: 1.5, // مقدار المسافة بين الأسطر
      color: AppColor.bodyColor,
    ),
  ),
);
ThemeData themeArabic = ThemeData(
  fontFamily: "Cairo",
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      color: AppColor.themeColor,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: "Cairo",
    ),
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColor.themeColor),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColor.themeColor,
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColor.titleColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 18,
      height: 1.5, // مقدار المسافة بين الأسطر
      color: AppColor.bodyColor,
    ),
  ),
);
