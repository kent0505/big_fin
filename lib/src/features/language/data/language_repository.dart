import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/config/constants.dart';

abstract interface class LanguageRepository {
  const LanguageRepository();

  String getLocale();
  Future<void> setLocale(final String locale);
}

final class LanguageRepositoryImpl implements LanguageRepository {
  LanguageRepositoryImpl({required SharedPreferences prefs}) : _prefs = prefs;

  final SharedPreferences _prefs;

  @override
  String getLocale() {
    final code = PlatformDispatcher.instance.locale.languageCode;
    List<String> codes = [
      Locales.defaultLocale,
      Locales.ru,
      Locales.es,
      Locales.de,
    ];
    return _prefs.getString(Keys.locale) ??
        (codes.contains(code) ? code : Locales.defaultLocale);
  }

  @override
  Future<void> setLocale(final String locale) async {
    await _prefs.setString(Keys.locale, locale);
  }
}
