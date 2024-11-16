import 'package:flutter/material.dart';

class AppColors {
  static _LightModeColors light = _LightModeColors();
  static _DarkModeColors dark = _DarkModeColors();
}

class _LightModeColors {
  final Color background = const Color(0xFFF0F0F0);
  final Color primaryBackground = const Color(0xFFFFFFFF);
  final Color primary = const Color(0xFF36B37E);
  final Color secondary = const Color(0xFFC7EEDD);
  final Color accent = const Color(0xFF5AE2A0);
  final Color info = const Color(0xFF36B37E);
  final Color text = const Color(0xFF141414);
}

class _DarkModeColors {
  final Color background = const Color(0xFFBB86FC);
  final Color primary = const Color(0xFF121212);
  final Color text = const Color(0xFFFFFFFF);
}
