import 'package:equatable/equatable.dart';
import 'package:marvel_hemisferio/src/domain/entities/comics_entity.dart';
import 'package:marvel_hemisferio/src/domain/entities/thumbnail_entity.dart';

class CharacterEntity extends Equatable {
  const CharacterEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
    required this.comics,
  });

  final int id;
  final String name;
  final String description;
  final ThumbnailEntity thumbnail;
  final ComicsEntity comics;

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    thumbnail,
    comics,
  ];
}
