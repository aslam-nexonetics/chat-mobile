abstract class AuthEvent {}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final String accessToken;

  LoggedIn(this.accessToken);
}

class LoggedOut extends AuthEvent {}

class LoginRequested extends AuthEvent {
  final String emailOrUsername;
  final String password;

  LoginRequested(this.emailOrUsername, this.password);
}

class RegisterRequested extends AuthEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String username;
  final String password;

  RegisterRequested({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.username,
    required this.password,
  });
}

class LogoutRequested extends AuthEvent {}

class AuthStatusChanged extends AuthEvent {
  final bool isAuthenticated;

  AuthStatusChanged(this.isAuthenticated);
}
