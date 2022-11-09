import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marvel_hemisferio/src/config/app_config.dart';
import 'package:marvel_hemisferio/src/data/repositories/character_repository.dart';
import 'package:marvel_hemisferio/src/data/repositories/comic_repository.dart';
import 'package:marvel_hemisferio/src/data/repositories/preferences_repository.dart';
import 'package:marvel_hemisferio/src/data/services/character_service.dart';
import 'package:marvel_hemisferio/src/data/services/comic_service.dart';
import 'package:marvel_hemisferio/src/data/services/preferences_service.dart';
import 'package:marvel_hemisferio/src/domain/repositories/i_character_repository.dart';
import 'package:marvel_hemisferio/src/domain/repositories/i_comic_repository.dart';
import 'package:marvel_hemisferio/src/domain/repositories/i_preferences_repository.dart';
import 'package:marvel_hemisferio/src/interceptor/logging_interceptor.dart';
import 'package:marvel_hemisferio/src/presentation/viewmodels/preferences/preferences_state.dart';
import 'package:marvel_hemisferio/src/presentation/viewmodels/preferences/preferences_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

//region Data source layer
final dioClientPod = Provider<Dio>(
  (ref) {
    return Dio(
      BaseOptions(
        baseUrl: ref.watch(appConfigPod).serverBaseUrl,
        connectTimeout: 15000,
      ),
    )..interceptors.add(LoggingInterceptor());
  },
  dependencies: [appConfigPod],
);

final preferencesPod = FutureProvider<SharedPreferences>(
  (_) => SharedPreferences.getInstance(),
);
//endregion

//region Service layer
final preferencesServicePod = Provider<PreferencesService>(
  (ref) {
    final sharedPreferencesData = ref.watch(preferencesPod).asData!;
    return PreferencesServiceImpl(sharedPreferencesData.value);
  },
  dependencies: [preferencesPod],
);
//endregion

//region Repository layer

final comicRepositoryPod = Provider<IComicRepository>(
  (ref) => ComicRepository(ComicServiceImpl(
    ref.watch(dioClientPod),
    privateKey: ref.watch(appConfigPod).privateKey,
    publicKey: ref.watch(appConfigPod).publicKey,
  )),
  dependencies: [dioClientPod, appConfigPod],
);

final characterRepositoryPod = Provider<ICharacterRepository>(
  (ref) => CharacterRepository(CharacterServiceImpl(
    ref.watch(dioClientPod),
    privateKey: ref.watch(appConfigPod).privateKey,
    publicKey: ref.watch(appConfigPod).publicKey,
  )),
  dependencies: [dioClientPod, appConfigPod],
);

final preferencesRepositoryPod = Provider<IPreferencesRepository>(
  (ref) => PreferencesRepository(ref.watch(preferencesServicePod)),
  dependencies: [preferencesServicePod],
);

//endregion

//region ViewModel layer
final preferencesViewModelPod =
    StateNotifierProvider<PreferencesViewModel, PreferencesState>(
  (ref) => PreferencesViewModel(ref.watch(preferencesRepositoryPod)),
  dependencies: [preferencesRepositoryPod],
);
//endregion

//region App Config
final appConfigPod = Provider<AppConfig>(
  (_) => throw UnimplementedError('appConfigPod must be overridden'),
);
//endregion
