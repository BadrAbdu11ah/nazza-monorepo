import 'package:flutter/material.dart';

class TitleLang extends StatelessWidget {
  final String title;
  const TitleLang({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.headlineLarge);
  }
}
