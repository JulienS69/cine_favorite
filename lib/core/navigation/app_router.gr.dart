// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AutoTabsNavigatorRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AutoTabsNavigatorScreen(),
      );
    },
    FavoriteRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FavoriteScreen(),
      );
    },
    MovieRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MovieScreen(),
      );
    },
    ProfilRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfilScreen(),
      );
    },
  };
}

/// generated route for
/// [AutoTabsNavigatorScreen]
class AutoTabsNavigatorRoute extends PageRouteInfo<void> {
  const AutoTabsNavigatorRoute({List<PageRouteInfo>? children})
      : super(
          AutoTabsNavigatorRoute.name,
          initialChildren: children,
        );

  static const String name = 'AutoTabsNavigatorRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FavoriteScreen]
class FavoriteRoute extends PageRouteInfo<void> {
  const FavoriteRoute({List<PageRouteInfo>? children})
      : super(
          FavoriteRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoriteRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MovieScreen]
class MovieRoute extends PageRouteInfo<void> {
  const MovieRoute({List<PageRouteInfo>? children})
      : super(
          MovieRoute.name,
          initialChildren: children,
        );

  static const String name = 'MovieRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfilScreen]
class ProfilRoute extends PageRouteInfo<void> {
  const ProfilRoute({List<PageRouteInfo>? children})
      : super(
          ProfilRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfilRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
