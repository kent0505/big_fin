import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/config/constants.dart';

abstract interface class ThemeRepository {
  const ThemeRepository();

  int getTheme();

  Future<void> setTheme(final int id);
}

final class ThemeRepositoryImpl implements ThemeRepository {
  ThemeRepositoryImpl({required SharedPreferences prefs}) : _prefs = prefs;

  final SharedPreferences _prefs;

  @override
  int getTheme() {
    return _prefs.getInt(Keys.themeID) ?? 2; // by default dark
  }

  @override
  Future<void> setTheme(final int id) async {
    await _prefs.setInt(Keys.themeID, id);
  }
}
