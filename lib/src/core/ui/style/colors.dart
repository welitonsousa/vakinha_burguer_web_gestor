import 'package:flutter/material.dart';

class AppColors {
  static final i = AppColors();

  final Color primary = const Color(0xFF007d21);
  final Color secondary = const Color(0xFFffab18);
  final Color black = const Color(0xFF140e0e);
}

extension ColorsExt on BuildContext {
  AppColors get colors => AppColors.i;
}
