import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/extensions/extension.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/category_model.dart';
import '../../widgets/article_card.dart';
import '../../widgets/overlay_article_container.dart';
import '../Cubits/home_cubit.dart';
import '../Cubits/home_states.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final CategoryModel categoryModel;

  const CategoryDetailsScreen({super.key, required this.categoryModel});

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen>
    with TickerProviderStateMixin {
  late HomeCubit _cubit;
  late TabController _tabController;
  bool _isOverlayVisible = false;
  String? _overlayImageUrl;
  String? _overlayTitle;
  String? _overlayDescription;
  String? _overlayContent;

  @override
  void initState() {
    super.initState();
    _cubit = HomeCubit.get(context);

    Future.wait([_cubit.getAllSources()]).then((value) {
      _cubit.getAllArticles();
      _tabController = TabController(
        length: _cubit.sourcesList.length,
        vsync: this,
      );
    });
  }

  void _toggleOverlay({String? imageUrl, String? title, String? description}) {
    setState(() {
      _isOverlayVisible = !_isOverlayVisible;

      _overlayImageUrl = imageUrl ?? AppImages.imagesUnavailable;
      _overlayTitle = title ?? 'No Title Available';
      _overlayDescription = description ?? 'No description available.';
      _overlayContent = 'No Content Available';
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetArticlesLoadingState) {
          return CircularProgressIndicator().setToCenter();
        }
        if (state is GetArticlesErrorState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, color: Colors.red, size: 30),
              SizedBox(height: 10),
              Text(
                "Something went wrong",
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            ],
          ).setToCenter();
        }
        if (state is GetArticlesSuccessState) {
          var cubit = HomeCubit.get(context);
          return Stack(
            children: [
              Column(
                children: [
                  DefaultTabController(
                    length: _cubit.sourcesList.length,
                    child: TabBar(
                      controller: _tabController,
                      tabs:
                          _cubit.sourcesList
                              .map((e) => Tab(text: e.name))
                              .toList(),
                      onTap: (index) {
                        cubit.setCurrentSelectedIndex(index);
                      },
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      indicatorPadding: EdgeInsets.zero,
                      indicatorColor: AppColors.black,
                      labelPadding: EdgeInsets.symmetric(horizontal: 8),
                      labelColor:
                          _cubit.isDark() ? AppColors.white : AppColors.grey,
                      unselectedLabelColor:
                          _cubit.isDark() ? AppColors.grey : AppColors.black,
                    ),
                  ),
                  5.setVerticalSpace(),

                  Expanded(
                    child: Skeletonizer(
                      enabled: _cubit.articlesList.isEmpty,
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final article = _cubit.articlesList[index];
                          return ArticleCard(
                            articleModel: article,
                            onTap: () {
                              _toggleOverlay(
                                imageUrl: article.urlToImage,
                                title: article.title,
                                description: article.description,
                              );
                            },
                          );
                        },
                        separatorBuilder:
                            (context, index) => 10.setVerticalSpace(),
                        itemCount: _cubit.articlesList.length,
                      ),
                    ),
                  ),
                ],
              ).setHorizontalPadding(context, value: 20),
              if (_isOverlayVisible)
                GestureDetector(
                  onTap: _toggleOverlay,
                  child: OverlayArticleContainer(
                    isOverlayVisible: _isOverlayVisible,
                    cubit: cubit,
                    overlayImageUrl: _overlayImageUrl,
                    overlayTitle: _overlayTitle,
                    overlayDescription: _overlayDescription,
                    overlayContent: _overlayContent,
                  ),
                ),
            ],
          );
        }
        return Text(
          "No Articles Found",
          style: TextStyle(color: AppColors.grey),
        ).setToCenter();
      },
    );
  }
}
