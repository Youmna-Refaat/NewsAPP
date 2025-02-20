import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:news_app/extensions/extension.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final int index;
  final CategoryModel categoryModel;
  final void Function(CategoryModel) onTap;

  const CategoryCard({
    super.key,
    required this.index,
    required this.categoryModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.25.height,

      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(categoryModel.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Stack(
          children: [
            Bounceable(
              onTap: () {
                onTap(categoryModel);
              },
              child: Align(
                alignment:
                    index % 2 == 0
                        ? Alignment.bottomRight
                        : Alignment.bottomLeft,

                child: Container(
                  height: 0.07.height,
                  width: 0.43.width,
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(84),
                  ),
                  child: Directionality(
                    textDirection:
                        index % 2 == 0 ? TextDirection.ltr : TextDirection.rtl,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "View All",
                          style: AppTextStyles.styleMedium24(
                            context,
                          ).copyWith(letterSpacing: -0.22),
                        ).setOnlyPadding(
                          context,
                          left: index % 2 == 0 ? 10 : 0,
                          right: index % 2 == 0 ? 0 : 10,
                        ),
                        Container(
                          height: 0.13.height,
                          width: 0.13.width,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white,
                          ),
                          child: Icon(Icons.arrow_forward_ios_rounded),
                        ),
                      ],
                    ),
                  ),
                ).setSymmetricPadding(context, horizontal: 10, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
