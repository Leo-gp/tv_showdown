import 'package:dartz/dartz.dart';
import 'package:tv_showdown/core/error/failure.dart';
import 'package:tv_showdown/domain/entities/character.dart';
import 'package:tv_showdown/domain/entities/show.dart';
import 'package:tv_showdown/domain/repositories/character_repository.dart';
import 'package:tv_showdown/domain/repositories/show_repository.dart';

class GetCharactersUseCase {
  final ShowRepository _showRepository;
  final CharacterRepository _characterRepository;

  const GetCharactersUseCase({
    required ShowRepository showRepository,
    required CharacterRepository characterRepository,
  })  : _showRepository = showRepository,
        _characterRepository = characterRepository;

  Future<Either<Failure, List<Character>>> call() async {
    final showsEither = await _showRepository.getShows();
    final List<Show> shows = [];
    Failure? failure;
    showsEither.fold(
      (failureResult) => failure = failureResult,
      (showsResult) => shows.addAll(showsResult),
    );
    if (failure != null) {
      return Left(failure!);
    }
    final filteredShows = (shows.where((show) => show.weight > 90).toList()
          ..shuffle())
        .take(15) // TODO: Rate Limiting. Remove once API retry is implemented
        .toList();
    final showCharactersMap = <Show, List<Character>>{};
    for (final show in filteredShows) {
      final charactersEither =
          await _characterRepository.getCharactersFromShow(show.id);
      Failure? failure;
      charactersEither.fold(
        (failureResult) => failure = failureResult,
        (charactersResult) => showCharactersMap[show] = charactersResult,
      );
      if (failure != null) {
        return Left(failure!);
      }
    }
    final List<Character> characters = [];
    showCharactersMap.forEach((show, showCharacters) {
      final charactersToAdd = showCharacters
          .where((character) =>
              character.image != null && character.name.length <= 12)
          .map((character) => character.copyWith(
                showName: show.name,
                name: character.isSelf ? character.personName : character.name,
              ))
          .toList();
      characters.addAll(charactersToAdd);
    });
    return Right(characters);
  }
}
