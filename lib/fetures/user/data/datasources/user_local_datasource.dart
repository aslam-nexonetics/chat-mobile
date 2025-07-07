import 'package:chat_mobile/core/storage/hive_storage.dart';
import 'package:chat_mobile/fetures/user/data/models/user_model.dart';
import 'package:flutter/material.dart';

abstract class UserLocalDataSource {
  Future<void> saveUserDetails(UserModel user);
  Future<void> clearUser();
  Future<UserModel?> getUserDetails();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final HiveStorage hiveStorage;

  UserLocalDataSourceImpl({required this.hiveStorage});

  static const String _userDetailsKey = 'USER_DETAILS';
  static const String _profileBox = HiveStorage.profileBox;

  @override
  Future<void> saveUserDetails(UserModel user) async {
    debugPrint('Saving user details: $user');
    await hiveStorage.put(_profileBox, _userDetailsKey, user);
  }

  @override
  Future<UserModel?> getUserDetails() async {
    final user = await hiveStorage.get(_profileBox, _userDetailsKey);
    if (user is UserModel) {
      return user;
    }
    return null;
  }

  @override
  Future<void> clearUser() async {
    await hiveStorage.delete(_profileBox, _userDetailsKey);
  }
}
