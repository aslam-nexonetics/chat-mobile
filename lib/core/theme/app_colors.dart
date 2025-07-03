import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF24786D);
  static const secondary = Color(0xFF000E08);
  static const background = Color(0xFFFAF9F6);
  static const loginBackground = Color.fromARGB(255, 9, 3, 33);
  static const textFieldBackground = Color.fromARGB(255, 60, 55, 79);
  static const textPrimary = Color(0xFF000E08);
  static const textSecondary = Color(0xFF797C7B);
  static const error = Color(0xFFFF2D1B);
  static const online = Color(0xFF0FE16D);
  static const offline = Color(0xFF9A9E9C);
  static const disabled = Color(0xFFF3F6F6);
  static const disabled2 = Color(0xFF051D13);

  static const chatSent = Color(0xFF20A090);
  static const chatRecieve = Color(0xFFF2F7FB);

  static const hover1 = Color(0xFFF1F6FA);
  static const divider1 = Color(0xFFCDD1D0);

  static const red1 = Color(0XFFEA3736);
  static const red2 = Color(0XFFFF2D1B);
  static const white = Color(0XFFFFFFFF);

  // static const buttonGradient =
  //     const LinearGradient(colors: [Colors.pink, Colors.purple, Colors.purple]);
  static const buttonGradient = LinearGradient(colors: [primary, chatSent]);
  static const homeGradient = LinearGradient(
    colors: [Colors.pink, Colors.purple],
  );
}
