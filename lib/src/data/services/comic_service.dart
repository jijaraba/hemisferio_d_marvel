import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:marvel_hemisferio/src/data/models/comic_model.dart';

abstract class ComicService {
  Future<List<ComicModel>?> getComic(int comicId);
}

class ComicServiceImpl implements ComicService {
  ComicServiceImpl(this._client, {
    required this.privateKey,
    required this.publicKey,
  });

  final Dio _client;
  final String privateKey;
  final String publicKey;

  @override
  Future<List<ComicModel>?> getComic(
      int comicId) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final hash = md5
          .convert(utf8.encode(timestamp) +
              utf8.encode(privateKey) +
              utf8.encode(publicKey))
          .toString();

      final response = await _client.get(
        '/comics/$comicId?apikey=$publicKey&hash=$hash&ts=$timestamp',
      );
      if (response.statusCode == 200) {
        return (response.data['data']['results']! as List)
            .map((x) => ComicModel.fromJson(x))
            .toList();
      }
      return null;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

}
