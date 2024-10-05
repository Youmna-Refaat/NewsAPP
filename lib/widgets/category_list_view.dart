import 'package:flutter/material.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/widgets/category_card.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({
    super.key,
  });

  final List<CategoryModel> categories = const [
    CategoryModel(
      image:
          'https://th.bing.com/th/id/OIP.q-3kDs2qhHqeryoBQtxYkgHaE7?pid=ImgDet&rs=1',
      categoryName: "Business",
    ),
    CategoryModel(
      image:
          'https://th.bing.com/th?id=OIP.yhzm7WQJ3Fvd6CP8ZO9rawHaE8&w=306&h=204&c=8&rs=1&qlt=90&o=6&pid=3.1&rm=2',
      categoryName: "Entertainment",
    ),
    CategoryModel(
      image:
          'https://www.bing.com/th?id=OIP.NiYttuB5yITSBHeSrgFibwHaE8&w=154&h=103&c=8&rs=1&qlt=90&o=6&pid=3.1&rm=2',
      categoryName: "General",
    ),
    CategoryModel(
      image: 'https://wallpaperaccess.com/full/186125.jpg',
      categoryName: "Health",
    ),
    CategoryModel(
      image:
          'https://th.bing.com/th/id/R.e9b2fbfa7f687ef7a22b58335e109610?rik=RDQpwZW%2b8gb47g&riu=http%3a%2f%2fgetwallpapers.com%2fwallpaper%2ffull%2f2%2f4%2f7%2f169743.jpg&ehk=25pvb01cuZDy2iMrjzLpk5MwDOmIm7yXyYimarvdvpk%3d&risl=&pid=ImgRaw&r=0',
      categoryName: "Science",
    ),
    CategoryModel(
      image:
          'https://th.bing.com/th?id=OIP.Hd69LCQqsixT1ptZhMW-RAHaE-&w=304&h=204&c=8&rs=1&qlt=90&o=6&pid=3.1&rm=2',
      categoryName: "Sports",
    ),
    CategoryModel(
      image:
          'https://th.bing.com/th?id=OIP.K8urvQKqHarydD5ixvdQBAHaFI&w=300&h=208&c=8&rs=1&qlt=90&o=6&pid=3.1&rm=2',
      categoryName: "Technology",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryCard(
            category: categories[index],
          );
        },
      ),
    );
  }
}
