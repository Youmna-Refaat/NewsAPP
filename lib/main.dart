import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:news_app/views/home_view.dart';

void main() {
  runApp(const NewsApp());
}

final Dio dio = Dio();

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
