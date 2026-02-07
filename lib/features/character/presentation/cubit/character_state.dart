import '../../domain/entities/character_entity.dart';

class CharacterState {

}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<CharacterEntity> characters;
    final bool isLoadingMore;

  CharacterLoaded({required this.characters, required this.isLoadingMore});
}

class CharacterError extends CharacterState {
  final String message;
  CharacterError({required this.message});
}
