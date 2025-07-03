import 'package:chat_mobile/core/errors/failures.dart';
import 'package:chat_mobile/fetures/auth/data/models/login_params.dart';
import 'package:chat_mobile/fetures/auth/data/models/register_user_params.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> registerUser(RegisterUserParams params);
  Future<Either<Failure, bool>> loginUser(LoginUserParams params);
  Future<Either<Failure, bool>> logoutUser();
}
