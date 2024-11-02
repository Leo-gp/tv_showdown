import 'package:get_it/get_it.dart';
import 'package:tv_showdown/data/data_sources/character_api_data_source.dart';
import 'package:tv_showdown/data/data_sources/character_remote_data_source.dart';
import 'package:tv_showdown/data/data_sources/show_api_data_source.dart';
import 'package:tv_showdown/data/data_sources/show_remote_data_source.dart';
import 'package:tv_showdown/data/repositories/character_repository_impl.dart';
import 'package:tv_showdown/data/repositories/show_repository_impl.dart';
import 'package:tv_showdown/domain/repositories/character_repository.dart';
import 'package:tv_showdown/domain/repositories/show_repository.dart';
import 'package:tv_showdown/domain/use_cases/get_characters_use_case.dart';
import 'package:tv_showdown/domain/use_cases/pick_random_character_use_case.dart';
import 'package:tv_showdown/presentation/bloc/characters_bloc.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Bloc
  getIt.registerFactory(() => CharactersBloc(
        getCharactersUseCase: getIt(),
        pickRandomCharacterUseCase: getIt(),
      ));

  // Usecase
  getIt.registerLazySingleton(() => GetCharactersUseCase(
        showRepository: getIt(),
        characterRepository: getIt(),
      ));

  getIt.registerLazySingleton(() => PickRandomCharacterUseCase());

  // Repository
  getIt.registerLazySingleton<ShowRepository>(
    () => ShowRepositoryImpl(showRemoteDataSource: getIt()),
  );

  getIt.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(characterRemoteDataSource: getIt()),
  );

  // Data source
  getIt.registerLazySingleton<ShowRemoteDataSource>(() => ShowApiDataSource());

  getIt.registerLazySingleton<CharacterRemoteDataSource>(
    () => CharacterApiDataSource(),
  );
}
