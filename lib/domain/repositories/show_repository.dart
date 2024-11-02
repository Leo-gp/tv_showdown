import 'package:dartz/dartz.dart';
import 'package:tv_showdown/core/error/failure.dart';
import 'package:tv_showdown/domain/entities/show.dart';

abstract class ShowRepository {
  Future<Either<Failure, List<Show>>> getShows();
}
