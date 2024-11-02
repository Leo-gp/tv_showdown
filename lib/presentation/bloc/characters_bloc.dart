import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_showdown/domain/entities/character.dart';
import 'package:tv_showdown/domain/use_cases/get_characters_use_case.dart';
import 'package:tv_showdown/domain/use_cases/pick_random_character_use_case.dart';
import 'package:tv_showdown/presentation/bloc/characters_event.dart';
import 'package:tv_showdown/presentation/bloc/characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final GetCharactersUseCase _getCharactersUseCase;
  final PickRandomCharacterUseCase _pickRandomCharacterUseCase;

  final List<Character> _characters = [];

  CharactersBloc({
    required GetCharactersUseCase getCharactersUseCase,
    required PickRandomCharacterUseCase pickRandomCharacterUseCase,
  })  : _getCharactersUseCase = getCharactersUseCase,
        _pickRandomCharacterUseCase = pickRandomCharacterUseCase,
        super(CharactersLoadingState()) {
    on<CharactersLoadStartedEvent>(_onCharactersLoadStarted);
  }

  Future<void> _onCharactersLoadStarted(
    CharactersLoadStartedEvent event,
    Emitter<CharactersState> emit,
  ) async {
    emit(CharactersLoadingState());
    final charctersEither = await _getCharactersUseCase();
    charctersEither.fold(
      (failure) {
        emit(CharactersLoadFailureState());
      },
      (charactersResult) {
        _characters.addAll(charactersResult);
        final leftCharacter =
            _pickRandomCharacterUseCase(characters: _characters);
        final rightCharacter = _pickRandomCharacterUseCase(
          characters: _characters,
          exclude: leftCharacter,
        );
        emit(CharactersDisplayedState(
          leftCharacter: leftCharacter,
          rightCharacter: rightCharacter,
        ));
      },
    );
  }
}
