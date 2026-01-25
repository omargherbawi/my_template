import '../../../../global_imports.dart';
import '../../domain/usecases/get_character_usecase.dart';
import '../../domain/usecases/get_characters_usecase.dart';
import 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final GetCharacters _getCharacters;
  final GetCharacter _getCharacter;

  CharacterCubit({
    required GetCharacters getCharacters,
    required GetCharacter getCharacter,
  })  : _getCharacters = getCharacters,
        _getCharacter = getCharacter,
        super(CharacterInitial());

  Future<void> getCharacters({int page = 1}) async {
    emit(CharacterLoading());
    final result = await _getCharacters.call(page: page);
    result.fold(
      (failure) => emit(CharacterError(message: failure.message, title: failure.title)),
      (characterResponse) => emit(CharacterListLoaded(characterResponse)),
    );
  }

  Future<void> getCharacter(int id) async {
    emit(CharacterLoading());
    final result = await _getCharacter.call(id);
    result.fold(
      (failure) => emit(CharacterError(message: failure.message, title: failure.title)),
      (character) => emit(CharacterDetailLoaded(character)),
    );
  }
}