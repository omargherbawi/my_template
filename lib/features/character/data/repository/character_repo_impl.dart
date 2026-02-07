import 'package:dartz/dartz.dart';

import '../../../../core/errors/dio_exception.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/character_entity.dart';
import '../../domain/repository/character_repo.dart';
import '../datasource/character_remote_data_source.dart';

class CharacterRepoImpl implements CharacterRepo {
  final CharacterRemoteDataSource remoteDataSource;

  CharacterRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<CharacterEntity>>> getAllCharacters({int page = 1}) async {
   try {
    final characters = await remoteDataSource.getAllCharacters(page: page);
    return right(characters);
   } on ServerFailure catch (e) {
    return left(ServerFailure(message: e.message));
     
   }
  }

  @override
  Future<Either<Failure, CharacterEntity>> getCharacterById(int id) async {
    try {
      final  character = await remoteDataSource.getCharacterById(id);
      return right(character);
    } on ServerFailure catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }
}