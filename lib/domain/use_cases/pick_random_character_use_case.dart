import 'dart:math';

import 'package:tv_showdown/domain/entities/character.dart';

class PickRandomCharacterUseCase {
  final Random _random = Random();

  Character call({required List<Character> characters, Character? exclude}) {
    final availableCharacters = exclude != null
        ? characters.where((character) => exclude != character).toList()
        : characters;
    return availableCharacters[_random.nextInt(availableCharacters.length)];
  }
}
