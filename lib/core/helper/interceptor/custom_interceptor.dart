import 'package:cine_favorite/core/helper/interceptor/interceptor_logger.dart';
import 'package:dio/dio.dart';

class CustomInterceptor extends Interceptor {
  CustomInterceptor();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    showLogOnRequest(options: options);
    //PRIVATE TOKEN HERE
    String currentApiKey =
        "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMzg0YmIyMDM3YTc1ODc3NjBmYjhmYzkxNmRjNjU2YiIsInN1YiI6IjY2NTA3MzFiYWJkODlmMjA4N2VjNGMyOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.BuWPKF2xS6UHIp6goMHICVjTpBqtZDhhM_U-hNGSLCE";
    options.headers["Authorization"] = 'Bearer $currentApiKey';
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    showLogOnResponse(response: response);
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      kickoutUser('ERROR API');
    }
    showLogOnError(err: err);
    super.onError(err, handler);
  }

  kickoutUser(String message) async {
    //TODO REDIRECT TO LOGIN PAGE WITH SNACKBAR
  }
}
