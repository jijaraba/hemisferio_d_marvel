import 'package:marvel_hemisferio/src/domain/entities/comic_entity.dart';

abstract class IComicRepository {
  Future<List<ComicEntity>> getComic(int comicId);
}