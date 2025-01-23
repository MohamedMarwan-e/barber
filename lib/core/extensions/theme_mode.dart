import 'package:flutter/material.dart';

extension ThemeModeExtension on ThemeMode {
  static ThemeMode fromString(String? mode) {
    switch (mode) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  String toStorageString() {
    return toString().split('.').last;
  }
}

String getThemeName(ThemeMode themeMode) {
  switch (themeMode) {
    case ThemeMode.light:
      return 'Light';
    case ThemeMode.dark:
      return 'Dark';
    case ThemeMode.system:
      return 'System Default';
  }
}