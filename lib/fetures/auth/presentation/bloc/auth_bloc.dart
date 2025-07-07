import 'package:bloc/bloc.dart';
import 'package:chat_mobile/core/auth/token_manager.dart';
import 'package:chat_mobile/fetures/auth/data/models/login_params.dart';
import 'package:chat_mobile/fetures/auth/data/models/register_user_params.dart';
import 'package:chat_mobile/fetures/auth/domain/usecases/login_usecase.dart';
import 'package:chat_mobile/fetures/auth/domain/usecases/logout_usecase.dart';
import 'package:chat_mobile/fetures/auth/domain/usecases/register_usecase.dart';
import 'package:chat_mobile/fetures/user/presentation/cubit/user_cubit.dart';
import 'package:chat_mobile/service_locator.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final TokenManager tokenManager;
  final LoginUserUsecase loginUser;
  final RegisterUserUsecase registerUser;
  final LogoutUserUsecase logoutUser;

  AuthBloc({
    required this.tokenManager,
    required this.loginUser,
    required this.registerUser,
    required this.logoutUser,
  }) : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<AuthStatusChanged>(_onAuthStatusChanged);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 500)); // Splash delay
      final token = await tokenManager.getAccessToken();

      if (token != null && token.isNotEmpty) {
        await sl<UserCubit>().loadUser();
        emit(AuthAuthenticated());
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final result = await loginUser(
        LoginUserParams(
          emailOrUsername: event.emailOrUsername,
          password: event.password,
        ),
      );

      result.fold((failure) => emit(AuthFailure(failure.message)), (
        success,
      ) async {
        await sl<UserCubit>().loadUser();
        emit(AuthAuthenticated());
      });
    } catch (e) {
      emit(AuthFailure('Login failed: ${e.toString()}'));
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final result = await registerUser(
        RegisterUserParams(
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.email,
          phone: event.phone,
          userName: event.username,
          password: event.password,
        ),
      );

      result.fold((failure) => emit(AuthFailure(failure.message)), (success) {
        // Don't log in automatically - just show success
        emit(
          AuthRegistrationSuccess('Registration successful! Please log in.'),
        );
      });
    } catch (e) {
      emit(AuthFailure('Registration failed: ${e.toString()}'));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final result = await logoutUser();

      result.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (success) => emit(AuthUnauthenticated()),
      );
    } catch (e) {
      // Even if logout fails, clear local tokens
      await tokenManager.clearTokens();
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onAuthStatusChanged(
    AuthStatusChanged event,
    Emitter<AuthState> emit,
  ) async {
    if (event.isAuthenticated) {
      await sl<UserCubit>().loadUser();
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
