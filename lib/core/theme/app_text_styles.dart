import 'package:flutter/material.dart';
import '../../modules/home/Cubits/home_cubit.dart';
import 'app_colors.dart';

abstract class AppTextStyles {
  static TextStyle styleRegular14(BuildContext context) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: "Inter",
      color:
          HomeCubit.get(context).isDark() ? AppColors.white : AppColors.black,
    );
  }

  static TextStyle styleMedium12(BuildContext context) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      fontFamily: "Inter",
      color:
          HomeCubit.get(context).isDark() ? AppColors.white : AppColors.black,
    );
  }

  static TextStyle styleMedium14(BuildContext context) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: "Inter",
      color:
          HomeCubit.get(context).isDark() ? AppColors.white : AppColors.black,
    );
  }

  static TextStyle styleMedium20(BuildContext context) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      fontFamily: "Inter",
      color:
          HomeCubit.get(context).isDark() ? AppColors.white : AppColors.black,
    );
  }

  static TextStyle styleMedium24(BuildContext context) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      fontFamily: "Inter",
      color:
          HomeCubit.get(context).isDark() ? AppColors.white : AppColors.black,
    );
  }

  static TextStyle styleBold16(BuildContext context) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      fontFamily: "Inter",
      color:
          HomeCubit.get(context).isDark() ? AppColors.white : AppColors.black,
    );
  }

  static TextStyle styleBold20(BuildContext context) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      fontFamily: "Inter",
      color:
          HomeCubit.get(context).isDark() ? AppColors.white : AppColors.black,
    );
  }

  static TextStyle styleBold24(BuildContext context) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      fontFamily: "Inter",
      color:
          HomeCubit.get(context).isDark() ? AppColors.white : AppColors.black,
    );
  }
}
