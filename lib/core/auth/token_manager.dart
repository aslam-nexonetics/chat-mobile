import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  final FlutterSecureStorage _secureStorage;

  static const String _accessTokenKey = 'ACCESS_TOKEN';
  static const String _refreshTokenKey = 'REFRESH_TOKEN';

  TokenManager({FlutterSecureStorage? secureStorage})
    : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    try {
      debugPrint('[TokenManager] Saving access token...');
      await _secureStorage.write(key: _accessTokenKey, value: accessToken);
      debugPrint('[TokenManager] Access token saved.');

      debugPrint('[TokenManager] Saving refresh token...');
      await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
      debugPrint('[TokenManager] Refresh token saved.');
    } catch (e) {
      debugPrint('[TokenManager] Error saving tokens: $e');
    }
  }

  Future<String?> getAccessToken() async {
    try {
      debugPrint('[TokenManager] Reading access token...');
      final token = await _secureStorage.read(key: _accessTokenKey);
      debugPrint(
        '[TokenManager] Access token read: ${token != null ? '***' : 'null'}',
      );
      return token;
    } catch (e) {
      debugPrint('[TokenManager] Error reading access token: $e');
      await clearTokens();
      return null;
    }
  }

  Future<String?> getRefreshToken() async {
    try {
      debugPrint('[TokenManager] Reading refresh token...');
      final token = await _secureStorage.read(key: _refreshTokenKey);
      debugPrint(
        '[TokenManager] Refresh token read: ${token != null ? '***' : 'null'}',
      );
      return token;
    } catch (e) {
      debugPrint('[TokenManager] Error reading refresh token: $e');
      await clearTokens();
      return null;
    }
  }

  Future<void> clearTokens() async {
    try {
      debugPrint('[TokenManager] Clearing tokens...');
      await _secureStorage.delete(key: _accessTokenKey);
      await _secureStorage.delete(key: _refreshTokenKey);
      debugPrint('[TokenManager] Tokens cleared.');
    } catch (e) {
      debugPrint('[TokenManager] Error clearing tokens: $e');
      try {
        debugPrint('[TokenManager] Attempting to clear all secure storage...');
        await _secureStorage.deleteAll();
        debugPrint('[TokenManager] All secure storage cleared.');
      } catch (clearAllError) {
        debugPrint(
          '[TokenManager] Error clearing all secure storage: $clearAllError',
        );
      }
    }
  }
}
