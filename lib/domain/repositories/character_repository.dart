import 'package:dartz/dartz.dart';
import 'package:tv_showdown/core/error/failure.dart';
import 'package:tv_showdown/domain/entities/character.dart';

abstract class CharacterRepository {
  Future<Either<Failure, List<Character>>> getCharactersFromShow(int showId);
}
