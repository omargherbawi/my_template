import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/character_entity.dart';
import '../repository/character_repository.dart';

class GetCharacter {
  final CharacterRepository repository;

  GetCharacter({required this.repository});

  Future<Either<Failure, CharacterEntity>> call(int id) {
    return repository.getCharacter(id);
  }
}