import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/extensions/extension.dart';
import '../../../core/routes/screens_route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../widgets/category_card.dart';
import '../../widgets/custom_drawer.dart';
import '../Cubits/home_cubit.dart';
import '../Cubits/home_states.dart';
import 'category_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.selectedCategoryModel == null
                  ? "Home"
                  : cubit.selectedCategoryModel!.categoryName,
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ScreensRouteNames.searchRoute);
                },
                child: Icon(
                  Icons.search,
                  size: 28,
                ).setHorizontalPadding(context, value: 20),
              ),
            ],
          ),
          drawer: CustomDrawer(),
          body:
              cubit.selectedCategoryModel == null
                  ? SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "News Categories :",
                          style: AppTextStyles.styleMedium24(context).copyWith(
                            color:
                                cubit.isDark()
                                    ? AppColors.white
                                    : AppColors.black,
                            letterSpacing: -0.22,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return CategoryCard(
                              index: index,
                              categoryModel: cubit.categoriesList[index],
                              onTap: cubit.setSelectedCategory,
                            );
                          },
                          separatorBuilder:
                              (context, index) => 10.setVerticalSpace(),
                          itemCount: cubit.categoriesList.length,
                        ),
                      ],
                    ).setHorizontalPadding(context, value: 20),
                  )
                  : CategoryDetailsScreen(
                    categoryModel: cubit.selectedCategoryModel!,
                  ),
        );
      },
    );
  }
}
