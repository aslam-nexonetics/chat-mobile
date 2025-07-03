import 'package:chat_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final IconData icon;
  final VoidCallback? onToggleObscure;

  const LoginTextField({
    super.key,
    required this.label,
    this.obscureText = false,
    required this.controller,
    this.validator,
    required this.icon,
    this.onToggleObscure,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.textFieldBackground,
        // color: AppColors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.white),
          const SizedBox(width: 12),
          Expanded(
            child: TextFormField(
              controller: controller,
              style: TextStyle(color: AppColors.white),
              obscureText: obscureText,
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                hintText: label,
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
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: AppColors.white,
              ),
            ),
        ],
      ),
    );
  }
}
