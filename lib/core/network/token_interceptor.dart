import 'package:chat_mobile/core/auth/token_refresh_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TokenInterceptor extends Interceptor {
  final Dio _dio;
  final TokenRefreshService _tokenRefreshService;

  TokenInterceptor({
    required Dio dio,
    required TokenRefreshService tokenRefreshService,
  }) : _dio = dio,
       _tokenRefreshService = tokenRefreshService;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip token if the request explicitly doesn't require auth
    debugPrint(
      '[TokenInterceptor] Request requiresAuth: ${options.extra['requiresAuth']}',
    );

    if (options.extra['requiresAuth'] == false) {
      return handler.next(options);
    }

    final accessToken = await _tokenRefreshService.getAccessToken();
    debugPrint('[TokenInterceptor] Access Token: $accessToken');
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Try to refresh the token
      final success = await _tokenRefreshService.refreshToken();

      if (success) {
        // Token refreshed successfully, retry the original request
        final accessToken = await _tokenRefreshService.getAccessToken();
        final options = err.requestOptions;
        options.headers['Authorization'] = 'Bearer $accessToken';

        try {
          final response = await _dio.fetch(options);
          return handler.resolve(response);
        } on DioException catch (e) {
          return handler.next(e);
        }
      }
    }

    return handler.next(err);
  }
}
