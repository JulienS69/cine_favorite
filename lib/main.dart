import 'package:cine_favorite/core/helper/styles/app_theme.dart';
import 'package:cine_favorite/core/helper/utils.dart';
import 'package:cine_favorite/core/navigation/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  /// Instance of `AppRouter`
  final appRouter = AppRouter();

  @override
  Widget build(
    BuildContext context,
  ) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    initializeDateFormatting();
    return MaterialApp.router(
      title: 'Cine Favorite',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.config(),
      scaffoldMessengerKey: scaffoldMessengerKey,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr'),
        Locale('en'),
      ],
    );
  }
}
