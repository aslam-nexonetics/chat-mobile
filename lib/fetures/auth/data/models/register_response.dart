import 'package:equatable/equatable.dart';

class RegisterResponseModel extends Equatable {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String phone;
  final String timezone;
  final String language;
  final int id;
  final String fullName;
  final String role;
  final String status;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final DateTime lastLoginAt;
  final String avatarUrl;

  const RegisterResponseModel({
    required this.createdAt,
    required this.updatedAt,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.timezone,
    required this.language,
    required this.id,
    required this.fullName,
    required this.role,
    required this.status,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    required this.lastLoginAt,
    required this.avatarUrl,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      email: json['email'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
      timezone: json['timezone'],
      language: json['language'],
      id: json['id'],
      fullName: json['full_name'],
      role: json['role'],
      status: json['status'],
      isEmailVerified: json['is_email_verified'],
      isPhoneVerified: json['is_phone_verified'],
      lastLoginAt: DateTime.parse(json['last_login_at']),
      avatarUrl: json['avatar_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'email': email,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'timezone': timezone,
      'language': language,
      'id': id,
      'full_name': fullName,
      'role': role,
      'status': status,
      'is_email_verified': isEmailVerified,
      'is_phone_verified': isPhoneVerified,
      'last_login_at': lastLoginAt.toIso8601String(),
      'avatar_url': avatarUrl,
    };
  }

  @override
  List<Object?> get props => [
    createdAt,
    updatedAt,
    email,
    username,
    firstName,
    lastName,
    phone,
    timezone,
    language,
    id,
    fullName,
    role,
    status,
    isEmailVerified,
    isPhoneVerified,
    lastLoginAt,
    avatarUrl,
  ];
}
