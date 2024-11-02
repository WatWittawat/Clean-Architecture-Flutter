import 'package:dio/dio.dart';

class NetworkService {
  final Dio _dio;

  NetworkService(this._dio);

  Future<Response> get(
    String url,
    String? token,
    Map<String, dynamic>? queryParams,
    Map<String, String>? header,
  ) async {
    try {
      return await _dio.get(
        url,
        queryParameters: queryParams,
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
            ...?header
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post<T extends Object?>(
    String url,
    T? data,
    String? token,
    Map<String, String>? header,
  ) async {
    try {
      return await _dio.post(url,
          data: data,
          options: Options(headers: {
            if (token != null) 'Authorization': 'Bearer $token',
            ...?header
          }));
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> patch<T extends Object?>(
    String url,
    T? data,
    String? token,
    Map<String, String>? header,
  ) async {
    try {
      return await _dio.patch(url,
          data: data,
          options: Options(headers: {
            if (token != null) 'Authorization': 'Bearer $token',
            ...?header
          }));
    } catch (e) {
      rethrow;
    }
  }
}
