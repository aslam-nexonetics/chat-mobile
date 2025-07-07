import 'dart:developer';

import 'package:chat_mobile/core/errors/exceptions.dart';
import 'package:chat_mobile/core/errors/failures.dart';
import 'package:chat_mobile/core/network/network_info.dart';
import 'package:chat_mobile/fetures/user/data/datasources/user_local_datasource.dart';
import 'package:chat_mobile/fetures/user/data/datasources/user_remote_datasource.dart';
import 'package:chat_mobile/fetures/user/data/models/user_model.dart';
import 'package:chat_mobile/fetures/user/domain/entities/user_entity.dart';
import 'package:chat_mobile/fetures/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  // Stream controller to broadcast user changes
  final _userStreamController = BehaviorSubject<User?>();

  // Cache duration constant
  static const Duration _cacheDuration = Duration(minutes: 5);

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  }) {
    _initializeUserStream();
  }

  void _initializeUserStream() {
    localDataSource.getUserDetails().then((user) {
      if (user != null) {
        _userStreamController.add(user.toEntity());
      }
    });
  }

  @override
  Future<Either<Failure, User>> getUserDetails() async {
    try {
      final localUser = await _getLocalUser();

      if (localUser != null && !_isLocalDataStale(localUser)) {
        _userStreamController.add(localUser);
        return Right(localUser);
      }

      if (await networkInfo.isConnected) {
        return refreshUserDetails();
      }

      // If offline and have stale data, return it with a warning
      if (localUser != null) {
        return Right(localUser);
      }

      return const Left(CacheFailure(message: 'No user data available'));
    } catch (e) {
      log('Error getting user details: $e');
      return Left(CacheFailure(message: e.toString()));
    }
  }

  bool _isLocalDataStale(User user) {
    if (user.updatedAt == null) return true;
    return DateTime.now().difference(user.updatedAt!) > _cacheDuration;
  }

  Future<User?> _getLocalUser() async {
    try {
      final userModel = await localDataSource.getUserDetails();
      return userModel?.toEntity();
    } catch (e) {
      log('Error getting local user: $e');
      return null;
    }
  }

  @override
  Future<Either<Failure, User>> refreshUserDetails() async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(message: 'No internet connection'));
    }

    try {
      final response = await remoteDataSource.getUserDetails();
      return response.fold(
        (failure) => _handleRemoteFailure(failure),
        (apiResponse) => _handleRemoteSuccess(apiResponse),
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      log('Error refreshing user details: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, User>> _handleRemoteFailure(Failure failure) async {
    final localUser = await _getLocalUser();
    if (localUser != null) {
      return Right(localUser);
    }
    return Left(failure);
  }

  Future<Either<Failure, User>> _handleRemoteSuccess(
    Response apiResponse,
  ) async {
    if (apiResponse.statusCode != 200) {
      return Left(
        ServerFailure(message: "Failed to get user data from server"),
      );
    }

    try {
      final user = UserModel.fromJson(apiResponse.data);
      await _saveUserAndNotify(user);
      return Right(user.toEntity());
    } catch (e) {
      log('Error parsing user data: $e');
      return Left(ServerFailure(message: 'Failed to parse response'));
    }
  }

  Future<void> _saveUserAndNotify(UserModel user) async {
    await localDataSource.saveUserDetails(user);
    _userStreamController.add(user.toEntity());
  }

  @override
  Stream<User?> observeUserDetails() {
    return _userStreamController.stream;
  }
}
