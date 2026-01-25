import '../../../../global_imports.dart';
import '../entities/character_entity.dart';

abstract class CharacterRepository {
  Future<Either<Failure, CharacterResponse>> getCharacters({int page = 1});
  Future<Either<Failure, CharacterEntity>> getCharacter(int id);
}