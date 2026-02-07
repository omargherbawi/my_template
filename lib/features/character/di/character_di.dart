import 'package:get_it/get_it.dart';

import '../../../core/services/api.service.dart';
import '../data/datasource/character_remote_data_source.dart';
import '../data/repository/character_repo_impl.dart';
import '../domain/repository/character_repo.dart';
import '../domain/usecases/get_all_characters_usecase.dart';
import '../domain/usecases/get_single_character_usecase.dart';
import '../presentation/cubit/character_cubit.dart';
import '../presentation/cubit/character_detail_cubit.dart';

final getIt = GetIt.instance;

void initCharacterDi() {
getIt.registerLazySingleton <CharacterRemoteDataSource>(() => CharacterRemoteDataSource(apiServices: getIt<ApiServices>()));
getIt.registerLazySingleton <CharacterRepo>(() => CharacterRepoImpl(remoteDataSource: getIt<CharacterRemoteDataSource>()));
getIt.registerLazySingleton <GetAllCharactersUseCase>(() => GetAllCharactersUseCase(repository: getIt<CharacterRepo>()));
getIt.registerLazySingleton <GetSingleCharacterUseCase>(() => GetSingleCharacterUseCase(repository: getIt<CharacterRepo>()));
getIt.registerFactory <CharacterCubit>(() => CharacterCubit(getAllCharactersUseCase: getIt<GetAllCharactersUseCase>()));
getIt.registerFactory <CharacterDetailCubit>(() => CharacterDetailCubit(getSingleCharacterUseCase: getIt<GetSingleCharacterUseCase>()));
}