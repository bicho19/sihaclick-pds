import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SCColors {
  static final blue = Color(0xFF13C2D4);
  static final dark = Color(0xFF046489);
  static final gray = Color(0xFFC2C2C2);
  static final light = Color(0xFFE4E4E4);
  static final background = Color(0xFFF9F9F9);
  static final lighter = Color(0xFFF5F5F5);
  static final red = Color(0xFFE84118);
}

class Theme {
  ThemeData get themeData {
    ColorScheme colorScheme = ColorScheme(
      primary: SCColors.blue,
      onPrimary: Colors.pink,
      primaryVariant: SCColors.dark,
      background: SCColors.background,
      onBackground: Colors.black,
      secondary: Colors.white,
      onSecondary: SCColors.lighter,
      secondaryVariant: SCColors.red,
      error: SCColors.red,
      onError: Colors.white,
      surface: SCColors.gray,
      onSurface: SCColors.light,
      brightness: Brightness.light,
    );

    return ThemeData.light().copyWith(
      colorScheme: colorScheme,
      primaryColor: SCColors.blue,
      buttonColor: SCColors.blue,
      accentColor: SCColors.blue,
      unselectedWidgetColor: Colors.white,
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      buttonTheme: ButtonThemeData(),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: SCColors.light, width: 1.0),
        ),
        hintStyle: TextStyle(color: SCColors.dark.withOpacity(0.5)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: SCColors.blue, width: 2.0),
        ),
      ),
      scaffoldBackgroundColor: SCColors.background,
      appBarTheme: AppBarTheme(
        elevation: 0,
        color: SCColors.blue,
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          headline6: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
          headline5: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
