import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/routes/screens_route_names.dart';
import '../../../data/models/article_model.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/source_model.dart';
import '../../../data/network/api_network.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitislState());
  static HomeCubit get(BuildContext context) {
    return BlocProvider.of<HomeCubit>(context);
  }

  final categoriesList = [
    CategoryModel(
      categoryID: "general",
      categoryName: "General",
      image: AppImages.imagesGeneral,
    ),
    CategoryModel(
      categoryID: "business",
      categoryName: "Business",
      image: AppImages.imagesBusiness,
    ),
    CategoryModel(
      categoryID: "sports",
      categoryName: "Sports",
      image: AppImages.imagesSports,
    ),
    CategoryModel(
      categoryID: "technology",
      categoryName: "Technology",
      image: AppImages.imagesTechnology,
    ),
    CategoryModel(
      categoryID: "entertainment",
      categoryName: "Entertainment",
      image: AppImages.imagesEntertaiment,
    ),
    CategoryModel(
      categoryID: "health",
      categoryName: "Health",
      image: AppImages.imagesHealth,
    ),
    CategoryModel(
      categoryID: "science",
      categoryName: "Science",
      image: AppImages.imagesScience,
    ),
  ];
  int selectedIndex = 0;
  List<SourceDataModel> sourcesList = [];
  List<ArticleDataModel> articlesList = [];
  CategoryModel? selectedCategoryModel;
  ThemeMode currentTheme = ThemeMode.light;
  String currentLanguage = "en";
  ArticleDataModel? selectedArticleModel;
  final List<String> _languagesList = ["English", "عربي"];

  final List<String> _themeList = ["Light", "Dark"];
  List<String> get languagesList => _languagesList;
  List<String> get themeList => _themeList;
  void setCurrentLanguage(String newLanguage) {
    if (newLanguage == currentLanguage) return;
    currentLanguage = newLanguage;
    emit(ChangeLanguageState());
  }

  void setCurrentTheme(ThemeMode newTheme) {
    if (newTheme == currentTheme) return;
    currentTheme = newTheme;

    emit(SetThemeState());
  }

  bool isDark() {
    return currentTheme == ThemeMode.dark;
  }

  void setSelectedCategory(CategoryModel data) {
    selectedCategoryModel = data;
    emit(SetSelectedCategoryState());
  }

  void setSelectedArticle(ArticleDataModel article) {
    selectedArticleModel = article;
    emit(SetSelectedArticleState());
  }

  void goToHome(BuildContext context) {
    selectedCategoryModel = null;
    emit(SetSelectedCategoryState());
    Navigator.popAndPushNamed(context, ScreensRouteNames.homeRoute);
  }

  void setCurrentSelectedIndex(int index) {
    selectedIndex = index;

    emit(SetSelectedSourceState());
    getAllArticles();
  }

  Future<void> getAllSources() async {
    try {
      emit(GetSourcesLoadingState());
      sourcesList = await APINetwork.getAllSources(
        selectedCategoryModel!.categoryID,
      );
      emit(GetSourcesSuccessState());
    } catch (error) {
      emit(GetSourcesErrorState());
    }
  }

  Future<void> getAllArticles() async {
    try {
      emit(GetArticlesLoadingState());
      articlesList = await APINetwork.getAllArticles(
        sourcesList[selectedIndex].id,
        currentLanguage,
      );
      emit((GetArticlesSuccessState()));
    } catch (error) {
      emit(GetArticlesErrorState());
    }
  }
}
