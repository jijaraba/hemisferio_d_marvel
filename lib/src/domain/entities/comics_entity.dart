import 'package:equatable/equatable.dart';
import 'package:marvel_hemisferio/src/domain/entities/item_entity.dart';

class ComicsEntity extends Equatable {
  const ComicsEntity({
    required this.available,
    required this.collectionURI,
    required this.items,
  });

  final int available;
  final String collectionURI;
  final List<ItemEntity> items;

  @override
  List<Object?> get props => [
    available,
    collectionURI,
    items
  ];
}
