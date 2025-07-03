class LoginUserParams {
  final String emailOrUsername;
  final String password;

  LoginUserParams({required this.emailOrUsername, required this.password});

  Map<String, dynamic> toJson() {
    return {'email_or_username': emailOrUsername, 'password': password};
  }
}
