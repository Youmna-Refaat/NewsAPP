import 'package:flutter/material.dart';
import 'package:news_app/extensions/extension.dart';
import '../../core/theme/app_text_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double radius;
  final bool hasPrefixIcn;
  final bool? prefixIcon;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    this.radius = 16,
    this.hasPrefixIcn = false,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child:
          Text(
            text,
            style: AppTextStyles.styleMedium20(
              context,
            ).copyWith(color: textColor),
          ).setToCenter(),
    );
  }
}
