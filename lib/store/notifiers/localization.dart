import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationNotifier with ChangeNotifier {
  Locale _locale;

  Locale get locale => _locale;

  init() async {
    var prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('language_code');
    if (languageCode != null) _locale = Locale(languageCode);
    return;
  }

  void switchLocale(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_locale == type) {
      return;
    }
    if (type == Locale("ar")) {
      _locale = Locale("ar");
      await prefs.setString('language_code', 'ar');
    } else {
      _locale = Locale("fr");
      await prefs.setString('language_code', 'fr');
    }
    notifyListeners();
  }
}
