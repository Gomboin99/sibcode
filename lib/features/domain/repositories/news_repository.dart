import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../entities/news_entitiy.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<NewsEntity>>> getAllNews();
}
