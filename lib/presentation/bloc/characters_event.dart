import 'package:tv_showdown/domain/entities/character.dart';

abstract class CharactersEvent {}

class CharactersLoadStartedEvent extends CharactersEvent {}

class CharactersSelectedEvent extends CharactersEvent {
  final Character selectedCharacter;

  CharactersSelectedEvent({required this.selectedCharacter});
}
