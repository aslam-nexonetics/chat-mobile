import 'package:chat_mobile/fetures/user/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

enum UserStatus { initial, loading, loaded, error }

class UserState extends Equatable {
  final User? user;
  final UserStatus status;
  final String? error;

  const UserState({this.user, this.status = UserStatus.initial, this.error});

  UserState copyWith({User? user, UserStatus? status, String? error}) {
    return UserState(
      user: user ?? this.user,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [user, status, error];
}
