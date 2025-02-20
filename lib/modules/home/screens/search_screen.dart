import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/extensions/extension.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/routes/screens_route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/models/article_model.dart';
import '../../widgets/article_card.dart';
import '../Cubits/home_cubit.dart';
import '../Cubits/home_states.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late HomeCubit _cubit;
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _cubit = HomeCubit.get(context);
  }

  List<ArticleDataModel> _filterArticles(
    List<ArticleDataModel> articles,
    String query,
  ) {
    if (query.isEmpty) {
      return articles;
    }
    return articles.where((article) {
      return article.title.toLowerCase().contains(query.toLowerCase()) ||
          (article.description.toLowerCase().contains(query.toLowerCase()));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredArticles = _filterArticles(_cubit.articlesList, _searchQuery);

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  TextField(
                    style: AppTextStyles.styleMedium20(context).copyWith(
                      color:
                          _cubit.isDark() ? AppColors.white : AppColors.black,
                    ),
                    cursorColor:
                        _cubit.isDark() ? AppColors.white : AppColors.black,
                    controller: _searchController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      hintText: "Search",
                      hintStyle: AppTextStyles.styleMedium20(context).copyWith(
                        color:
                            _cubit.isDark() ? AppColors.white : AppColors.black,
                      ),
                      prefixIcon: SvgPicture.asset(
                        AppIcons.iconsSearch,
                        colorFilter: ColorFilter.mode(
                          _cubit.isDark() ? AppColors.white : AppColors.black,
                          BlendMode.srcIn,
                        ),
                      ).setSymmetricPadding(
                        context,
                        horizontal: 10,
                        vertical: 10,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);

                          _cubit.getAllArticles();
                        },
                        child: Icon(
                          Icons.close_rounded,
                          color:
                              _cubit.isDark()
                                  ? AppColors.white
                                  : AppColors.black,
                        ).setVerticalPadding(context, value: 8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            _cubit.isDark()
                                ? const BorderSide(color: AppColors.white)
                                : const BorderSide(color: AppColors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            _cubit.isDark()
                                ? const BorderSide(color: AppColors.white)
                                : const BorderSide(color: AppColors.black),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            _cubit.isDark()
                                ? const BorderSide(color: AppColors.white)
                                : const BorderSide(color: AppColors.black),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ).setOnlyPadding(context, top: 40),
                  //SearchTexField().setOnlyPadding(context, top: 40),
                  Expanded(
                    child: Skeletonizer(
                      enabled: state is GetArticlesLoadingState,
                      child:
                          filteredArticles.isEmpty
                              ? Center(
                                child: Text(
                                  "No articles found",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              )
                              : ListView.separated(
                                itemBuilder: (context, index) {
                                  final article = filteredArticles[index];
                                  return ArticleCard(
                                    articleModel: article,
                                    onTap: () {
                                      _cubit.setSelectedArticle(
                                        ArticleDataModel(
                                          title:
                                              article.title.isNotEmpty
                                                  ? article.title
                                                  : 'No Title',
                                          urlToImage:
                                              article.urlToImage!.isNotEmpty
                                                  ? article.urlToImage
                                                  : AppImages.imagesUnavailable,
                                          description:
                                              article.description.isNotEmpty
                                                  ? article.description
                                                  : 'No description available.',
                                          id: '',
                                          author: '',
                                          url: '',
                                          publishedAt: '',
                                          content:
                                              article.content.isNotEmpty
                                                  ? article.content
                                                  : 'No content available.',
                                        ),
                                      );
                                      Navigator.pushNamed(
                                        context,
                                        ScreensRouteNames.articleDetailsRoute,
                                      ).then((value) {
                                        _cubit.getAllArticles();
                                        _cubit.getAllSources();
                                      });
                                    },
                                  );
                                },
                                separatorBuilder:
                                    (context, index) => 10.setVerticalSpace(),
                                itemCount: filteredArticles.length,
                              ),
                    ),
                  ),
                ],
              ).setHorizontalPadding(context, value: 20),
            ],
          ),
        );
      },
    );
  }
}
