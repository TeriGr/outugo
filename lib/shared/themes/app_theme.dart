import 'package:flutter/material.dart';

class AppTheme {
  // colors
  static const primaryColor = Color(0xFFf18b21);
  static const secondaryColor = Color(0xFF366A7D);
  static const white = Colors.white;
  static const lightGrey = Colors.white24;
  static const gradientColor = Color(0xFF1F2B58);
  static const listHeaderColor = Color(0xFF366A7D);
  static const selectedTabColor = Color(0xFF00788f);
  static const buttonColor = Color(0xFF393e3f);
  static const primaryButtonColor = Color(0xFF43A875);
  static const secondaryButtonColor = Color(0xFFF94144);
  static const black = Colors.black;
  static const grey = Colors.grey;
  static const dividerColor = Colors.black26;

  // text styles

  static TextStyle headlineStyle() {
    return TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  }

  static TextStyle subHeadlineStyle() {
    return TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
  }

  static TextStyle largeTitleStyle() {
    return TextStyle(fontSize: 16.0, color: black);
  }

  static TextStyle title16black600() {
    return const TextStyle(
      color: black,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle detail14black400() {
    return const TextStyle(
      color: black,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle titleStyle() {
    return TextStyle(fontSize: 14.0);
  }

  static TextStyle subTitleStyle() {
    return TextStyle(fontSize: 11.0, color: black);
  }

  static TextStyle subTitleBoldStyle() {
    return TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold);
  }

  static TextStyle textBodyStyle() {
    return TextStyle(fontSize: 9.0);
  }

  static TextStyle textBodyMediumStyle() {
    return TextStyle(fontSize: 9.0, fontWeight: FontWeight.w400);
  }

  static TextStyle captionStyle() {
    return TextStyle(fontSize: 8.0);
  }
}
