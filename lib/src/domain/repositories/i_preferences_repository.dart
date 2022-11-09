abstract class IPreferencesRepository {
  List<String>? getFavorites();
  Future<bool> setFavorites(List<String>? favorites);
  Future<void> clear();
}
