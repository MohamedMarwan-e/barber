import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../constants.dart';
import '../extensions/theme_mode.dart';


/// Singleton class for handling local storage using Hive.
class HiveLocalStorage {
  HiveLocalStorage._internal();

  static final HiveLocalStorage _singleton = HiveLocalStorage._internal();

  static HiveLocalStorage get instance => _singleton;

  late Box box;

  /// Initializes Hive and opens the main box.
  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    box = await Hive.openBox(mainBox);
  }

  /// Stores a key-value pair in the Hive box.
  Future<void> put(dynamic key, dynamic value) async {
    await box.put(key, value);
  }

  /// Retrieves a value from the Hive box by key.
  dynamic get(dynamic key, {dynamic defaultValue}) {
    return box.get(key, defaultValue: defaultValue);
  }

  /// Clears all data in the Hive box.
  Future<void> clearBox() async {
    await box.clear();
  }


  Future<void> saveThemeMode(ThemeMode mode) async {
    await box.put('themeMode', mode.toStorageString());
  }


  ThemeMode getThemeMode() {
    final mode = box.get('themeMode', defaultValue: 'system');
    return ThemeModeExtension.fromString(mode);
  }


  Future<void> saveLocale(String locale) async {
    await box.put('locale', locale);
  }

  String getLocale() {
    return box.get('locale', defaultValue: 'ar');
  }

}