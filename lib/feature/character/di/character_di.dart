import '../../../global_imports.dart';
import '../data/datasource/character_data_source.dart';
import '../data/repository/character_repository_impl.dart';
import '../domain/repository/character_repository.dart';
import '../domain/usecases/get_character_usecase.dart';
import '../domain/usecases/get_characters_usecase.dart';
import '../presentation/cubit/character_cubit.dart';

void initCharacterDI() {
  getIt.registerLazySingleton<Dio>(
    () => Dio(),
    instanceName: 'characterDio',
  );

  getIt.registerLazySingleton<CharacterDataSource>(
    () => CharacterRemoteDataSource(dio: getIt<Dio>(instanceName: 'characterDio')),
  );

  getIt.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(characterDataSource: getIt<CharacterDataSource>()),
  );

  getIt.registerLazySingleton<GetCharacters>(
    () => GetCharacters(repository: getIt<CharacterRepository>()),
  );

  getIt.registerLazySingleton<GetCharacter>(
    () => GetCharacter(repository: getIt<CharacterRepository>()),
  );

  getIt.registerFactory<CharacterCubit>(
    () => CharacterCubit(
      getCharacters: getIt<GetCharacters>(),
      getCharacter: getIt<GetCharacter>(),
    ),
  );
}