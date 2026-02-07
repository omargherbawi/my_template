import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/character_entity.dart';

abstract class CharacterRepo {
   Future < Either<Failure, List<CharacterEntity>> > getAllCharacters({int page = 1});
  Future < Either<Failure, CharacterEntity> > getCharacterById(int id);
}