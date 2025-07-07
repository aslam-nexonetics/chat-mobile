// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as int,
      email: fields[1] as String,
      username: fields[2] as String,
      firstName: fields[3] as String,
      lastName: fields[4] as String,
      phone: fields[5] as String,
      timezone: fields[6] as String,
      language: fields[7] as String,
      fullName: fields[8] as String,
      role: fields[9] as String,
      status: fields[10] as String,
      isEmailVerified: fields[11] as bool,
      isPhoneVerified: fields[12] as bool,
      createdAt: fields[13] as DateTime,
      updatedAt: fields[14] as DateTime,
      lastLoginAt: fields[15] as DateTime?,
      avatarUrl: fields[16] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.firstName)
      ..writeByte(4)
      ..write(obj.lastName)
      ..writeByte(5)
      ..write(obj.phone)
      ..writeByte(6)
      ..write(obj.timezone)
      ..writeByte(7)
      ..write(obj.language)
      ..writeByte(8)
      ..write(obj.fullName)
      ..writeByte(9)
      ..write(obj.role)
      ..writeByte(10)
      ..write(obj.status)
      ..writeByte(11)
      ..write(obj.isEmailVerified)
      ..writeByte(12)
      ..write(obj.isPhoneVerified)
      ..writeByte(13)
      ..write(obj.createdAt)
      ..writeByte(14)
      ..write(obj.updatedAt)
      ..writeByte(15)
      ..write(obj.lastLoginAt)
      ..writeByte(16)
      ..write(obj.avatarUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      username: json['username'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      phone: json['phone'] as String,
      timezone: json['timezone'] as String,
      language: json['language'] as String,
      fullName: json['full_name'] as String,
      role: json['role'] as String,
      status: json['status'] as String,
      isEmailVerified: json['is_email_verified'] as bool,
      isPhoneVerified: json['is_phone_verified'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      lastLoginAt: json['last_login_at'] == null
          ? null
          : DateTime.parse(json['last_login_at'] as String),
      avatarUrl: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone': instance.phone,
      'timezone': instance.timezone,
      'language': instance.language,
      'full_name': instance.fullName,
      'role': instance.role,
      'status': instance.status,
      'is_email_verified': instance.isEmailVerified,
      'is_phone_verified': instance.isPhoneVerified,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'last_login_at': instance.lastLoginAt?.toIso8601String(),
      'avatar_url': instance.avatarUrl,
    };
