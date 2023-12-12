import 'package:flutter/material.dart';

sealed class CepAppColors {
  static Color get whiteColor => const Color(0xFFFFFFFF);

  static Color get blackColor => const Color(0xFF000000);

  static Color get primaryColor => const Color(0xFFE040FB);

  static Color get secondaryColor => whiteColor;

  static Color get errorColor => const Color(0xFFFF5252);

  // Dark Theme
  static Color get darkBgColor => const Color(0xFF222222);

  // Light Theme
  static Color get lightBgColor => const Color(0xFFFFFFFF);
}
