
import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable(createToJson: false)
class ItemModel {
  ItemModel({
    required this.resourceURI,
    required this.name,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  final String resourceURI;
  final String name;
}


