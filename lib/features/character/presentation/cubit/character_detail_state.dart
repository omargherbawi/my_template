import '../../domain/entities/character_entity.dart';

class CharacterDetailState {}

class CharacterDetailInitial extends CharacterDetailState {}

class CharacterDetailLoading extends CharacterDetailState {}

class CharacterDetailLoaded extends CharacterDetailState {
  final CharacterEntity character;
  CharacterDetailLoaded({required this.character});
}

class CharacterDetailError extends CharacterDetailState {
  final String message;
  CharacterDetailError({required this.message});
}
