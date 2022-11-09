import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:marvel_hemisferio/src/data/models/character_model.dart';
import 'package:marvel_hemisferio/src/domain/entities/character_search_entity.dart';

abstract class CharacterService {
  Future<List<CharacterModel>?> getCharacterList(CharacterSearchData data);

  Future<List<CharacterModel>?> getCharacterInterestingList(
      List<String> characters);

  Future<CharacterModel?> getCharacter(String characterId);
}

class CharacterServiceImpl implements CharacterService {
  CharacterServiceImpl(
    this._client, {
    required this.privateKey,
    required this.publicKey,
  });

  final Dio _client;
  final String privateKey;
  final String publicKey;

  @override
  Future<List<CharacterModel>?> getCharacterList(
      CharacterSearchData data) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final hash = md5
          .convert(utf8.encode(timestamp) +
              utf8.encode(privateKey) +
              utf8.encode(publicKey))
          .toString();

      final response = await _client.get(
        '/characters${data.toQueryParam()}&apikey=$publicKey&hash=$hash&ts=$timestamp',
      );
      if (response.statusCode == 200) {
        return (response.data['data']['results']! as List)
            .map((x) => CharacterModel.fromJson(x))
            .toList();
      }
      return null;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<List<CharacterModel>?> getCharacterInterestingList(
      List<String> characters) async {
    try {
      final response = await _client.get(
        '/character/$characters',
      );
      if (response.statusCode == 200) {
        return (response.data! as List)
            .map((x) => CharacterModel.fromJson(x))
            .toList();
      }
      return null;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<CharacterModel?> getCharacter(String characterId) async {
    try {
      final response = await _client.get(
        '/character/$characterId',
      );
      if (response.statusCode == 200) {
        return CharacterModel.fromJson(response.data!);
      }
      return null;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}
