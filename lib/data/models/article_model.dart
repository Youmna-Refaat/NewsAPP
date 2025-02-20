import 'package:news_app/core/constants/app_images.dart';

class ArticleDataModel {
  final String id;
  final String author;
  final String title;
  final String description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String content;

  const ArticleDataModel({
    required this.id,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory ArticleDataModel.fromJson(Map<String, dynamic> json) {
    return ArticleDataModel(
      id: json["source"]["id"],
      author: json["author"],
      title: json["title"],
      description: json["description"],
      url: json["url"],
      urlToImage: json["urlToImage"] ?? AppImages.imagesUnavailable,
      publishedAt: json["publishedAt"],
      content: json["content"],
    );
  }
}
// import '../../core/constants/app_images.dart';

// class ArticleDataModel {
//   final String id;
//   final String author;
//   final String title;
//   final String description;
//   final String url;
//   final String? urlToImage;
//   final String publishedAt;
//   final String content;

//   const ArticleDataModel({
//     required this.id,
//     required this.author,
//     required this.title,
//     required this.description,
//     required this.url,
//     this.urlToImage,
//     required this.publishedAt,
//     required this.content,
//   });

//   factory ArticleDataModel.fromJson(Map<String, dynamic> json) {
//     return ArticleDataModel(
//       id: json["source"]["id"] ?? "No ID",
//       author: json["author"] ?? "Unknown Author",
//       title: json["title"] ?? "No Title",
//       description: json["description"] ?? "No Description",
//       url: json["url"] ?? "No URL",
//       urlToImage: json["urlToImage"] ?? AppImages.imagesUnavailable,
//       publishedAt: json["publishedAt"] ?? "No Date",
//       content: json["content"] ?? "No Content Available", // Handle null content
//     );
//   }
// }
