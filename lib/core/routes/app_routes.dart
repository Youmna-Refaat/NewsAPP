import 'package:flutter/material.dart';
import '../../modules/home/screens/article_details_screen.dart';
import '../../modules/home/screens/home_screen.dart';
import '../../modules/home/screens/search_screen.dart';
import '../../modules/splash/splash_screen.dart';
import 'screens_route_names.dart';

abstract class AppRoutes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ScreensRouteNames.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: settings,
        );
      case ScreensRouteNames.homeRoute:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
          settings: settings,
        );

      case ScreensRouteNames.articleDetailsRoute:
        return MaterialPageRoute(
          builder: (context) => const ArticleDetailsScreen(),
          settings: settings,
        );
      case ScreensRouteNames.searchRoute:
        return MaterialPageRoute(
          builder: (context) => const SearchScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(builder: (context) => const Scaffold());
    }
  }
}
