import 'package:flutter/material.dart';
import 'package:quomia/theme/palette.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        surface: Palette.light.background,
        primary: Palette.light.primary,
        secondary: Palette.light.secondary,
        tertiary: Palette.light.tertiary));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        surface: Palette.dark.background,
        primary: Palette.dark.primary,
        secondary: Palette.dark.secondary,
        tertiary: Palette.dark.tertiary));
