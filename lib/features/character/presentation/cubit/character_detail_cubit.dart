import '../../../../global_imports.dart';
import '../../domain/usecases/get_single_character_usecase.dart';
import 'character_detail_state.dart';

class CharacterDetailCubit extends Cubit<CharacterDetailState> {
  final GetSingleCharacterUseCase getSingleCharacterUseCase;
  CharacterDetailCubit({required this.getSingleCharacterUseCase}) : super(CharacterDetailInitial());

  Future<void> getCharacterById(int id) async {
    emit(CharacterDetailLoading());
    final result = await getSingleCharacterUseCase.call(id);
    result.fold(
      (l) => emit(CharacterDetailError(message: l.message)),
      (r) => emit(CharacterDetailLoaded(character: r)),
    );
  }
}
