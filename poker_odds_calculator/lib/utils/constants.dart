import 'package:flutter/material.dart';

class AppColors {
  static const Color darkGray = Color(0xFF373737);
  static const Color mediumGray = Color(0xFF90949D);
  static const Color lightGray = Color(0xFFCACBCB);

  static TextStyle customTextStyle({
    Color color = darkGray,
    double fontSize = 14.0,
    FontWeight fontWeight = FontWeight.normal,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );
  }
}
