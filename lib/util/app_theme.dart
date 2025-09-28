
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF1A1A1A);
  static const Color secondaryColor = Color(0xFF333333);
  static const Color accentColor = Color(0xFF6A7D95);

  static ThemeData get theme {
    final textTheme = GoogleFonts.interTextTheme(ThemeData.light().textTheme);

    return ThemeData(
      primarySwatch: Colors.grey,
      textTheme: textTheme.apply(
        bodyColor: primaryColor,
        displayColor: primaryColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: primaryColor),
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
