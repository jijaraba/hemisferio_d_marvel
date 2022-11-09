// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComicModel _$ComicModelFromJson(Map<String, dynamic> json) => ComicModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      isbn: json['isbn'] as String,
      thumbnail:
          ThumbnailModel.fromJson(json['thumbnail'] as Map<String, dynamic>),
    );
