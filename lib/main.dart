import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sibcode/locator_service.dart' as di;
import 'package:sibcode/utils/router.dart';
import 'features/presentaion/cubit/news_cubit/news_cubit.dart';
import 'locator_service.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await initializeDateFormatting('ru_RU', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsListCubit>(
          create: (context) => sl<NewsListCubit>()..loadNews(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: PjRouter.router,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
        ),
      ),
    );
  }
}
