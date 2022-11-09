import 'package:equatable/equatable.dart';
import 'package:marvel_hemisferio/src/domain/entities/thumbnail_entity.dart';

class ComicEntity extends Equatable {
  const ComicEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.isbn,
    required this.thumbnail,
  });

  final int id;
  final String title;
  final String description;
  final String isbn;
  final ThumbnailEntity thumbnail;

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    isbn,
    thumbnail
  ];
}
