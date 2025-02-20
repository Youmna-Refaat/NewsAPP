import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/extensions/extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../widgets/custom_drawer.dart';
import '../Cubits/home_cubit.dart';
import '../Cubits/home_states.dart';

class ArticleDetailsScreen extends StatelessWidget {
  const ArticleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "News",
                    style: AppTextStyles.styleBold24(context).copyWith(
                      color: cubit.isDark() ? AppColors.white : AppColors.black,
                    ),
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
          ),
          drawer: CustomDrawer(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  cubit.selectedArticleModel!.title,
                  style: AppTextStyles.styleBold24(
                    context,
                  ).copyWith(letterSpacing: -0.22),
                ),
                cubit.selectedArticleModel!.author.isNotEmpty
                    ? Text(
                      "Author: ${cubit.selectedArticleModel!.author}",
                      style: AppTextStyles.styleRegular14(context),
                    ).setHorizontalPadding(context, value: 16)
                    : Container(),
                10.setVerticalSpace(),
                Container(
                  height: 0.3.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(
                        cubit.selectedArticleModel!.urlToImage!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                20.setVerticalSpace(),
                Text(
                  cubit.selectedArticleModel!.description.isNotEmpty
                      ? cubit.selectedArticleModel!.description
                      : 'No description available',
                  style: AppTextStyles.styleRegular14(context).copyWith(
                    color: cubit.isDark() ? AppColors.white : AppColors.black,
                    letterSpacing: -0.22,
                  ),
                  textAlign: TextAlign.justify,
                ),
                20.setVerticalSpace(),
                Text(
                  cubit.selectedArticleModel!.content.isNotEmpty
                      ? cubit.selectedArticleModel!.content
                      : 'No content available',
                  style: AppTextStyles.styleRegular14(context).copyWith(
                    color: cubit.isDark() ? AppColors.white : AppColors.black,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ).setHorizontalPadding(context, value: 20),
          ),
        );
      },
    );
  }
}
