import 'package:flutter/material.dart';

class TextConstants {
  static TextStyle kMainTextStyle(
      {double? fontSize,
      String? fontFamily,
      FontWeight? fontWeight,
      Color? textColour}) {
    return TextStyle(
      fontSize: fontSize ?? 40.0,
      fontWeight: fontWeight ?? FontWeight.w700,
      fontFamily: fontFamily ?? 'Saira',
      color: textColour,
    );
  }

  static TextStyle kSubTextStyle(
      {double? fontSize,
      String? fontFamily,
      FontWeight? fontWeight,
      Color? textColour}) {
    return TextStyle(
      fontSize: fontSize ?? 30.0,
      fontWeight: fontWeight ?? FontWeight.w500,
      fontFamily: fontFamily ?? 'Saira',
      color: textColour,
    );
  }
}
