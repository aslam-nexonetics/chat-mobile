import 'package:chat_mobile/core/errors/failures.dart';
import 'package:chat_mobile/fetures/user/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUserDetails();
  Future<Either<Failure, User>> refreshUserDetails();
  Stream<User?> observeUserDetails();
}
