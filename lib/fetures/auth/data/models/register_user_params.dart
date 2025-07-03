class RegisterUserParams {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String userName;
  final String password;

  RegisterUserParams({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.userName,
    required this.password,
  });
  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'email': email,
      'username': userName,
      "timezone": "UTC",
      "language": "en",
      'password': password,
    };
  }
}
