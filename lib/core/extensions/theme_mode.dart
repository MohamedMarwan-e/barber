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
