
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sibcode/features/domain/entities/news_entitiy.dart';
import 'package:sibcode/features/presentaion/pages/auth_or_info_person.dart';
import 'package:sibcode/utils/app_const.dart';

import '../features/presentaion/pages/home_screen.dart';
import '../features/presentaion/pages/news_detail_screen.dart';
import '../locator_service.dart';

class PjRouter {
  static final router = GoRouter(
    initialLocation:
        sl<SharedPreferences>().getString(AppConst.numberPhone) == null
            ? '/'
            : '/home',
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const AuthOrInfoPerson(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
              path: 'detail',
              name: 'detail',
              builder: (context, state) {
                return NewsDetailScreen(
                  newsForDetail: state.extra as NewsEntity,
                );
              }),
        ],
      ),
    ],
  );
}
