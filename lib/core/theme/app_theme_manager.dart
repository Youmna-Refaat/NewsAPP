import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

abstract class AppThemeManager {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.black,
      titleTextStyle: AppTextStyles.styleMedium20(
        context,
      ).copyWith(color: AppColors.black),

      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
  );
  static ThemeData darkTheme(BuildContext context) => ThemeData(
    scaffoldBackgroundColor: AppColors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.white,
      titleTextStyle: AppTextStyles.styleMedium20(
        context,
      ).copyWith(color: AppColors.white),

      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
  );
}
