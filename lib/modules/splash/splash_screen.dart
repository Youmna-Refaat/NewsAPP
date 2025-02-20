import 'package:flutter/material.dart';
import '../../core/constants/app_images.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../main.dart';
import '../home/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(
        navigatorKey.currentContext!,
      ).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
    });
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.imagesSplashLight),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "News",
                  style: AppTextStyles.styleBold24(context),
                ),
                TextSpan(
                  text: "App",
                  style: AppTextStyles.styleBold24(
                    context,
                  ).copyWith(color: AppColors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
