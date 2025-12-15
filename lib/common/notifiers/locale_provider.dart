import 'dart:developer';

import 'package:fitness/core/di/injector.dart';
import 'package:fitness/core/storage/storage_preference_manager.dart';
import 'package:flutter/material.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  Future<void> loadLocale() async {
    final String langCode = getIt<SharedPreferencesManager>().getString(
          SharedPreferencesManager.language,
        ) ??
        'en';
    log('LangCode: $langCode');
    _locale = Locale(langCode);
    notifyListeners();
  }

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}
