import 'package:marvel_hemisferio/src/domain/entities/character_entity.dart';
import 'package:marvel_hemisferio/src/domain/entities/character_search_entity.dart';

abstract class ICharacterRepository {
  Future<List<CharacterEntity>> getCharacterList(CharacterSearchData data);
  Future<List<CharacterEntity>> getCharacterInterestingList(
      List<String> characters);
  Future<CharacterEntity> getCharacter(characterId);
}
