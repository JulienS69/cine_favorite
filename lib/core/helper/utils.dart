import 'package:cine_favorite/core/helper/interceptor/custom_interceptor.dart';
import 'package:cine_favorite/core/helper/styles/app_colors.dart';
import 'package:cine_favorite/core/helper/styles/app_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//SECTION LOTTIES
const String notFoundLottie = 'assets/lotties/not_found.json';
const String errorLottie = 'assets/lotties/error.json';
const String emptyLottie = 'assets/lotties/empty.json';

//CUSTOM DIO CLIENT WITH CUSTOM INTERCEPTOR
Dio getDioClient() {
  final client = Dio();
  client.options.baseUrl = 'https://api.themoviedb.org/3';
  client.options.receiveTimeout = const Duration(seconds: 15);
  client.options.sendTimeout = const Duration(seconds: 15);
  client.options.connectTimeout = const Duration(seconds: 15);
  client.options.headers["Accept"] = "application/json";
  client.options.contentType = 'application/json; charset=utf-8';
  client.interceptors.add(
    CustomInterceptor(),
  );
  return client;
}

// GLOBAL KEY USED IN MAIN.DART FOR GETTING CONTEXT EVERYWHERE WHEN SHOWING SNACKBAR
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

// ITEMS OF BOTTOM BAR
List<BottomNavigationBarItem> itemsBottomNavigation = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.movie_outlined),
    label: 'Films',
  ),
  const BottomNavigationBarItem(
      icon: Icon(Icons.favorite_outline), label: 'Favoris'),
  const BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Profil'),
];

// APP BAR CUSTOM USES IN MULTIPLES PLACE ON PROJECT
PreferredSizeWidget getAppBar({required String title}) {
  return AppBar(
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    ),
    title: Text(
      title,
      style: AppTextStyles.title.copyWith(color: AppColors.white),
    ),
  );
}

enum SnackStatusEnum { success, error, update, warning, simple }

// METHOD FOR GETTING SNACKBAR SIMPLY WITH DIFFERENTS OPTIONS
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackbar(
    String message, SnackStatusEnum snackStatusEnum) {
  SnackBar snackBar;

  switch (snackStatusEnum) {
    case SnackStatusEnum.success:
      snackBar = SnackBar(
        content: Text(message),
        backgroundColor:
            const Color.fromARGB(255, 87, 215, 73).withOpacity(0.9),
      );
      break;
    case SnackStatusEnum.error:
      snackBar = SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.withOpacity(0.9),
      );
      break;
    case SnackStatusEnum.update:
      snackBar = SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue.withOpacity(0.9),
      );
      break;
    case SnackStatusEnum.warning:
      snackBar = SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange.withOpacity(0.9),
      );
      break;
    case SnackStatusEnum.simple:
    default:
      snackBar = SnackBar(
        content: Text(message),
        backgroundColor: Colors.grey.withOpacity(0.9),
      );
      break;
  }
  return scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
}

// FOR CAPITALIZE FIRST LETTER OF STRING
extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

// FORMAT THE DATE TO EXAMPLE Mercredi 10 Avril 2024
extension DateFormatting on String {
  String toFormattedDate() {
    if (isEmpty) return "Date not available";
    DateTime selectedDate = DateTime.parse(this);
    return DateFormat('EEEE d MMMM yyyy', 'fr_FR')
        .format(selectedDate)
        .capitalize();
  }
}
