import 'package:dartz/dartz.dart';
import 'package:sibcode/core/error/exception.dart';
import 'package:sibcode/core/error/failure.dart';
import 'package:sibcode/core/platform/network_info.dart';
import 'package:sibcode/features/data/data_sources/news_local_data_source.dart';
import 'package:sibcode/features/data/data_sources/news_remote_data_source.dart';

import '../../domain/entities/news_entitiy.dart';
import '../../domain/repositories/news_repository.dart';
import '../models/news_model.dart';

class NewsRepositoryImpl implements NewsRepository {
  const NewsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<NewsEntity>>> getAllNews() async {
    return await _getNews(() => remoteDataSource.getAllNews());
  }

  Future<Either<Failure, List<NewsModel>>> _getNews(
      Future<List<NewsModel>> Function() getNews) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteNews = await getNews();
        await localDataSource.newsToCache(remoteNews);
        return Right(remoteNews);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final locationNews = await localDataSource.getNewsFromCache();
        return Right(locationNews);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}

