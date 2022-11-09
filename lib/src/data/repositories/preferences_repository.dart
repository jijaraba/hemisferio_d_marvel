import 'package:marvel_hemisferio/src/data/services/preferences_service.dart';
import 'package:marvel_hemisferio/src/domain/repositories/i_preferences_repository.dart';

class PreferencesRepository implements IPreferencesRepository {
  PreferencesRepository(this._preferenceService);

  final PreferencesService _preferenceService;

  @override
  List<String>? getFavorites() => _preferenceService.favorites;

  @override
  Future<bool> setFavorites(List<String>? favorites) =>
      _preferenceService.setFavorites(favorites);

  @override
  Future<void> clear() async {
    _preferenceService.clear();
  }
}
