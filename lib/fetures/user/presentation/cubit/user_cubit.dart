import 'dart:async';
import 'dart:developer';

import 'package:chat_mobile/fetures/user/domain/repositories/user_repository.dart';
import 'package:chat_mobile/fetures/user/presentation/cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;
  StreamSubscription? _userSubscription;

  UserCubit({required this.userRepository}) : super(const UserState()) {
    // Subscribe to user changes
    _userSubscription = userRepository.observeUserDetails().listen(
      (user) {
        if (user != null) {
          emit(state.copyWith(user: user, status: UserStatus.loaded));
        } else {
          emit(state.copyWith(user: null, status: UserStatus.initial));
        }
      },
      onError: (error) {
        emit(state.copyWith(error: error.toString(), status: UserStatus.error));
      },
    );
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // Log errors with your preferred error reporting service
    log('Error in OnboardingBloc: $error');
    super.onError(error, stackTrace);
  }

  Future<void> loadUser() async {
    debugPrint('Loading user...');
    emit(state.copyWith(status: UserStatus.loading));
    final result = await userRepository.getUserDetails();
    debugPrint('User loaded: ${result.toString()}');
    result.fold(
      (failure) => emit(
        state.copyWith(error: failure.message, status: UserStatus.error),
      ),
      (user) {
        // debugPrint('User loaded: ${user.toJson()}');
        emit(state.copyWith(user: user, status: UserStatus.loaded));
      },
    );
    refreshUser();
  }

  Future<void> refreshUser() async {
    debugPrint('refreshing user...');
    // emit(state.copyWith(status: UserStatus.loading));
    final result = await userRepository.refreshUserDetails();
    debugPrint('User refreshed: ${result.toString()}');
    result.fold(
      (failure) => emit(
        state.copyWith(error: failure.message, status: UserStatus.error),
      ),
      (user) => emit(state.copyWith(user: user, status: UserStatus.loaded)),
    );
  }
}
