import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/extensions/lang.dart';
import '../../core/services/hive.dart';


class LocalizationCubit extends Cubit<Locale> {
  LocalizationCubit(this._hiveLocalStorage)
      : super(_getInitialLocale(_hiveLocalStorage));

  final HiveLocalStorage _hiveLocalStorage;

  static Locale _getInitialLocale(HiveLocalStorage hiveLocalStorage) {
    final savedLocaleCode = hiveLocalStorage.getLocale();
    return Locale(savedLocaleCode);
  }

  void changeLocale(BuildContext context, Languages language) {
    final newLocale = Locale(language.toLanguageKey);
    emit(newLocale);
    context.setLocale(newLocale);
    _hiveLocalStorage.saveLocale(language.toLanguageKey);
  }

  Languages getCurrentLanguage() {
    final localeCode = _hiveLocalStorage.getLocale();
    return Languages.values.firstWhere(
            (lang) => lang.toLanguageKey == localeCode,
        orElse: () => Languages.ar);
  }
}