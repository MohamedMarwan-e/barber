import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/services/hive.dart';


class LocalizationCubit extends Cubit<Locale> {
  LocalizationCubit(this._hiveLocalStorage) : super(_getInitialLocale(_hiveLocalStorage));

  final HiveLocalStorage _hiveLocalStorage;

  static Locale _getInitialLocale(HiveLocalStorage hiveLocalStorage) {
    final savedLocaleCode = hiveLocalStorage.getLocale();
    return Locale(savedLocaleCode);
  }

  void changeLocale(BuildContext context, String localeCode) {
    final newLocale = Locale(localeCode);
    emit(newLocale);
    context.setLocale(Locale('$newLocale'));
    _hiveLocalStorage.saveLocale(localeCode);
  }

}
