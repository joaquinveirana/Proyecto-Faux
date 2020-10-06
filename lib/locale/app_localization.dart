import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

class AppLocalization {
  Locale locale;

  AppLocalization(this.locale);

  Map<String, String> _localizedStrings = {};
  Map<String, Map<String, dynamic>> _gameTopics = {};

  static const LocalizationsDelegate<AppLocalization> delegate =
      _AppLocalizationsDelegate();

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  void setLocale(Locale locale) async {
    this.locale = locale;
    await load();
  }

  Future<bool> load() async {
    // Load the language JSON file from the "lang" folder
    String jsonString =
        await rootBundle.loadString('l10n/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    jsonMap.forEach((key, value) {
      if (key.contains('topic')) {
        _gameTopics.putIfAbsent(key, () => value);
      } else {
        _localizedStrings.putIfAbsent(key, () => value);
      }
    });
    return true;
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key) {
    return _localizedStrings[key];
  }

  // This method will be called from every widget which needs a localized text
  String translateTopic(String topic, String topicElement) {
    return _gameTopics[topic][topicElement];
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    AppLocalization localizations = new AppLocalization(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
