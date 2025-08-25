import 'package:flutter/material.dart';

class AppColors {
  static _LightModeColors light = _LightModeColors();
  static _DarkModeColors dark = _DarkModeColors();
}

class _LightModeColors {
  final Color background = const Color(0xFFFAFBF9);
  final Color primaryBackground = const Color(0xFFFFFFFF);
  final Color primary = const Color(0xFF4B8174);
  final Color secondary = const Color(0xFFD7EADA);
  final Color tertiary = const Color(0xFFBFDFCF);
  final Color info = const Color(0xFF4B8174);
  final Color primaryText = const Color(0xFF141414);
  final Color secondaryText = const Color(0xFF141414);
  final Color error = const Color(0xFF683BBF);
}

class _DarkModeColors {
  final Color background = const Color(0xFFBB86FC);
  final Color primary = const Color(0xFF121212);
  final Color text = const Color(0xFFFFFFFF);
  final Color error = const Color(0xFFB9A3E3);
}
