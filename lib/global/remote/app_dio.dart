import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:ua_client_hints/ua_client_hints.dart';

class AppDio with DioMixin implements Dio {
  AppDio._([BaseOptions? options]) {
    options = BaseOptions(
      responseType: ResponseType.json,
      contentType: 'application/json',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    );

    this.options = options;
    interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.headers.addAll(await userAgentClientHintsHeader());
        return handler.next(options);
      },
    ));

    if (kDebugMode) {
      interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 80,
      ));
    }

    httpClientAdapter = HttpClientAdapter();
  }

  static AppDio getInstance() => AppDio._();
}
