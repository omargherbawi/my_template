import '../../../../global_imports.dart';
import '../../domain/usecases/get_all_characters_usecase.dart';
import 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final GetAllCharactersUseCase getAllCharactersUseCase;
  CharacterCubit({required this.getAllCharactersUseCase}) : super(CharacterInitial());

   getAllCharacters() async {
    emit(CharacterLoading());
final result = await getAllCharactersUseCase.call();
result.fold((l) => emit(CharacterError(message: l.message)), (r) => emit(CharacterLoaded(characters: r)));
  }
 
}