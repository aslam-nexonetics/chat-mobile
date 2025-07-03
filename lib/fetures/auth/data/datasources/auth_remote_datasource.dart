import 'package:chat_mobile/core/constents/api_constatnts.dart';
import 'package:chat_mobile/core/errors/failures.dart';
import 'package:chat_mobile/core/network/api_client.dart';
import 'package:chat_mobile/fetures/auth/data/models/login_params.dart';
import 'package:chat_mobile/fetures/auth/data/models/register_user_params.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, Response>> registerUser(RegisterUserParams params);
  Future<Either<Failure, Response>> loginUser(LoginUserParams params);
  Future<Either<Failure, Response>> logoutUser();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDatasourceImpl(this.apiClient);

  @override
  Future<Either<Failure, Response>> registerUser(
    RegisterUserParams params,
  ) async {
    try {
      final response = await apiClient.post(
        ApiUrls.register,
        data: params.toJson(),
      );
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Response>> loginUser(LoginUserParams params) async {
    try {
      final response = await apiClient.post(
        ApiUrls.login,
        data: params.toJson(),
      );
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Response>> logoutUser() async {
    try {
      final response = await apiClient.post(ApiUrls.logout);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
