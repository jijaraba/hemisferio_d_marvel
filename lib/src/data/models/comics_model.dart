
import 'package:json_annotation/json_annotation.dart';
import 'package:marvel_hemisferio/src/data/models/item_model.dart';

part 'comics_model.g.dart';

@JsonSerializable(createToJson: false)
class ComicsModel {
  ComicsModel({
    required this.available,
    required this.collectionURI,
    required this.items,
  });

  factory ComicsModel.fromJson(Map<String, dynamic> json) =>
      _$ComicsModelFromJson(json);

  final int available;
  final String collectionURI;
  final List<ItemModel> items;
}


