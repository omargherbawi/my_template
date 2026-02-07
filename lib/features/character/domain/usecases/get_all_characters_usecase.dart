import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/character_entity.dart';
import '../repository/character_repo.dart';

class GetAllCharactersUseCase {
  final CharacterRepo repository;

  GetAllCharactersUseCase({required this.repository});

   Future<Either<Failure, List<CharacterEntity>>> call({int page = 1}) async {
     return repository.getAllCharacters(page: page);
  }
}