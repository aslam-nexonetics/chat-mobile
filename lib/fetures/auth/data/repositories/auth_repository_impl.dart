import 'package:chat_mobile/core/auth/token_manager.dart';
import 'package:chat_mobile/core/errors/failures.dart';
import 'package:chat_mobile/core/network/network_info.dart';
import 'package:chat_mobile/fetures/auth/data/datasources/auth_remote_datasource.dart';
import 'package:chat_mobile/fetures/auth/data/models/login_params.dart';
import 'package:chat_mobile/fetures/auth/data/models/login_response.dart';
import 'package:chat_mobile/fetures/auth/data/models/register_user_params.dart';
import 'package:chat_mobile/fetures/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter/foundation.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final TokenManager tokenManager;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.tokenManager,
  });

  @override
  Future<Either<Failure, bool>> registerUser(RegisterUserParams params) async {
    debugPrint('[AuthRepository] Register user started...');
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.registerUser(params);
        return result.fold(
          (failure) {
            debugPrint('[AuthRepository] Register failed: ${failure.message}');
            return Left(failure);
          },
          (response) {
            debugPrint(
              '[AuthRepository] Register response: ${response.statusCode}',
            );
            if (response.statusCode == 200 || response.statusCode == 201) {
              debugPrint('[AuthRepository] Registration successful');
              return Right(true);
            } else {
              debugPrint(
                '[AuthRepository] Registration failed with status: ${response.statusCode}',
              );
              return Left(ServerFailure(message: 'Registration failed'));
            }
          },
        );
      } catch (e) {
        debugPrint('[AuthRepository] Registration exception: $e');
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      debugPrint('[AuthRepository] No internet connection for register');
      return Left(NetworkFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> loginUser(LoginUserParams params) async {
    debugPrint('[AuthRepository] Login user started...');
    if (!await networkInfo.isConnected) {
      debugPrint('[AuthRepository] No internet connection for login');
      return Left(NetworkFailure(message: 'No internet connection'));
    }

    try {
      final result = await remoteDataSource.loginUser(params);
      return result.fold(
        (failure) {
          debugPrint('[AuthRepository] Login failed: ${failure.message}');
          return Left(failure);
        },
        (response) {
          debugPrint('[AuthRepository] Login response: ${response.statusCode}');
          if (response.statusCode == 200) {
            final loginResponse = LoginResponseModel.fromJson(response.data);
            debugPrint('[AuthRepository] Login successful, saving tokens...');
            tokenManager.saveTokens(
              loginResponse.accessToken,
              loginResponse.refreshToken,
            );
            return Right(true);
          } else {
            debugPrint(
              '[AuthRepository] Login failed with status: ${response.statusCode}',
            );
            return Left(ServerFailure(message: 'Login failed'));
          }
        },
      );
    } catch (e) {
      debugPrint('[AuthRepository] Login exception: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logoutUser() async {
    debugPrint('[AuthRepository] Logout user started...');
    if (!await networkInfo.isConnected) {
      debugPrint('[AuthRepository] No internet connection for logout');
      return Left(NetworkFailure(message: 'No internet connection'));
    }

    try {
      final result = await remoteDataSource.logoutUser();
      return result.fold(
        (failure) {
          debugPrint('[AuthRepository] Logout failed: ${failure.message}');
          return Left(failure);
        },
        (response) {
          debugPrint(
            '[AuthRepository] Logout response: ${response.statusCode}',
          );
          if (response.statusCode == 200) {
            debugPrint(
              '[AuthRepository] Logout successful, clearing tokens...',
            );
            tokenManager.clearTokens();
            return Right(true);
          } else {
            debugPrint(
              '[AuthRepository] Logout failed with status: ${response.statusCode}',
            );
            return Left(ServerFailure(message: 'Logout failed'));
          }
        },
      );
    } catch (e) {
      debugPrint('[AuthRepository] Logout exception: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
