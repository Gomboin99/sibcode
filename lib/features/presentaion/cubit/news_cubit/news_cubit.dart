import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sibcode/utils/app_const.dart';
import '../../../../core/error/failure.dart';
import '../../../domain/use_cases/get_all_news.dart';
import 'news_state.dart';



class NewsListCubit extends Cubit<NewsState> {
  NewsListCubit({required this.getAllNews}) : super(NewsInit());

  final GetAllNews getAllNews;

  Future<void> loadNews() async {
    if (state is NewsLoading) {
      return;
    }

    emit(NewsLoading());

    final failureOrPerson = await getAllNews();

    failureOrPerson.fold((error) => emit(NewsError(_mapFailureToMessage(error))), (character) {
      emit(NewsLoaded(character));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppConst.serverFailureMessage;
      case CacheFailure:
        return AppConst.cachedFailureMessage;
      default:
        return 'Unexpected Error';
    }
  }
}