import '../../../../global_imports.dart';
import '../../domain/entities/character_entity.dart';
import '../../domain/usecases/get_all_characters_usecase.dart';
import 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final GetAllCharactersUseCase getAllCharactersUseCase;

  bool hasMore = true;        
  int page = 1;             
  bool isFetching = false;  
  List<CharacterEntity> characters = []; 

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
      hasMore = true;
    }

    if (page == 1) {
      emit(CharacterLoading());
    } else {
      emit(CharacterLoaded(
        characters: characters,
        isLoadingMore: true,
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

        page++;

        isFetching = false;

        emit(CharacterLoaded(
          characters: characters,
          isLoadingMore: false,
        ));
      },
    );
  }
}
