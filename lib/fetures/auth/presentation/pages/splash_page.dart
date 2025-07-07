import 'package:chat_mobile/core/constents/route_constants.dart';
import 'package:chat_mobile/fetures/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_mobile/fetures/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          // context.goNamed('home');
          context.pushReplacement(RouteConstants.home);
        } else if (state is AuthUnauthenticated) {
          // context.goNamed('login');
          context.pushReplacement(RouteConstants.login);
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Your splash screen UI
              // FlutterLogo(size: 100),
              SizedBox(height: 20),
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Loading...'),
            ],
          ),
        ),
      ),
    );
  }
}
