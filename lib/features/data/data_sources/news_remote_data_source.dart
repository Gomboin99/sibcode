
import 'package:sibcode/core/error/exception.dart';
import 'package:dio/dio.dart';

import '../models/news_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<NewsModel>> getAllNews();
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  NewsRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<List<NewsModel>> getAllNews() => _getNewsFromUrl(
        'https://webstripe.ru/list.json',
      );

  Future<List<NewsModel>> _getNewsFromUrl(String url) async {
    final response = await dio.get(
      url,
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );
    if (response.statusCode == 200) {
      final news = response.data;

      return (news['news'] as List)
          .map((news) => NewsModel.fromJson(news))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
