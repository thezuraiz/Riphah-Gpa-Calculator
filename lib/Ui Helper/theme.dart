import 'package:Riphah_CGPA_Calculator/Ui%20Helper/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData UiThemeData() {
  return ThemeData(
    primaryColor: Color(Color_helper.button_color),
    useMaterial3: true,
    fontFamily: GoogleFonts.poppins().fontFamily,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: Color(Color_helper.button_color),
        foregroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 26,
        fontFamily: GoogleFonts.roboto().fontFamily
      )
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Color(Color_helper.button_color),
        ),
      ),
      prefixIconColor: Color(Color_helper.button_color),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(Color_helper.button_color),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
        padding: const EdgeInsets.all(18),
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Color(Color_helper.button_color),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(Color_helper.button_color),
      foregroundColor: Color(Color_helper.white_background_color)
    ),
    dialogTheme: const DialogTheme(
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w400
      ),
    ),
    iconTheme: IconThemeData(
      color: Color(Color_helper.button_color)
    )
  );
}
