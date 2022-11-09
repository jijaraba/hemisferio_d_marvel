// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterModel _$CharacterModelFromJson(Map<String, dynamic> json) =>
    CharacterModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      thumbnail:
          ThumbnailModel.fromJson(json['thumbnail'] as Map<String, dynamic>),
      comics: ComicsModel.fromJson(json['comics'] as Map<String, dynamic>),
    );
