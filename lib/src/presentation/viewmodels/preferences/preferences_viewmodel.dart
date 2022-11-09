import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marvel_hemisferio/src/domain/repositories/i_preferences_repository.dart';
import 'package:marvel_hemisferio/src/presentation/viewmodels/preferences/preferences_state.dart';

class PreferencesViewModel extends StateNotifier<PreferencesState> {
  PreferencesViewModel(this._preferencesRepository)
      : super(const PreferencesState.initial());

  final IPreferencesRepository _preferencesRepository;

  Future<bool?> setFavorite(String favorite) async {
    try {
      final favorites = _preferencesRepository.getFavorites();
      favorites?.add(favorite);
      _preferencesRepository.setFavorites(favorites);
      state = const PreferencesState.success(action: PreferencesAction.add);
      return true;
    } on Exception catch (e) {
      state = PreferencesState.error(e.toString());
    }
    return null;
  }

  Future<bool?> removeFavorite(String favorite) async {
    try {
      final favorites = _preferencesRepository.getFavorites();
      favorites?.remove(favorite);
      _preferencesRepository.setFavorites(favorites);
      state = const PreferencesState.success(action: PreferencesAction.add);
      return true;
    } on Exception catch (e) {
      state = PreferencesState.error(e.toString());
    }
    return null;
  }


  void showLevelModal() => state = const PreferencesState.displayingModal();

  void dismissLevelModal() => state = const PreferencesState.initial();
}
