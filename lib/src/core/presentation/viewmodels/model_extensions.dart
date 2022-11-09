import 'package:marvel_hemisferio/src/data/models/character_model.dart';
import 'package:marvel_hemisferio/src/data/models/comic_model.dart';
import 'package:marvel_hemisferio/src/data/models/comics_model.dart';
import 'package:marvel_hemisferio/src/data/models/item_model.dart';
import 'package:marvel_hemisferio/src/data/models/thumbnail_model.dart';
import 'package:marvel_hemisferio/src/domain/entities/character_entity.dart';
import 'package:marvel_hemisferio/src/domain/entities/comic_entity.dart';
import 'package:marvel_hemisferio/src/domain/entities/comics_entity.dart';
import 'package:marvel_hemisferio/src/domain/entities/item_entity.dart';
import 'package:marvel_hemisferio/src/domain/entities/thumbnail_entity.dart';

extension ToCharacterModelX on CharacterModel {
  CharacterEntity toCharacterEntity() {
    return CharacterEntity(
      id: id,
      name: name,
      description: description,
      thumbnail: thumbnail.toThumbnailEntity(),
      comics: comics.toComicEntity(),
    );
  }
}

extension ToThumbnailModelX on ThumbnailModel {
  ThumbnailEntity toThumbnailEntity() => ThumbnailEntity(
        path: path,
        extension: extension,
      );
}

extension ToComicsModelX on ComicsModel {
  ComicsEntity toComicEntity() => ComicsEntity(
        available: available,
        collectionURI: collectionURI,
        items: items.map((e) => e.toItemEntity()).toList(),
      );
}

extension ToItemModelX on ItemModel {
  ItemEntity toItemEntity() => ItemEntity(resourceURI: resourceURI, name: name);
}

extension ToComicModelX on ComicModel {
  ComicEntity toComicEntity() => ComicEntity(
        id: id,
        title: title,
        description: description,
        thumbnail: thumbnail.toThumbnailEntity(),
        isbn: isbn,
      );
}
