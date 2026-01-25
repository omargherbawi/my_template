import '../../domain/entities/character_entity.dart';
import '../../domain/entities/sub_entities/paginated_response.dart';

abstract class CharacterState {}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterListLoaded extends CharacterState {
  final List<CharacterEntity> characters;
  final Pagination pagination;
  final bool isLoadingMore;

  CharacterListLoaded({
    required this.characters,
    required this.pagination,
    this.isLoadingMore = false,
  });

  CharacterListLoaded copyWith({
    List<CharacterEntity>? characters,
    Pagination? pagination,
    bool? isLoadingMore,
  }) {
    return CharacterListLoaded(
      characters: characters ?? this.characters,
      pagination: pagination ?? this.pagination,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
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