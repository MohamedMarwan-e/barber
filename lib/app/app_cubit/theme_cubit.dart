import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/services/hive.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(this._localStorage) : super(ThemeMode.system) {
    _initializeThemeMode();
  }

  final HiveLocalStorage _localStorage;

  Future<void> _initializeThemeMode() async {
    final savedTheme = _localStorage.getThemeMode();

    if (savedTheme == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
      final systemTheme = brightness == Brightness.dark ?
      ThemeMode.dark : ThemeMode.light;
      emit(systemTheme);
      await _localStorage.saveThemeMode(ThemeMode.system); // Save preference
    } else {
      emit(savedTheme);
    }
  }

  /// Toggles the theme mode between light and dark
  void toggleTheme() {
    final newMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    _localStorage.saveThemeMode(newMode);
    emit(newMode);
  }

  /// Sets the theme mode explicitly
  void setTheme(ThemeMode mode) {
    _localStorage.saveThemeMode(mode);
    emit(mode);
  }

  bool get isDark => state == ThemeMode.dark ||
      (state == ThemeMode.system &&
          SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark);
}
