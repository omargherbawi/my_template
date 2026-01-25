import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/sub_entities/character_response.dart';
import '../repository/character_repository.dart';

class GetCharacters {
  final CharacterRepository repository;

  GetCharacters({required this.repository});

  Future<Either<Failure, CharacterResponse>> call({int page = 1}) {
    return repository.getCharacters(page: page);
  }
}