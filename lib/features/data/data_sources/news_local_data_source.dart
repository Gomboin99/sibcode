import 'dart:convert';

import 'package:sibcode/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/app_const.dart';
import '../models/news_model.dart';

abstract class NewsLocalDataSource {
  Future<List<NewsModel>> getNewsFromCache();

  Future<void> newsToCache(List<NewsModel> news);
}



class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  NewsLocalDataSourceImpl({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Future<List<NewsModel>> getNewsFromCache() {
    final jsonNewsList =
        sharedPreferences.getStringList(AppConst.cachedNewsList);
    if (jsonNewsList!.isNotEmpty) {
      return Future.value(jsonNewsList
          .map((news) => NewsModel.fromJson(json.decode(news)))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> newsToCache(List<NewsModel> news) {
    final List<String> jsonNewsList =
        news.map((news) => json.encode(news.toJson())).toList();
    sharedPreferences.setStringList(AppConst.cachedNewsList, jsonNewsList);

    return Future.value();
  }
  
}
