import 'package:flutter/material.dart';

class Palette {
  static _LightModeColors light = _LightModeColors();
  static _DarkModeColors dark = _DarkModeColors();
}

class _LightModeColors {
  final Color background = const Color(0xFFF0F0F0);
  final Color primaryBackground = const Color(0xFFFFFFFF);
  final Color primary = const Color(0xFF36B37E);
  final Color secondary = const Color(0xFFC7EEDD);
  final Color tertiary = const Color(0xFF5AE2A0);
  final Color info = const Color(0xFF36B37E);
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
