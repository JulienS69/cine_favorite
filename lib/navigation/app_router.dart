import 'package:auto_route/auto_route.dart';
import 'package:cine_favorite/navigation/auto_tabs_navigator.dart';
import 'package:cine_favorite/views/favorite/favorite_screen.dart';
import 'package:cine_favorite/views/movie/movie_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AutoTabsNavigatorRoute.page, initial: true, children: [
          AutoRoute(
            page: MovieRoute.page,
          ),
          AutoRoute(
            page: FavoriteRoute.page,
          ),
        ])
      ];
}
