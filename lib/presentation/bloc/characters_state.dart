import 'package:tv_showdown/domain/entities/character.dart';

abstract class CharactersState {}

class CharactersLoadingState extends CharactersState {}

class CharactersLoadFailureState extends CharactersState {}

class CharactersDisplayedState extends CharactersState {
  final Character leftCharacter;
  final Character rightCharacter;

  CharactersDisplayedState({
    required this.leftCharacter,
    required this.rightCharacter,
  });
}
