import 'package:chat_mobile/core/errors/failures.dart';
import 'package:chat_mobile/fetures/auth/data/models/register_user_params.dart';
import 'package:chat_mobile/fetures/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class RegisterUserUsecase {
  final AuthRepository repository;

  RegisterUserUsecase(this.repository);
  Future<Either<Failure, bool>> call(RegisterUserParams params) {
    return repository.registerUser(params);
  }
}
