import '../../../../global_imports.dart';
import '../../domain/entities/character_entity.dart';
import '../../domain/usecases/get_all_characters_usecase.dart';
import 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final GetAllCharactersUseCase getAllCharactersUseCase;
  final List<CharacterEntity> filteredCharacters = [];
  bool hasMore = true;
  int page = 1;
  bool isFetching = false;
  List<CharacterEntity> characters = [];
  String searchQuery = ''; 

  CharacterCubit({
    required this.getAllCharactersUseCase,
  }) : super(CharacterInitial());

  Future<void> getAllCharacters({bool refresh = false}) async {
    if (isFetching) return;
    if (!hasMore && !refresh) return;

    isFetching = true;

    if (refresh) {
      page = 1;
      characters.clear();
      filteredCharacters.clear();
      hasMore = true;
    }

    if (page == 1) {
      emit(CharacterLoading());
    } else {
      emit(CharacterLoaded(
        characters: filteredCharacters,
        isLoadingMore: true,
        hasMore: hasMore,
      ));
    }

    final result = await getAllCharactersUseCase.call(page: page);

    result.fold(
      (failure) {
        isFetching = false;
        emit(CharacterError(message: failure.message));
      },
      (newCharacters) {
        if (newCharacters.length < 20) {
          hasMore = false;
        }

        characters.addAll(newCharacters);
        final toAdd = searchQuery.isEmpty
            ? newCharacters
            : newCharacters
                .where(
                  (c) =>
                      c.name.toLowerCase().contains(searchQuery.toLowerCase()),
                )
                .toList();
        filteredCharacters.addAll(toAdd);
        page++;

        isFetching = false;

        emit(CharacterLoaded(
          characters: filteredCharacters,
          isLoadingMore: false,
          hasMore: hasMore,
        ));
      },
    );
  }



  void filterCharacters(String query) {
    searchQuery = query;
    filteredCharacters.clear();
    if (query.isEmpty) {
      filteredCharacters.addAll(characters);
    } else {
      filteredCharacters.addAll(
        characters.where(
          (character) => character.name.toLowerCase().contains(query.toLowerCase()),
        ).toList(),
      );
    }
    emit(CharacterLoaded(
      characters: filteredCharacters,
      isLoadingMore: false,
      hasMore: hasMore,
    ));
  }
}

