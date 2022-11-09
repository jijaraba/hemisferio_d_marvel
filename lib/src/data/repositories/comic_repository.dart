import 'package:marvel_hemisferio/src/core/presentation/viewmodels/model_extensions.dart';
import 'package:marvel_hemisferio/src/data/services/character_service.dart';
import 'package:marvel_hemisferio/src/data/services/comic_service.dart';
import 'package:marvel_hemisferio/src/domain/entities/character_entity.dart';
import 'package:marvel_hemisferio/src/domain/entities/character_search_entity.dart';
import 'package:marvel_hemisferio/src/domain/entities/comic_entity.dart';
import 'package:marvel_hemisferio/src/domain/repositories/i_character_repository.dart';
import 'package:marvel_hemisferio/src/domain/repositories/i_comic_repository.dart';

class ComicRepository implements IComicRepository {
  ComicRepository(this._comicService);

  final ComicService _comicService;

  @override
  Future<List<ComicEntity>> getComic(int comicId) async {
    final comicModel = await _comicService.getComic(comicId);
    return comicModel!.map((item) => item.toComicEntity()).toList();
  }


}
