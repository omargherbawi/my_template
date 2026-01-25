import '../../../../global_imports.dart';
import '../../domain/entities/character_entity.dart';
import '../../domain/entities/sub_entities/character_response.dart';
import '../../domain/repository/character_repository.dart';
import '../datasource/character_data_source.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterDataSource characterDataSource;

  CharacterRepositoryImpl({required this.characterDataSource});

  @override
  Future<Either<Failure, CharacterResponse>> getCharacters({int page = 1}) async {
    try {
      final characters = await characterDataSource.getCharacters(page: page);
      return right(characters);
    } on DioException catch (e, t) {
      return handleRepoDataError(e, t);
    } catch (e, t) {
      return handleRepoDataError(e, t);
    }
  }

  @override
  Future<Either<Failure, CharacterEntity>> getCharacter(int id) async {
    try {
      final character = await characterDataSource.getCharacter(id);
      return right(character);
    } on DioException catch (e, t) {
      return handleRepoDataError(e, t);
    } catch (e, t) {
      return handleRepoDataError(e, t);
    }
  }
}