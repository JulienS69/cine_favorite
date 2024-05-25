import 'package:cine_favorite/helper/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for Dio instance
final tmdbHttpClientProvider = Provider<Dio>(
  (ref) {
    return getDioClient();
  },
);
