import 'package:equatable/equatable.dart';

/// User entity representing the core business logic model
/// This entity should be placed in the domain layer
class User extends Equatable {
  const User({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.timezone,
    required this.language,
    required this.fullName,
    required this.role,
    required this.status,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    required this.createdAt,
    required this.updatedAt,
    this.lastLoginAt,
    this.avatarUrl,
  });

  final int id;
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String phone;
  final String timezone;
  final String language;
  final String fullName;
  final String role;
  final String status;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastLoginAt;
  final String? avatarUrl;

  /// Check if user is active
  bool get isActive => status.toLowerCase() == 'active';

  /// Check if user is admin
  bool get isAdmin => role.toLowerCase().contains('admin');

  /// Check if user is super admin
  bool get isSuperAdmin => role.toLowerCase() == 'super_admin';

  /// Check if user is fully verified
  bool get isFullyVerified => isEmailVerified && isPhoneVerified;

  /// Get display name (full name or username)
  String get displayName => fullName.isNotEmpty ? fullName : username;

  @override
  List<Object?> get props => [
    id,
    email,
    username,
    firstName,
    lastName,
    phone,
    timezone,
    language,
    fullName,
    role,
    status,
    isEmailVerified,
    isPhoneVerified,
    createdAt,
    updatedAt,
    lastLoginAt,
    avatarUrl,
  ];

  @override
  String toString() {
    return 'User('
        'id: $id, '
        'email: $email, '
        'username: $username, '
        'firstName: $firstName, '
        'lastName: $lastName, '
        'phone: $phone, '
        'timezone: $timezone, '
        'language: $language, '
        'fullName: $fullName, '
        'role: $role, '
        'status: $status, '
        'isEmailVerified: $isEmailVerified, '
        'isPhoneVerified: $isPhoneVerified, '
        'createdAt: $createdAt, '
        'updatedAt: $updatedAt, '
        'lastLoginAt: $lastLoginAt, '
        'avatarUrl: $avatarUrl'
        ')';
  }
}
