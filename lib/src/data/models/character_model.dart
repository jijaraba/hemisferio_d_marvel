
import 'package:json_annotation/json_annotation.dart';
import 'package:marvel_hemisferio/src/data/models/comics_model.dart';
import 'package:marvel_hemisferio/src/data/models/thumbnail_model.dart';

part 'character_model.g.dart';

@JsonSerializable(createToJson: false)
class CharacterModel {
  CharacterModel({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
    required this.comics,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);

  final int id;
  final String name;
  final String description;
  final ThumbnailModel thumbnail;
  final ComicsModel comics;
}


