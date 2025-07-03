import 'package:chat_mobile/core/auth/token_manager.dart';
import 'package:chat_mobile/core/auth/token_refresh_service.dart';
import 'package:chat_mobile/core/constents/api_constatnts.dart';
import 'package:chat_mobile/core/network/api_client.dart';
import 'package:chat_mobile/core/network/network_info.dart';
import 'package:chat_mobile/core/network/token_interceptor.dart';
import 'package:chat_mobile/fetures/auth/data/datasources/auth_remote_datasource.dart';
import 'package:chat_mobile/fetures/auth/data/repositories/auth_repository_impl.dart';
import 'package:chat_mobile/fetures/auth/domain/repositories/auth_repository.dart';
import 'package:chat_mobile/fetures/auth/domain/usecases/login_usecase.dart';
import 'package:chat_mobile/fetures/auth/domain/usecases/logout_usecase.dart';
import 'package:chat_mobile/fetures/auth/domain/usecases/register_usecase.dart';
import 'package:chat_mobile/fetures/auth/presentation/bloc/auth_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

/// Global Service Locator instance
final sl = GetIt.instance;

/// Setup dependency injection for the application
///
/// This method registers all dependencies in the service locator
/// following the clean architecture pattern with dependencies flowing
/// from presentation -> domain -> data layers
Future<void> setupServiceLocator() async {
  //--------------------------------------------------------------------------
  // Core Dependencies
  //--------------------------------------------------------------------------
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  // Network
  sl.registerSingleton<InternetConnectionChecker>(
    InternetConnectionChecker.instance,
  );
  sl.registerSingleton<NetworkInfo>(NetworkInfoImpl(sl()));
  // Auth core components
  sl.registerLazySingleton<TokenManager>(
    () => TokenManager(secureStorage: sl()),
  );
  // Dio
  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: ApiUrls.baseURL,
        followRedirects: true,
        maxRedirects: 5,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        responseType: ResponseType.json,
        sendTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    ),
  );

  sl.registerLazySingleton<TokenRefreshService>(
    () => TokenRefreshService(tokenManager: sl(), dio: sl()),
  );

  sl.registerLazySingleton<TokenInterceptor>(
    () => TokenInterceptor(dio: sl(), tokenRefreshService: sl()),
  );
  sl.registerSingleton<ApiClient>(ApiClient(tokenInterceptor: sl(), dio: sl()));
  //--------------------------------------------------------------------------
  // Features - Auth
  //--------------------------------------------------------------------------
  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDatasourceImpl(sl()),
  );
  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
      tokenManager: sl(),
    ),
  );
  // Use Cases
  sl.registerLazySingleton<LoginUserUsecase>(() => LoginUserUsecase(sl()));
  sl.registerLazySingleton<RegisterUserUsecase>(
    () => RegisterUserUsecase(sl()),
  );
  sl.registerLazySingleton<LogoutUserUsecase>(() => LogoutUserUsecase(sl()));
  //blocks
  sl.registerLazySingleton<AuthBloc>(
    // Change from Factory to Singleton
    () => AuthBloc(
      tokenManager: sl(),
      loginUser: sl(),
      registerUser: sl(),
      logoutUser: sl(),
    ),
  );
  //--------------------------------------------------------------------------
}
