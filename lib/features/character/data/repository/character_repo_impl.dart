import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/enum/datasource_enum.dart';
import '../../../../core/errors/dio_exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/function/handle_repo_error.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/character_entity.dart';
import '../../domain/repository/character_repo.dart';
import '../datasource/character_local_data_source.dart';
import '../datasource/character_remote_data_source.dart';

class CharacterRepoImpl implements CharacterRepo {
  final NetworkInfo networkInfo;
  final CharacterLocalDataSource localDataSource;
  final CharacterRemoteDataSource remoteDataSource;

  CharacterRepoImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<CharacterEntity>>> getAllCharacters({
    int page = 1,
    required DataSource dataSource,
  }) async {
    try {
      final hasConnection = await networkInfo.isConnected;

      if (!hasConnection || dataSource == DataSource.local) {
        final localList = await localDataSource.getAllCharacters();
        if (localList.isNotEmpty) {
          return right(List<CharacterEntity>.from(localList));
        }
      }

      final characters = await remoteDataSource.getAllCharacters(
        page: page,
      );
      await localDataSource.saveCharacters(characters);
      return right(List<CharacterEntity>.from(characters));
    } on DioException catch (e, t) {
      if (e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        final localList = await localDataSource.getAllCharacters();
        if (localList.isNotEmpty) {
          return right(List<CharacterEntity>.from(localList));
        }
        return left(
          ServerFailure(
            message: 'Request timed out, and no local data is available.',
          ),
        );
      }
      return handleRepoDataError(e, t);
    } catch (e, t) {
      return handleRepoDataError(e, t);
    }
  }

  @override
  Future<Either<Failure, CharacterEntity>> getCharacterById(int id) async {
    try {
      final character = await remoteDataSource.getCharacterById(id);
      return right(character);
    } on ServerFailure catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }
}
