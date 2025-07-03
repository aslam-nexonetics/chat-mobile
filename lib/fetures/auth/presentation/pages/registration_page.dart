import 'package:chat_mobile/core/constents/route_constants.dart';
import 'package:chat_mobile/fetures/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_mobile/fetures/auth/presentation/bloc/auth_event.dart';
import 'package:chat_mobile/fetures/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:chat_mobile/core/theme/app_colors.dart';
import 'package:chat_mobile/core/theme/app_images.dart';
import 'package:chat_mobile/core/utils/validators.dart';
import 'package:chat_mobile/fetures/auth/presentation/pages/login_page.dart';
import 'package:chat_mobile/fetures/auth/presentation/widgets/register_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void togglePasswordVisibility() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  void onContinue() {
    if (formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        RegisterRequested(
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          email: emailController.text.trim(),
          phone: phoneController.text.trim(),
          username: userNameController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: const Text('Registration Successful!'),
            content: const Text(
              'Your account has been created successfully. Please log in with your credentials.',
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.go(RouteConstants.login);
                },
                child: const Text('Go to Login'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is AuthRegistrationSuccess) {
            // Show success message and redirect to login
            // _showSuccessDialog();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Regitration successful! Please log in."),
                backgroundColor: Colors.green,
              ),
            );
            context.go(RouteConstants.login);
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.registerBgImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: Colors.black.withAlpha(128),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: height * 0.05,
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Spacer(),
                  _buildHeaderText(),
                  const SizedBox(height: 15),
                  _buildTextFields(),
                  const Spacer(),
                  _buildContinueButton(),
                  const SizedBox(height: 12),
                  _buildLoginRedirect(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return const Text(
      "Join the Conversation Today!\nQuick & Easy Registration Awaits.",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildTextFields() {
    return Column(
      children: [
        RegisterTextField(
          label: 'First Name',
          controller: firstNameController,
          validator: Validators.validateName,
        ),
        const SizedBox(height: 10),
        RegisterTextField(
          label: 'Last Name',
          controller: lastNameController,
          validator: Validators.validateName,
        ),
        const SizedBox(height: 10),
        RegisterTextField(
          label: 'Email',
          controller: emailController,
          validator: (value) => Validators.validateEmail(value ?? ""),
        ),
        const SizedBox(height: 10),
        RegisterTextField(
          label: 'Phone no',
          controller: phoneController,
          validator: (value) => Validators.validatePhoneNumber(value ?? ""),
        ),
        const SizedBox(height: 10),
        RegisterTextField(
          label: 'Username',
          controller: userNameController,
          validator: (value) => Validators.validateUsername(value ?? ""),
        ),
        const SizedBox(height: 10),
        RegisterTextField(
          label: 'Password',
          controller: passwordController,
          obscureText: hidePassword,
          onToggleObscure: togglePasswordVisibility,
          validator: (value) => Validators.validatePassword(value ?? ""),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return SizedBox(
          height: 60,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading ? null : onContinue,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child:
                isLoading
                    ? const CircularProgressIndicator(color: AppColors.white)
                    : const Text(
                      "Continue",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
          ),
        );
      },
    );
  }

  Widget _buildLoginRedirect() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account?",
          style: TextStyle(color: AppColors.white, fontSize: 14),
        ),
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: Text(
            "Login now",
            style: TextStyle(
              color: Colors.pink[800],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
