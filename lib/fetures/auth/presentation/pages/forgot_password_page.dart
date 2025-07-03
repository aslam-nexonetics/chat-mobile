// import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';

// class ForgotPasswordScreen extends StatefulWidget {
//   const ForgotPasswordScreen({super.key});

//   @override
//   State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
// }

// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//   final PageController _pageController = PageController();

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   void _nextPage() {
//     _pageController.nextPage(
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: StyleConstants.defaultPadding,
//           vertical: height * 0.05,
//         ),
//         child: Consumer<ForgotPasswordProvider>(
//           builder:
//               (context, value, child) => PageView(
//                 controller: _pageController,
//                 physics: const NeverScrollableScrollPhysics(),
//                 onPageChanged: (index) {},
//                 children: [
//                   _EmailStep(onNext: _nextPage, forgotPasswordProvider: value),
//                   _OTPAndPasswordStep(forgotPasswordProvider: value),
//                 ],
//               ),
//         ),
//       ),
//     );
//   }
// }

// class _EmailStep extends StatelessWidget {
//   final void Function() onNext;
//   // final ForgotPasswordProvider forgotPasswordProvider;

//   const _EmailStep({
//     required this.onNext,
//     required this.forgotPasswordProvider,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: forgotPasswordProvider.emailFormKey,
//       child: Column(
//         children: [
//           const Spacer(),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Stack(
//                 children: [
//                   Positioned(
//                     bottom: 1,
//                     left: 0,
//                     child: Container(
//                       height: 8,
//                       width: 60,
//                       color: AppColors.chatSent,
//                     ),
//                   ),
//                   const Text("Forgot Password", style: AppTextStyles.headline1),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: StyleConstants.defaultPadding),
//           const Text(
//             "Enter your email address and we'll send you a code to reset your password",
//             textAlign: TextAlign.center,
//             style: AppTextStyles.label,
//           ),
//           const Spacer(),
//           CustomTextField(
//             label: 'Email',
//             controller: forgotPasswordProvider.emailController,
//             validator: (value) => emailValidator(value ?? ""),
//           ),
//           const Spacer(),
//           CustomButton1(
//             text: 'Send Reset Code',
//             onPressed: () {
//               FocusScope.of(context).unfocus(); // Close the keyboard

//               if (forgotPasswordProvider.emailFormKey.currentState!
//                       .validate() &&
//                   !forgotPasswordProvider.isLoading) {
//                 forgotPasswordProvider.sendResetEmail(context).then((value) {
//                   if (value) {
//                     onNext();
//                   }
//                 });
//               }
//             },
//             isLoading: forgotPasswordProvider.isLoading,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _OTPAndPasswordStep extends StatefulWidget {
//   final ForgotPasswordProvider forgotPasswordProvider;

//   const _OTPAndPasswordStep({required this.forgotPasswordProvider});

//   @override
//   State<_OTPAndPasswordStep> createState() => _OTPAndPasswordStepState();
// }

// class _OTPAndPasswordStepState extends State<_OTPAndPasswordStep> {
//   final FocusNode _otpFocusNode = FocusNode();

//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(milliseconds: 300), () {
//       _otpFocusNode.requestFocus(); // Request focus after build
//     });
//   }

//   @override
//   void dispose() {
//     _otpFocusNode.dispose();
//     super.dispose();
//   }

//   bool obscureText = true;
//   void togglePasswordVisibility() {
//     setState(() => obscureText = !obscureText);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: widget.forgotPasswordProvider.otpFormKey,
//       child: Column(
//         children: [
//           const Spacer(),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Stack(
//                 children: [
//                   Positioned(
//                     bottom: 1,
//                     left: 0,
//                     child: Container(
//                       height: 8,
//                       width: 35,
//                       color: AppColors.chatSent,
//                     ),
//                   ),
//                   const Text("Reset Password", style: AppTextStyles.headline1),
//                 ],
//               ),
//               const SizedBox(height: StyleConstants.defaultPadding),
//               Text(
//                 "Enter the code sent to ${widget.forgotPasswordProvider.emailController.text}",
//                 textAlign: TextAlign.center,
//                 style: AppTextStyles.label,
//               ),
//             ],
//           ),
//           const Spacer(),
//           PinCodeTextField(
//             appContext: context,
//             length: 6,
//             focusNode: _otpFocusNode, // Assign the focus node
//             autoDismissKeyboard: false,
//             enableActiveFill: true,
//             keyboardType: TextInputType.number,
//             textInputAction: TextInputAction.next,
//             onChanged: (value) {
//               widget.forgotPasswordProvider.otpCode = value;
//               if (value.length == 6) {
//                 // Auto-focus to password field when OTP is complete
//                 FocusScope.of(context).nextFocus();
//               }
//             },
//             cursorColor: Colors.black,
//             showCursor: true,
//             pinTheme: PinTheme(
//               shape: PinCodeFieldShape.box,
//               borderRadius: BorderRadius.circular(5),
//               fieldHeight: 50,
//               fieldWidth: 40,
//               activeFillColor: Colors.white,
//               selectedFillColor: Colors.grey.shade200,
//               inactiveFillColor: Colors.white,
//               activeColor: AppColors.primary,
//               selectedColor: AppColors.primary,
//               inactiveColor: Colors.grey,
//             ),
//           ),
//           const SizedBox(height: StyleConstants.defaultPadding),
//           CustomTextField(
//             label: 'New Password',
//             obscureText: obscureText,
//             controller: widget.forgotPasswordProvider.newPasswordController,
//             validator: (value) => passValidator(value ?? ""),
//             onToggleObscure: togglePasswordVisibility,
//           ),
//           const Spacer(),
//           CustomButton1(
//             text: 'Reset Password',
//             onPressed: () {
//               if (widget.forgotPasswordProvider.otpFormKey.currentState!
//                       .validate() &&
//                   !widget.forgotPasswordProvider.isLoading &&
//                   widget.forgotPasswordProvider.otpCode.length == 6) {
//                 widget.forgotPasswordProvider
//                     .verifyOTPAndResetPassword(context)
//                     .then((value) {
//                       if (value) {
//                         Navigator.of(context).pop();
//                       }
//                     });
//               }
//             },
//             isLoading: widget.forgotPasswordProvider.isLoading,
//           ),
//         ],
//       ),
//     );
//   }
// }
