import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sibcode/core/platform/network_info.dart';
import 'package:sibcode/features/data/data_sources/news_local_data_source.dart';
import 'package:sibcode/features/data/data_sources/news_remote_data_source.dart';
import 'package:sibcode/features/data/repositories/news_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import 'features/domain/repositories/news_repository.dart';
import 'features/domain/use_cases/get_all_news.dart';
import 'features/presentaion/cubit/news_cubit/news_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Bloc
  sl.registerFactory(
    () => NewsListCubit(getAllNews: sl()),
  );
  //UseCase
  sl.registerLazySingleton(() => GetAllNews(sl()));
  //Repository
  sl.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<NewsRemoteDataSource>(
      () => NewsRemoteDataSourceImpl(
            dio: Dio(),
          ));
  sl.registerLazySingleton<NewsLocalDataSource>(
      () => NewsLocalDataSourceImpl(sharedPreferences: sl()));
  //Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  //External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
