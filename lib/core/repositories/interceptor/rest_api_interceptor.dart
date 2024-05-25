import 'package:cine_favorite/core/repositories/interceptor/interceptor_logger.dart';
import 'package:dio/dio.dart';

class RestApiInterceptor extends Interceptor {
  RestApiInterceptor();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    showLogOnRequest(options: options);
    //PRIVATE TOKEN HERE
    String currentApiKey = "";
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
