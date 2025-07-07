import 'package:chat_mobile/core/constents/api_constatnts.dart';
import 'package:chat_mobile/core/errors/failures.dart';
import 'package:chat_mobile/core/network/api_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class UserRemoteDataSource {
  Future<Either<Failure, Response>> getUserDetails();
  // Future<bool> updateUserDetails(UserUpdateParams params);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiClient apiClient;

  UserRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<Either<Failure, Response>> getUserDetails() async {
    try {
      final response = await apiClient.get(ApiUrls.getCurrentUser);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: "Failed To get User data"));
    }
  }
}
