import 'package:chat_mobile/core/errors/failures.dart';
import 'package:chat_mobile/fetures/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutUserUsecase {
  final AuthRepository repository;

  LogoutUserUsecase(this.repository);

  Future<Either<Failure, bool>> call() {
    return repository.logoutUser();
  }
}
