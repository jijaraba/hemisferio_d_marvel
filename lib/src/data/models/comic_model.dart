
import 'package:json_annotation/json_annotation.dart';
import 'package:marvel_hemisferio/src/data/models/item_model.dart';
import 'package:marvel_hemisferio/src/data/models/thumbnail_model.dart';

part 'comic_model.g.dart';

@JsonSerializable(createToJson: false)
class ComicModel {
  ComicModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isbn,
    required this.thumbnail,
  });

  factory ComicModel.fromJson(Map<String, dynamic> json) =>
      _$ComicModelFromJson(json);

  final int id;
  final String title;
  final String description;
  final String isbn;
  final ThumbnailModel thumbnail;
}


