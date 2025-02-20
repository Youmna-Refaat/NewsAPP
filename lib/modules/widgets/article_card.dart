import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/extensions/extension.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/article_model.dart';
import '../home/Cubits/home_cubit.dart';

class ArticleCard extends StatelessWidget {
  final ArticleDataModel articleModel;
  final VoidCallback onTap;

  const ArticleCard({
    super.key,
    required this.articleModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 0.45.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: cubit.isDark() ? AppColors.white : AppColors.black,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: articleModel.urlToImage!,
                imageBuilder:
                    (context, imageProvider) => Container(
                      height: 0.29.height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                placeholder:
                    (context, url) =>
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: const CircularProgressIndicator(
                            color: AppColors.grey,
                          ),
                        ).setToCenter(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            10.setVerticalSpace(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  articleModel.title,
                  style: AppTextStyles.styleBold16(
                    context,
                  ).copyWith(letterSpacing: -0.25),
                ),
                Text(
                  "By: ${articleModel.author}",
                  style: AppTextStyles.styleMedium12(
                    context,
                  ).copyWith(color: AppColors.grey),
                ),
              ],
            ),
          ],
        ).setSymmetricPadding(context, horizontal: 8, vertical: 6),
      ),
    );
  }
}
