import 'dart:async';
import 'package:chat_mobile/core/auth/token_manager.dart';
import 'package:chat_mobile/core/constents/api_constatnts.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TokenRefreshService {
  final TokenManager _tokenManager;
  final Dio _dio;
  bool _isRefreshing = false;

  TokenRefreshService({required TokenManager tokenManager, required Dio dio})
    : _tokenManager = tokenManager,
      _dio = dio;

  Completer<void>? _refreshCompleter;

  Future<bool> refreshToken() async {
    if (_isRefreshing) {
      await _refreshCompleter?.future;
      return await getAccessToken() != null;
    }

    _isRefreshing = true;
    _refreshCompleter = Completer();

    try {
      final refreshToken = await _tokenManager.getRefreshToken();
      if (refreshToken == null) {
        _refreshCompleter?.complete();
        _isRefreshing = false;
        return false;
      }

      final response = await _dio.post(
        ApiUrls.refreshToken,
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200) {
        await _tokenManager.saveTokens(
          response.data['access_token'],
          response.data['refresh_token'],
        );
        debugPrint(
          'Saved Access Token: ${await _tokenManager.getAccessToken()}',
        );
        _refreshCompleter?.complete();
        _isRefreshing = false;
        return true;
      }

      _refreshCompleter?.complete();
      _isRefreshing = false;
      return false;
    } catch (_) {
      _refreshCompleter?.complete();
      _isRefreshing = false;
      return false;
    }
  }

  Future<String?> getAccessToken() async {
    return _tokenManager.getAccessToken();
  }
}
