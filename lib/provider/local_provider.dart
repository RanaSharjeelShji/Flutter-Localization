import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en'); // Default language is English

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = const Locale('en'); // Reset to English
    notifyListeners();
  }
}

// List of supported locales
class L10n {
  static final all = [
    const Locale('en'), // English
    const Locale('hi'), // Hindi
    const Locale('ar'), // Arabic
  ];
}
