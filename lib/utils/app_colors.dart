import 'package:flutter/material.dart';

class AppColors {
  static _LightModeColors light = _LightModeColors();
  static _DarkModeColors dark = _DarkModeColors();
}

class _LightModeColors {
  final Color background = const Color(0xFFF0F0F0);
  final Color primary = const Color(0xFFF5F5F5);
  final Color lightText = const Color(0xFF000000);
}

class _DarkModeColors {
  final Color background = const Color(0xFFBB86FC);
  final Color primary = const Color(0xFF121212);
  final Color darkText = const Color(0xFFFFFFFF);
}
