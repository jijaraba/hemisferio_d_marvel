import 'package:equatable/equatable.dart';

class CharacterSearchData extends Equatable {
  const CharacterSearchData({
    required this.search,
    required this.limit,
    required this.offset,
  });

  final int limit;
  final int offset;
  final String search;

  String toQueryParam() {
    final buffer = StringBuffer();
    final offsetNew = offset * limit;

    buffer
      ..write('?')
      ..write('limit=$limit');
    buffer
      ..write('&')
      ..write('offset=$offsetNew');
    if (search != '') {
      buffer
        ..write('&')
        ..write('nameStartsWith=$search');
    }
    return buffer.toString();
  }

  @override
  List<Object?> get props => [
    limit,
    offset,
    search,
  ];
}
