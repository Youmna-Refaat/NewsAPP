import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/extensions/extension.dart';
import '../../core/constants/app_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../home/Cubits/home_cubit.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    final currentTheme = cubit.isDark() ? "Dark" : "Light";
    final currentLanguage = cubit.currentLanguage == "en" ? "English" : "عربي";

    final themeOptions =
        cubit.themeList.where((theme) => theme != currentTheme).toList();
    final languageOptions =
        cubit.languagesList.where((lang) => lang != currentLanguage).toList();
    return Drawer(
      backgroundColor: AppColors.black,
      child: Column(
        children: [
          Container(
            height: 0.20.height,
            color: AppColors.white,
            child:
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "News",
                        style: AppTextStyles.styleBold24(
                          context,
                        ).copyWith(color: AppColors.black),
                      ),
                      TextSpan(
                        text: "App",
                        style: AppTextStyles.styleBold24(
                          context,
                        ).copyWith(color: AppColors.grey),
                      ),
                    ],
                  ),
                ).setToCenter(),
          ),
          15.setVerticalSpace(),
          GestureDetector(
            onTap: () {
              cubit.goToHome(context);
            },
            child: Row(
              children: [
                SvgPicture.asset(AppIcons.iconsHome),
                Text(
                  "Go To Home",
                  style: AppTextStyles.styleBold20(
                    context,
                  ).copyWith(color: AppColors.white),
                ).setHorizontalPadding(context, value: 20),
              ],
            ).setSymmetricPadding(context, horizontal: 40, vertical: 10),
          ),
          Divider(color: AppColors.white, endIndent: 20, indent: 20),

          Row(
            children: [
              SvgPicture.asset(AppIcons.iconsTheme),
              Text(
                "Theme",
                style: AppTextStyles.styleBold20(
                  context,
                ).copyWith(color: AppColors.white),
              ).setHorizontalPadding(context, value: 20),
            ],
          ).setSymmetricPadding(context, horizontal: 40, vertical: 10),
          CustomDropdown<String>(
            hintText: currentTheme,
            items: themeOptions,
            onChanged: (value) {
              if (value == "Dark") {
                cubit.setCurrentTheme(ThemeMode.dark);
              }
              if (value == "Light") {
                cubit.setCurrentTheme(ThemeMode.light);
              }
            },

            decoration: dropDownDecoration(context),
          ).setHorizontalPadding(context, value: 20),
          12.setVerticalSpace(),
          Divider(color: AppColors.white, endIndent: 20, indent: 20),

          Row(
            children: [
              SvgPicture.asset(AppIcons.iconsLanguage),
              Text(
                "Language",
                style: AppTextStyles.styleBold20(
                  context,
                ).copyWith(color: AppColors.white),
              ).setHorizontalPadding(context, value: 20),
            ],
          ).setSymmetricPadding(context, horizontal: 40, vertical: 10),

          CustomDropdown<String>(
            hintText: currentLanguage,
            items: languageOptions,
            onChanged: (value) {
              if (value == "English") {
                cubit.setCurrentLanguage("en");
              } else {
                cubit.setCurrentLanguage("ar");
              }
              if (cubit.selectedCategoryModel != null) {
                cubit.getAllArticles();
                cubit.getAllSources();
              }
            },
            decoration: dropDownDecoration(context),
          ).setHorizontalPadding(context, value: 20),
          12.setVerticalSpace(),
        ],
      ),
    );
  }

  CustomDropdownDecoration dropDownDecoration(BuildContext context) {
    return CustomDropdownDecoration(
      headerStyle: AppTextStyles.styleMedium20(
        context,
      ).copyWith(color: AppColors.white),
      listItemStyle: AppTextStyles.styleMedium20(
        context,
      ).copyWith(color: AppColors.white),
      hintStyle: AppTextStyles.styleMedium20(
        context,
      ).copyWith(color: AppColors.white),
      listItemDecoration: ListItemDecoration(
        highlightColor: AppColors.black,
        selectedColor: AppColors.black,
        splashColor: AppColors.black,
      ),
      closedFillColor: AppColors.black,
      expandedFillColor: AppColors.black,
      closedBorder: Border.all(color: AppColors.white, width: 1.8),
      closedBorderRadius: BorderRadius.circular(18.0),
      closedSuffixIcon: const Icon(
        Icons.arrow_drop_down_rounded,
        size: 28,
        color: AppColors.white,
      ),
    );
  }
}
