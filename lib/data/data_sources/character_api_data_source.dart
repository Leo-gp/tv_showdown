import 'dart:convert';

import 'package:tv_showdown/core/error/exception.dart';
import 'package:tv_showdown/data/data_sources/api_constants.dart';
import 'package:tv_showdown/data/data_sources/character_remote_data_source.dart';
import 'package:tv_showdown/data/models/character_model.dart';
import 'package:http/http.dart' as http;

class CharacterApiDataSource implements CharacterRemoteDataSource {
  @override
  Future<List<ShowCharacterModel>> getCharactersFromShow(int showId) async {
    final Uri uri = Uri.https(
      ApiConstants.baseUrl,
      "${ApiConstants.showsPath}/$showId${ApiConstants.charactersPath}",
    );
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> charactersJson = jsonDecode(response.body);
      return charactersJson
          .map((character) => ShowCharacterModel.fromJson(character))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
