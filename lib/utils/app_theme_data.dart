import 'package:calendar_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  static ThemeData lightThemeData = ThemeData(
    primarySwatch: MaterialColor(AppColors.primaryColor.value, AppColors.colorSwatch),
    textTheme: GoogleFonts.poppinsTextTheme(),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
    useMaterial3: true,
    primaryColor: AppColors.primaryColor
  );
}
