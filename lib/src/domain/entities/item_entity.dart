import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable {
  const ItemEntity({
    required this.resourceURI,
    required this.name,
  });

  final String resourceURI;
  final String name;

  ///Get Comic ID
  String get getComicID {
    return resourceURI.split('/')[6];
  }


  @override
  List<Object?> get props => [
    resourceURI,
    name,
  ];
}
