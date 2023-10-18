import 'package:equatable/equatable.dart';

import '../../../domain/entities/news_entitiy.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInit extends NewsState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class NewsLoading extends NewsState {

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class NewsLoaded extends NewsState {
  const NewsLoaded(this.newsList);

  final List<NewsEntity> newsList;

  @override
  // TODO: implement props
  List<Object> get props => [newsList];
}

class NewsError extends NewsState {
  const NewsError(this.message);

  final String message;
}