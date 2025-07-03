import 'package:chat_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RegisterTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  final VoidCallback? onToggleObscure;

  const RegisterTextField({
    super.key,
    required this.label,
    this.obscureText = false,
    required this.controller,
    this.validator,
    this.onToggleObscure,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
        gradient: AppColors.buttonGradient,
        // color: AppColors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              style: TextStyle(color: AppColors.white),
              obscureText: obscureText,
              decoration: InputDecoration(
                hintText: label,
                fillColor: Colors.transparent,
                hintStyle: TextStyle(color: AppColors.white),
                border: InputBorder.none,
              ),
              validator: validator,
            ),
          ),
          if (onToggleObscure != null)
            GestureDetector(
              onTap: onToggleObscure,
              child: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
                color: AppColors.white,
              ),
            ),
        ],
      ),
    );
  }
}
