abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}

class AuthRegistrationSuccess extends AuthState {
  final String message;

  AuthRegistrationSuccess(this.message);
}
