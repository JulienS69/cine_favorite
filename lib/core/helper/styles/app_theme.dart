import 'package:cine_favorite/core/helper/styles/app_colors.dart';
import 'package:cine_favorite/core/helper/styles/app_text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  /// Light theme data of the app
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      textTheme: TextThemes.textTheme,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.lightGrey,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
