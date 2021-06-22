import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension Translate on BuildContext {
  String translate(String text) => SCLocalizations.of(this).translate(text);
  Future<bool> load(String code) => SCLocalizations.of(this).load();
}

class SCLocalizations {
  final Locale locale;
  SCLocalizations({this.locale});

  static SCLocalizations of(BuildContext context) {
    return Localizations.of<SCLocalizations>(context, SCLocalizations);
  }

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    String jsonString =
        await rootBundle.loadString('i18n/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String translate(String key) {
    return _localizedStrings[key] ?? "UNAVAILABLE LOCALIZATION";
  }

  static const LocalizationsDelegate<SCLocalizations> delegate =
      _SCLocalizationsDelegate();
}

class _SCLocalizationsDelegate extends LocalizationsDelegate<SCLocalizations> {
  const _SCLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['fr', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<SCLocalizations> load(Locale locale) async {
    SCLocalizations localizations = SCLocalizations(locale: locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_SCLocalizationsDelegate old) => false;
}
