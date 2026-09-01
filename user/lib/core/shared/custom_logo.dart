import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  final String tagImage;
  final String imageName;
  final double heightImage;
  const CustomLogo({
    super.key,
    required this.tagImage,
    required this.imageName,
    required this.heightImage,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tagImage,
      child: Image.asset(imageName, height: heightImage, fit: BoxFit.contain),
    );
  }
}
