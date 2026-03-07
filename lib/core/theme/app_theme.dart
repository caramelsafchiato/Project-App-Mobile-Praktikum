import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static const Color primaryColor = Color(0xFF1E88E5);
  static const Color successColor = Color(0xFF43A047);
  static const Color errorColor = Color(0xFFE53935);
  static const Color textSecondaryColor = Color(0xFF757575);
  static const Color textPrimaryColor = Color(0xFF212121);

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
  );
}