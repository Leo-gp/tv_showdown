import 'package:dartz/dartz.dart';
import 'package:tv_showdown/core/error/exception.dart';
import 'package:tv_showdown/core/error/failure.dart';
import 'package:tv_showdown/data/data_sources/character_remote_data_source.dart';
import 'package:tv_showdown/domain/entities/character.dart';
import 'package:tv_showdown/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource _characterRemoteDataSource;

  const CharacterRepositoryImpl({
    required CharacterRemoteDataSource characterRemoteDataSource,
  }) : _characterRemoteDataSource = characterRemoteDataSource;

  @override
  Future<Either<Failure, List<Character>>> getCharactersFromShow(
      int showId) async {
    try {
      final characters =
          await _characterRemoteDataSource.getCharactersFromShow(showId);
      return Right(characters);
    } on ServerException {
      return Left(
        ServerFailure(message: "Failed to load characters from show $showId."),
      );
    }
  }
}
