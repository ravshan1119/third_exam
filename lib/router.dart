import 'package:flutter/material.dart';
import 'package:third_exam_n8/ui/favorites/favorites_screen.dart';
import 'package:third_exam_n8/ui/one_category/one_category_screen.dart';
import 'package:third_exam_n8/ui/tab_box.dart';

class RouteNames {
  static const String initial = "/";
  static const String favorite = "/favorite_screen";
  static const String categoryById = "/category_by_id";
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.initial:
        return MaterialPageRoute(builder: (context) => TabBoxScreen());
      case RouteNames.favorite:
        return MaterialPageRoute(builder: (context) => const FavoritesScreen());
      case RouteNames.categoryById:
        return MaterialPageRoute(
          builder: (context) => OneCategoryScreen(id: settings.arguments as int,),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("Route mavjud emas"),
            ),
          ),
        );
    }
  }
}
