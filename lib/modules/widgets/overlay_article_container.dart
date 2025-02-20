import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/extensions/extension.dart';
import '../../core/constants/app_images.dart';
import '../../core/routes/screens_route_names.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/article_model.dart';
import '../home/Cubits/home_cubit.dart';
import 'custom_elevated_button.dart';

class OverlayArticleContainer extends StatelessWidget {
  const OverlayArticleContainer({
    super.key,
    required bool isOverlayVisible,
    required this.cubit,
    String? overlayImageUrl,
    String? overlayTitle,
    String? overlayDescription,
    String? overlayContent,
  }) : _isOverlayVisible = isOverlayVisible,
       _overlayImageUrl = overlayImageUrl ?? AppImages.imagesUnavailable,
       _overlayTitle = overlayTitle ?? 'No Title Available',
       _overlayDescription = overlayDescription ?? 'No description available',
       _overlayContent = overlayContent ?? 'No content available';

  final bool _isOverlayVisible;
  final HomeCubit cubit;
  final String _overlayImageUrl;
  final String _overlayTitle;
  final String _overlayDescription;
  final String _overlayContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.5),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: _isOverlayVisible ? 0.55.height : 0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            color: cubit.isDark() ? AppColors.white : AppColors.black,
          ),
          child: Column(
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl:
                      _overlayImageUrl.isNotEmpty
                          ? _overlayImageUrl
                          : AppImages.imagesUnavailable,
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
              5.setVerticalSpace(),
              Text(
                _overlayTitle.isNotEmpty ? _overlayTitle : 'No Title Available',
                style: AppTextStyles.styleBold16(context).copyWith(
                  color: cubit.isDark() ? AppColors.black : AppColors.white,
                ),
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              10.setVerticalSpace(),

              CustomElevatedButton(
                text: "View Full Article",
                onPressed: () {
                  cubit.setSelectedArticle(
                    ArticleDataModel(
                      title:
                          _overlayTitle.isNotEmpty ? _overlayTitle : 'No Title',
                      urlToImage:
                          _overlayImageUrl.isNotEmpty
                              ? _overlayImageUrl
                              : AppImages.imagesUnavailable,
                      description:
                          _overlayDescription.isNotEmpty
                              ? _overlayDescription
                              : 'No description available.',
                      id: '',
                      author: '',
                      url: '',
                      publishedAt: '',
                      content:
                          _overlayContent.isNotEmpty
                              ? _overlayContent
                              : 'No content available.',
                    ),
                  );
                  Navigator.pushNamed(
                    context,
                    ScreensRouteNames.articleDetailsRoute,
                  ).then((value) {
                    cubit.getAllArticles();
                    cubit.getAllSources();
                  });
                },
                backgroundColor:
                    cubit.isDark() ? AppColors.black : AppColors.white,
                textColor: cubit.isDark() ? AppColors.white : AppColors.black,
              ),
            ],
          ).setSymmetricPadding(context, horizontal: 15, vertical: 10),
        ),
      ),
    );
  }
}
