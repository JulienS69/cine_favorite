import 'package:auto_route/auto_route.dart';
import 'package:cine_favorite/core/helper/utils.dart';
import 'package:cine_favorite/core/navigation/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AutoTabsNavigatorScreen extends StatelessWidget {
  const AutoTabsNavigatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        MovieRoute(),
        FavoriteRoute(),
        ProfilRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: false,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Theme.of(context).hintColor,
            currentIndex: tabsRouter.activeIndex,
            items: itemsBottomNavigation,
            onTap: (value) {
              tabsRouter.setActiveIndex(value);
            },
          ),
          body: child,
        );
      },
    );
  }
}
