import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Deep elegant dark background, not fully black
  static const Color background = Color(0xFF0F0F13);
  static const Color surface = Color(0xFF1E1E24);
  static const Color accent = Color(0xFF7C4DFF); // Deep purple/violet accent

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.dark(primary: accent, surface: surface),
      fontFamily: GoogleFonts.poppins().fontFamily,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: -1,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: 16,
          color: Colors.white.withOpacity(0.9),
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.white.withOpacity(0.7),
          height: 1.4,
        ),
      ),
    );
  }
}
