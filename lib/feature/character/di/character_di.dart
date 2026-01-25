import '../../../global_imports.dart';
import '../data/datasource/character_data_source.dart';
import '../data/repository/character_repository_impl.dart';
import '../domain/repository/character_repository.dart';
import '../domain/usecases/get_character_usecase.dart';
import '../domain/usecases/get_characters_usecase.dart';
import '../presentation/cubit/character_cubit.dart';

void initCharacterDI() {
  // External Dio for Rick and Morty API
  getIt.registerLazySingleton<Dio>(
    () => Dio(),
    instanceName: 'characterDio',
  );

  // Data Source
  getIt.registerLazySingleton<CharacterDataSource>(
    () => CharacterRemoteDataSource(dio: getIt<Dio>(instanceName: 'characterDio')),
  );

  // Repository
  getIt.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(characterDataSource: getIt<CharacterDataSource>()),
  );

  // Use Cases
  getIt.registerLazySingleton<GetCharacters>(
    () => GetCharacters(repository: getIt<CharacterRepository>()),
  );

  getIt.registerLazySingleton<GetCharacter>(
    () => GetCharacter(repository: getIt<CharacterRepository>()),
  );

  // Cubit
  getIt.registerFactory<CharacterCubit>(
    () => CharacterCubit(
      getCharacters: getIt<GetCharacters>(),
      getCharacter: getIt<GetCharacter>(),
    ),
  );
}