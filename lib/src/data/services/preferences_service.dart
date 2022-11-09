import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesService {
  List<String>? get favorites;

  Future<bool> setFavorites(List<String>? value);

  Future<void> clear();
}

class PreferencesServiceImpl implements PreferencesService {
  PreferencesServiceImpl(this._preferences);

  final SharedPreferences _preferences;

  static const _favorites = 'R&M_FAVORITES';

  @override
  Future<void> clear() async {
    _preferences.remove(_favorites);
  }

  @override
  List<String>? get favorites {
    try {
      final data = _preferences.getStringList(_favorites);
      if (data != null) {
        return data;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> setFavorites(List<String>? value) {
    return _preferences.setStringList(_favorites, value ?? []);
  }
}
