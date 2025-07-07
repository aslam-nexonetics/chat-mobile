import 'package:chat_mobile/fetures/user/domain/entities/user_entity.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

/// User model for data layer with Hive adapter
/// This model should be placed in the data layer
@HiveType(typeId: 1)
@JsonSerializable()
class UserModel extends HiveObject {
  UserModel({
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

  @HiveField(0)
  @JsonKey(name: 'id')
  final int id;

  @HiveField(1)
  @JsonKey(name: 'email')
  final String email;

  @HiveField(2)
  @JsonKey(name: 'username')
  final String username;

  @HiveField(3)
  @JsonKey(name: 'first_name')
  final String firstName;

  @HiveField(4)
  @JsonKey(name: 'last_name')
  final String lastName;

  @HiveField(5)
  @JsonKey(name: 'phone')
  final String phone;

  @HiveField(6)
  @JsonKey(name: 'timezone')
  final String timezone;

  @HiveField(7)
  @JsonKey(name: 'language')
  final String language;

  @HiveField(8)
  @JsonKey(name: 'full_name')
  final String fullName;

  @HiveField(9)
  @JsonKey(name: 'role')
  final String role;

  @HiveField(10)
  @JsonKey(name: 'status')
  final String status;

  @HiveField(11)
  @JsonKey(name: 'is_email_verified')
  final bool isEmailVerified;

  @HiveField(12)
  @JsonKey(name: 'is_phone_verified')
  final bool isPhoneVerified;

  @HiveField(13)
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @HiveField(14)
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @HiveField(15)
  @JsonKey(name: 'last_login_at')
  final DateTime? lastLoginAt;

  @HiveField(16)
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;

  /// Factory constructor for creating UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Method to convert UserModel to JSON
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  /// Convert model to domain entity
  User toEntity() {
    return User(
      id: id,
      email: email,
      username: username,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      timezone: timezone,
      language: language,
      fullName: fullName,
      role: role,
      status: status,
      isEmailVerified: isEmailVerified,
      isPhoneVerified: isPhoneVerified,
      createdAt: createdAt,
      updatedAt: updatedAt,
      lastLoginAt: lastLoginAt,
      avatarUrl: avatarUrl,
    );
  }

  /// Create model from domain entity
  factory UserModel.fromEntity(User entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      username: entity.username,
      firstName: entity.firstName,
      lastName: entity.lastName,
      phone: entity.phone,
      timezone: entity.timezone,
      language: entity.language,
      fullName: entity.fullName,
      role: entity.role,
      status: entity.status,
      isEmailVerified: entity.isEmailVerified,
      isPhoneVerified: entity.isPhoneVerified,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      lastLoginAt: entity.lastLoginAt,
      avatarUrl: entity.avatarUrl,
    );
  }

  /// Copy with method for creating modified copies
  UserModel copyWith({
    int? id,
    String? email,
    String? username,
    String? firstName,
    String? lastName,
    String? phone,
    String? timezone,
    String? language,
    String? fullName,
    String? role,
    String? status,
    bool? isEmailVerified,
    bool? isPhoneVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLoginAt,
    String? avatarUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      timezone: timezone ?? this.timezone,
      language: language ?? this.language,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      status: status ?? this.status,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel &&
        other.id == id &&
        other.email == email &&
        other.username == username &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.phone == phone &&
        other.timezone == timezone &&
        other.language == language &&
        other.fullName == fullName &&
        other.role == role &&
        other.status == status &&
        other.isEmailVerified == isEmailVerified &&
        other.isPhoneVerified == isPhoneVerified &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.lastLoginAt == lastLoginAt &&
        other.avatarUrl == avatarUrl;
  }

  @override
  int get hashCode {
    return Object.hash(
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
    );
  }

  @override
  String toString() {
    return 'UserModel('
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
