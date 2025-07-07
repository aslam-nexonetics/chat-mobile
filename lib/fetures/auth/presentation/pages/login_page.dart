import 'package:chat_mobile/core/constents/route_constants.dart';
import 'package:chat_mobile/core/utils/validators.dart';
import 'package:chat_mobile/fetures/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_mobile/fetures/auth/presentation/bloc/auth_event.dart';
import 'package:chat_mobile/fetures/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:chat_mobile/core/theme/app_colors.dart';
import 'package:chat_mobile/core/theme/app_images.dart';
import 'package:chat_mobile/fetures/auth/presentation/pages/registration_page.dart';
import 'package:chat_mobile/fetures/auth/presentation/widgets/gradient_button.dart';
import 'package:chat_mobile/fetures/auth/presentation/widgets/login_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is AuthAuthenticated) {
            // Navigation will be handled by GoRouter redirect
            // But you can add additional logic here if needed
            context.pushReplacement(RouteConstants.home);
          }
        },
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWeb = constraints.maxWidth >= 800;

        return SingleChildScrollView(
          child: SizedBox(
            height: height,
            child: Stack(
              children: [
                _buildBackgroundImage(),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isWeb ? width * 0.2 : width * 0.1,
                      vertical: height * 0.07,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isWeb ? 500 : double.infinity,
                      ),
                      child: _buildFormContent(height, isWeb),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBackgroundImage() {
    return Positioned.fill(
      child: Image.asset(
        AppImages.loginBgImage,
        fit: BoxFit.cover,
        color: const Color(0xFF1e1934),
      ),
    );
  }

  Widget _buildFormContent(double height, bool isWeb) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: height * (isWeb ? 0.05 : 0.1)),
          _buildWelcomeText(),
          SizedBox(height: height * 0.05),
          _buildTextFields(),
          SizedBox(height: height * 0.06),
          _buildLoginButton(),
          _buildForgotPasswordButton(),
          const SizedBox(height: 32),
          _buildSignupRow(),
        ],
      ),
    );
  }

  Widget _buildWelcomeText() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome",
          style: TextStyle(
            fontSize: 46,
            fontWeight: FontWeight.w400,
            color: Colors.white,
            height: 1.2,
          ),
        ),
        Text(
          "Back!",
          style: TextStyle(
            fontSize: 49,
            fontWeight: FontWeight.bold,
            color: Colors.purpleAccent,
          ),
        ),
      ],
    );
  }

  Widget _buildTextFields() {
    return Column(
      children: [
        LoginTextField(
          label: 'Email or Username',
          controller: emailController,
          icon: Icons.person,
        ),
        const SizedBox(height: 16),
        LoginTextField(
          label: 'Password',
          obscureText: true,
          validator: (value) => Validators.validatePassword(value),
          onToggleObscure: () {},
          controller: passwordController,
          icon: Icons.lock,
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return Center(
          child: GradientButton(
            text: 'LOG IN',
            onPressed: isLoading ? () {} : _handleLogin,
            isLoading: isLoading,
          ),
        );
      },
    );
  }

  void _handleLogin() {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    context.read<AuthBloc>().add(
      LoginRequested(
        emailController.text.trim(),
        passwordController.text.trim(),
      ),
    );
  }

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          context.push(RouteConstants.forgotPassword);
        },
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: AppColors.white),
        ),
      ),
    );
  }

  Widget _buildSignupRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(color: Colors.white70),
        ),
        TextButton(
          onPressed: () {
            context.push(RouteConstants.register);
          },
          child: const Text(
            "Sign up",
            style: TextStyle(color: AppColors.white),
          ),
        ),
      ],
    );
  }
}
