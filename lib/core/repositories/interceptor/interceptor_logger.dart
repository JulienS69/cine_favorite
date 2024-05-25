import 'dart:developer';

import 'package:dio/dio.dart';

showLogOnRequest({required RequestOptions options}) {
  log('\x1B[36mREQUEST[${options.method}] => PATH: ${options.path}\x1B[0m');
  if (options.queryParameters.isNotEmpty) {
    log('\x1B[93mQUERYPARAMS => ${options.queryParameters}\x1B[0m');
  }
}

showLogOnResponse({required Response response}) {
  log('\x1B[92mRESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.baseUrl} -- ${response.requestOptions.path}\x1B[0m');
}

showLogOnError({required DioException err}) {
  log('\x1B[91mERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.baseUrl} -- ${err.requestOptions.path}\x1B[0m');
  log('\x1B[91mRESPONSE[${err.response?.data}]\x1B[0m');
}
