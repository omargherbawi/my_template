import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/character_entity.dart';
import '../repository/character_repo.dart';

class GetSingleCharacterUseCase {
  final CharacterRepo repository;

  GetSingleCharacterUseCase({required this.repository});

  Future<Either<Failure, CharacterEntity>> call(int id) async {
    return  repository.getCharacterById(id);
  }
}
  