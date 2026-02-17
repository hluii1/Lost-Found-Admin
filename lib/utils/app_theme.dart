import 'package:flutter/material.dart';

class AppTheme {
  // ── Brand palette (taken from screenshots) ──────────────────────────────
  static const Color primaryBlue   = Color(0xFF1A56C4);
  static const Color darkBlue      = Color(0xFF0D3A8A);
  static const Color accentGreen   = Color(0xFF2E7D32);
  static const Color lightBlue     = Color(0xFFDCEAFF);
  static const Color bgLight       = Color(0xFFEEF4FF);
  static const Color white         = Color(0xFFFFFFFF);
  static const Color textDark      = Color(0xFF1A1A2E);
  static const Color textGrey      = Color(0xFF6B7280);
  static const Color borderColor   = Color(0xFF3B6FCC);
  static const Color linkColor     = Color(0xFF1A56C4);
  static const Color errorRed      = Color(0xFFD32F2F);
  static const Color successGreen  = Color(0xFF2E7D32);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
        primary: primaryBlue,
        secondary: accentGreen,
        surface: white,
      ),
      scaffoldBackgroundColor: bgLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: white,
        foregroundColor: textDark,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: borderColor, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: borderColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorRed, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorRed, width: 2),
        ),
        hintStyle: const TextStyle(color: textGrey, fontSize: 13),
        errorStyle: const TextStyle(fontSize: 11, color: errorRed),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkBlue,
          foregroundColor: white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
          elevation: 2,
        ),
      ),
    );
  }
}