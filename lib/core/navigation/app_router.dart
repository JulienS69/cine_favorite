import 'package:auto_route/auto_route.dart';
import 'package:cine_favorite/core/navigation/auto_tabs_navigator.dart';
import 'package:cine_favorite/presentation/screens/favorite/favorite_screen.dart';
import 'package:cine_favorite/presentation/screens/movie/movie_screen.dart';
import 'package:cine_favorite/presentation/screens/profil/profil_screen.dart';

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
          AutoRoute(
            page: ProfilRoute.page,
          ),
        ])
      ];
}
