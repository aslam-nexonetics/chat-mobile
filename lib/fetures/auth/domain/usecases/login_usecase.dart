import 'package:chat_mobile/core/errors/failures.dart';
import 'package:chat_mobile/fetures/auth/data/models/login_params.dart';
import 'package:chat_mobile/fetures/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUserUsecase {
  final AuthRepository repository;

  LoginUserUsecase(this.repository);
  Future<Either<Failure, bool>> call(LoginUserParams params) {
    return repository.loginUser(params);
  }
}
