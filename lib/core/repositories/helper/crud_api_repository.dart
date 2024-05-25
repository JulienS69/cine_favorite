import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';

abstract class RestApiRepository {
  final dio.Dio client;
  @protected
  final String _mainRoute;

  String get controller => _mainRoute;

  RestApiRepository({
    required String mainRoute,
    required this.client,
  }) : _mainRoute = mainRoute;

  Future<Either<dynamic, dynamic>> handlingGetResponse({
    required String queryRoute,
    Map<String, dynamic>? queryParameters,
    bool? showError = true,
    bool? showSuccess = true,
    bool? isCustomResponse = false,
    String? overrideSuccessMessage,
    String? overrideErrorMessage,
    dio.ResponseType? responseType,
    dio.Options? options,
    Map<String, String>? header,
    String? contentType,
  }) async {
    try {
      dio.Response response = await client.get(
        queryRoute,
        queryParameters: queryParameters,
        options: options ??
            dio.Options(
              headers: header,
              responseType: responseType ?? dio.ResponseType.json,
              contentType: contentType,
            ),
      );
      return _verifError(
        response: response,
        showError: showError!,
        showSuccess: showSuccess!,
        overrideSuccessMessage: overrideSuccessMessage,
        overrideErrorMessage: overrideErrorMessage,
      );
    } on dio.DioException catch (exception, stackTrace) {
      if (exception.response != null) {
        return _verifError(
          response: exception.response!,
          showError: showError!,
          showSuccess: showSuccess!,
          overrideSuccessMessage: overrideSuccessMessage,
          overrideErrorMessage: overrideErrorMessage,
        );
      }
      return left(stackTrace.toString());
    } catch (exception) {
      log('\x1B[31m$exception');
      return left(exception.toString());
    }
  }

  Future<Either<dynamic, dynamic>> handlingPostResponse({
    required String queryRoute,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? header,
    bool? showError = true,
    bool? showSuccess = true,
    String? overrideSuccessMessage,
    String? overrideErrorMessage,
  }) async {
    try {
      dio.Response response = await client.post(
        queryRoute,
        options: dio.Options(
          headers: header,
          validateStatus: (status) =>
              status != null && (status >= 200 && status < 300) ||
              status == 422,
        ),
        queryParameters: queryParameters,
        data: body,
      );

      return _verifError(
        response: response,
        showError: showError!,
        showSuccess: showSuccess!,
        overrideSuccessMessage: overrideSuccessMessage,
        overrideErrorMessage: overrideErrorMessage,
      );
    } on dio.DioException catch (exception) {
      log("\x1B[31mDIO EXCEPTION : $exception");
      if (exception.response == null) {
        return left("Response is null");
      }
      return _verifError(
        response: exception.response!,
        showError: showError!,
        showSuccess: showSuccess!,
        overrideSuccessMessage: overrideSuccessMessage,
        overrideErrorMessage: overrideErrorMessage,
      );
    } catch (exception, stackTrace) {
      log('\x1B[31m$exception');
      return left(stackTrace.toString());
    }
  }

  // Check if the response contains errors, return an Either accordingly
  Either<dynamic, dynamic> _verifError({
    required dio.Response response,
    required bool showError,
    required bool showSuccess,
    String? overrideSuccessMessage,
    String? overrideErrorMessage,
  }) {
    // 520 code used for responses unauthentified
    bool isSuccess = (response.statusCode ?? 520) >= 200 &&
        (response.statusCode ?? 520) <= 206;
    try {
      if (isSuccess) {
        return right(response.data);
      } else {
        return left(response.data);
      }
    } catch (exception) {
      log('\x1B[31m$exception');
      String failure = 'restApiRequestException';
      return left(failure);
    }
  }
}
