import 'package:tv_showdown/data/models/character_model.dart';

abstract class CharacterRemoteDataSource {
  Future<List<ShowCharacterModel>> getCharactersFromShow(int showId);
}
