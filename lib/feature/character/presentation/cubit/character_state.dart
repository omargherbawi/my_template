import '../../domain/entities/character_entity.dart';

abstract class CharacterState {}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterListLoaded extends CharacterState {
  final CharacterResponse characterResponse;

  CharacterListLoaded(this.characterResponse);
}

class CharacterDetailLoaded extends CharacterState {
  final CharacterEntity character;

  CharacterDetailLoaded(this.character);
}

class CharacterError extends CharacterState {
  final String message;
  final String? title;

  CharacterError({required this.message, this.title});
}