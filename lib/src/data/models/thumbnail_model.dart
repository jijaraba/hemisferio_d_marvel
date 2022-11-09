
import 'package:json_annotation/json_annotation.dart';

part 'thumbnail_model.g.dart';

@JsonSerializable(createToJson: false)
class ThumbnailModel {
  ThumbnailModel({
    required this.path,
    required this.extension,
  });

  factory ThumbnailModel.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailModelFromJson(json);

  final String path;
  final String extension;
}


