import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/home/Cubits/home_cubit.dart';
import 'package:news_app/modules/home/Cubits/home_states.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme_manager.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    BlocProvider(create: (context) => HomeCubit(), child: const NewsApp()),
  );
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        final currentTheme = HomeCubit.get(context).currentTheme;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoutes.onGenerateRoute,
          theme: AppThemeManager.lightTheme(context),
          darkTheme: AppThemeManager.darkTheme(context),
          themeMode: currentTheme,
          navigatorKey: navigatorKey,
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
