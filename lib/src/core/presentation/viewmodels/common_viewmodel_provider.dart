import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marvel_hemisferio/dependencies.dart';
import 'package:marvel_hemisferio/src/domain/entities/character_entity.dart';
import 'package:marvel_hemisferio/src/domain/entities/character_search_entity.dart';
import 'package:marvel_hemisferio/src/domain/entities/comic_entity.dart';

final pageFilterPod = StateProvider.autoDispose<int>((_) => 0);
final limitFilterPod = StateProvider.autoDispose<int>((_) => 10);
final searchFilterPod = StateProvider.autoDispose<String>((_) => '');
final idsFilterPod = StateProvider.autoDispose<List<String>>((_) => []);

final characterDataPod = FutureProvider.family
    .autoDispose<List<CharacterEntity>, CharacterSearchData>(
  (ref, data) async {
    final offset = ref.watch(pageFilterPod);
    final limit = ref.watch(limitFilterPod);
    final filter = ref.watch(searchFilterPod).toLowerCase();
    return ref.watch(characterRepositoryPod).getCharacterList(
        CharacterSearchData(limit: limit, offset: offset, search: filter));
  },
);

final favoriteLocalPod = FutureProvider<List<String>?>(
  (ref) async => ref.watch(preferencesRepositoryPod).getFavorites(),
);


final comicDetailDataPod =
FutureProvider.family.autoDispose<List<ComicEntity>, int>(
      (ref, comicId) async {
    return ref.watch(comicRepositoryPod).getComic(comicId);
  },
);