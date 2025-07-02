import 'package:chat_mobile/core/network/dio_interceptors.dart';
import 'package:chat_mobile/core/network/token_interceptor.dart';
import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient({required this.dio, required TokenInterceptor tokenInterceptor}) {
    // Add interceptors in the correct order
    dio.interceptors.addAll([LoggerInterceptor(), tokenInterceptor]);
  }

  // GET METHOD
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    bool requiresAuth = true, // Default to requiring auth
  }) async {
    try {
      final Response response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: _prepareOptions(options, requiresAuth),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // POST METHOD
  Future<Response> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool requiresAuth = true, // Default to requiring auth
  }) async {
    try {
      final Response response = await dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: _prepareOptions(options, requiresAuth),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PUT METHOD
  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool requiresAuth = true, // Default to requiring auth
  }) async {
    try {
      final Response response = await dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: _prepareOptions(options, requiresAuth),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // DELETE METHOD
  Future<Response> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool requiresAuth = true, // Default to requiring auth
  }) async {
    try {
      final Response response = await dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: _prepareOptions(options, requiresAuth),
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Helper method to prepare options with auth flag
  Options _prepareOptions(Options? options, bool requiresAuth) {
    final opts = options ?? Options();
    final Map<String, dynamic> extraMap = Map<String, dynamic>.from(
      opts.extra ?? {},
    );
    extraMap['requiresAuth'] = requiresAuth;
    return opts.copyWith(extra: extraMap);
  }
}
