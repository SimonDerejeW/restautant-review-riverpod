import 'package:flutter/material.dart';
import 'package:restaurant_review/core/theme/app_pallete.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  static final LightThemeMode = ThemeData.light().copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromRGBO(254, 107, 0, 0.9),
        primary: const Color.fromRGBO(254, 107, 0, 0.9),
        primaryContainer: const Color.fromRGBO(254, 107, 0, 0.23)
      ),
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      displayLarge: GoogleFonts.poppins(
          fontSize: 40,
          fontWeight: FontWeight.bold
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 17,
        fontWeight: FontWeight.bold
      ),
      ),
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(20),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient3),
    ),
  );
}
