import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/character_entity.dart';

abstract class CharacterRepo {
   Future < Either<Failure, List<CharacterEntity>> > getAllCharacters();
  Future < Either<Failure, CharacterEntity> > getCharacterById(int id);
}