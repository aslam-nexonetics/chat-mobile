import 'package:chat_mobile/core/navigation/app_router.dart';
import 'package:chat_mobile/fetures/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_mobile/fetures/auth/presentation/bloc/auth_event.dart';
import 'package:chat_mobile/fetures/auth/presentation/pages/login_page.dart';
import 'package:chat_mobile/fetures/user/presentation/cubit/user_cubit.dart';
import 'package:chat_mobile/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _buildBlocProviders(),
      child: MaterialApp.router(
        title: 'Chat Mobile',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Colors.grey.shade100,
          ),
        ),
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  List<BlocProvider> _buildBlocProviders() {
    return [
      BlocProvider<AuthBloc>(
        create: (context) => sl<AuthBloc>()..add(AppStarted()),
      ),
      BlocProvider<UserCubit>(create: (context) => sl<UserCubit>()),
    ];
  }
}
