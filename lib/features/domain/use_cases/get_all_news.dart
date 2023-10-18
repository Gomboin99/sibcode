import 'package:dartz/dartz.dart';
import 'package:sibcode/core/use_cases/use_case.dart';
import '../../../core/error/failure.dart';
import '../entities/news_entitiy.dart';
import '../repositories/news_repository.dart';

class GetAllNews extends UseCase<List<NewsEntity>> {

  GetAllNews(this.newsRepository);

  final NewsRepository newsRepository;

  @override
  Future<Either<Failure, List<NewsEntity>>> call () async {
    return await newsRepository.getAllNews();
  }
}

