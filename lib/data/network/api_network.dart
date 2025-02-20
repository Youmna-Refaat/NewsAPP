import 'dart:developer';
import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../../core/constants/api_endpoints.dart';
import '../models/article_model.dart';
import '../models/source_model.dart';

abstract class APINetwork {
  const APINetwork();

  static Future<List<SourceDataModel>> getAllSources(String categoryID) async {
    var queryParameters = {
      "apiKey": APIConstants.apiKey,
      "category": categoryID,
    };

    try {
      var response = await Dio().get(
        Uri.https(
          APIConstants.baseURL,
          APIEndpoints.getAllSources,
          queryParameters,
        ).toString(),
      );

      Map<String, dynamic> data = response.data;
      List<dynamic> dataList = data["sources"];

      return dataList.map((e) => SourceDataModel.fromJson(e)).toList();
    } catch (e) {
      log("Error fetching sources: $e");
      return [];
    }
  }

  // static Future<List<ArticleDataModel>> getAllArticles(
  //   String sourceID,
  //   String language,
  // ) async {
  //   var queryParameters = {
  //     "apiKey": APIConstants.apiKey,
  //     "sources": sourceID,
  //     "language": language,
  //   };

  //   try {
  //     var response = await Dio().get(
  //       Uri.https(
  //         APIConstants.baseURL,
  //         APIEndpoints.getAllArticles,
  //         queryParameters,
  //       ).toString(),
  //     );

  //     Map<String, dynamic> data = response.data;

  //     return (data["articles"] as List)
  //         .map((e) => ArticleDataModel.fromJson(e))
  //         .toList();
  //   } catch (e) {
  //     log("Error fetching articles: $e");
  //     return [];
  //   }
  // }
  static Future<List<ArticleDataModel>> getAllArticles(
    String sourceID,
    String language,
  ) async {
    var queryParameters = {
      "apiKey": APIConstants.apiKey,
      "sources": sourceID,
      "language": language,
    };

    try {
      var response = await Dio().get(
        Uri.https(
          APIConstants.baseURL,
          APIEndpoints.getAllArticles,
          queryParameters,
        ).toString(),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        List<dynamic> articles = data["articles"];

        // Log the API response for debugging
        log("API Response: ${response.data}");

        return articles.map((e) => ArticleDataModel.fromJson(e)).toList();
      } else {
        log("Failed to fetch articles: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      log("Error fetching articles: $e");
      return [];
    }
  }
}
