import 'package:dartz/dartz.dart';
import 'package:tv_showdown/core/error/exception.dart';
import 'package:tv_showdown/core/error/failure.dart';
import 'package:tv_showdown/data/data_sources/show_remote_data_source.dart';
import 'package:tv_showdown/domain/entities/show.dart';
import 'package:tv_showdown/domain/repositories/show_repository.dart';

class ShowRepositoryImpl implements ShowRepository {
  static const int _targetShowPagesAmount = 3;

  final ShowRemoteDataSource _showRemoteDataSource;

  const ShowRepositoryImpl({
    required ShowRemoteDataSource showRemoteDataSource,
  }) : _showRemoteDataSource = showRemoteDataSource;

  @override
  Future<Either<Failure, List<Show>>> getShows() async {
    try {
      final List<Show> shows = [];
      for (var i = 0; i < _targetShowPagesAmount; i++) {
        final pageShows = await _showRemoteDataSource.getShowsByPage(i);
        shows.addAll(pageShows);
      }
      return Right(shows);
    } on ServerException {
      return const Left(ServerFailure(message: "Failed to load shows."));
    }
  }
}
