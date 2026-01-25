import '../../../../global_imports.dart';
import '../../domain/usecases/get_character_usecase.dart';
import '../../domain/usecases/get_characters_usecase.dart';
import '../../domain/entities/character_entity.dart';
import '../../domain/entities/sub_entities/paginated_response.dart';
import 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final GetCharacters getCharactersUseCase;
  final GetCharacter getCharacterUseCase;
  
  List<CharacterEntity> allCharacters = [];
  List<CharacterEntity> filteredCharacters = [];
  Pagination? currentPagination;
  String currentSearchQuery = '';
  bool isLoadingMore = false;
  DateTime? lastRequestTime;
  DateTime? rateLimitCooldownUntil;
  static const Duration minRequestInterval = Duration(milliseconds: 500);
  static const Duration rateLimitCooldown = Duration(seconds: 60);

  CharacterCubit({
    required GetCharacters getCharacters,
    required GetCharacter getCharacter,
  })  : getCharactersUseCase = getCharacters,
        getCharacterUseCase = getCharacter,
        super(CharacterInitial());

  Future<void> getCharacters({bool refresh = false}) async {
    if (refresh) {
      allCharacters.clear();
      filteredCharacters.clear();
      currentPagination = null;
      currentSearchQuery = '';
      rateLimitCooldownUntil = null; // Reset cooldown on refresh
    }
    
    emit(CharacterLoading());
    lastRequestTime = DateTime.now();
    
    final result = await getCharactersUseCase.call(page: 1);
    result.fold(
      (failure) {
        // Handle 429 rate limit errors
        if (failure.message.contains('429') || failure.message.toLowerCase().contains('rate limit')) {
          rateLimitCooldownUntil = DateTime.now().add(rateLimitCooldown);
          emit(CharacterError(
            message: 'Rate limit exceeded. Please wait ${rateLimitCooldown.inSeconds} seconds before trying again.', 
            title: 'Too Many Requests'
          ));
        } else {
          emit(CharacterError(message: failure.message, title: failure.title));
        }
      },
      (characterResponse) {
        rateLimitCooldownUntil = null; // Reset cooldown on successful request
        allCharacters = characterResponse.results;
        currentPagination = Pagination.fromCharacterInfo(characterResponse.info, 1);
        
        if (currentSearchQuery.isNotEmpty) {
          filteredCharacters = allCharacters
              .where((character) => 
                  character.name.toLowerCase().contains(currentSearchQuery.toLowerCase()))
              .toList();
        } else {
          filteredCharacters = List.from(allCharacters);
        }
        
        emit(CharacterListLoaded(
          characters: filteredCharacters,
          pagination: currentPagination!,
        ));
      },
    );
  }

  Future<void> loadMoreCharacters() async {
    // Enhanced rate limiting checks
    if (currentPagination == null || 
        !currentPagination!.hasMore || 
        isLoadingMore ||
        currentSearchQuery.isNotEmpty) {
      return;
    }

    // Check if we're in rate limit cooldown
    final now = DateTime.now();
    if (rateLimitCooldownUntil != null && now.isBefore(rateLimitCooldownUntil!)) {
      return; // Still in cooldown period
    }

    // Check minimum request interval
    if (lastRequestTime != null && 
        now.difference(lastRequestTime!).inMilliseconds < minRequestInterval.inMilliseconds) {
      return; // Too soon since last request
    }

    isLoadingMore = true;
    lastRequestTime = now;
    
    final currentState = state;
    if (currentState is CharacterListLoaded) {
      emit(currentState.copyWith(isLoadingMore: true));
    }

    final nextPage = currentPagination!.currentPage + 1;
    final result = await getCharactersUseCase.call(page: nextPage);
    
    result.fold(
      (failure) {
        isLoadingMore = false;
        
        // Handle 429 rate limit errors specifically
        if (failure.message.contains('429') || failure.message.toLowerCase().contains('rate limit')) {
          rateLimitCooldownUntil = DateTime.now().add(rateLimitCooldown);
          print('Rate limit hit, cooling down for ${rateLimitCooldown.inSeconds} seconds');
        }
        
        if (currentState is CharacterListLoaded) {
          emit(currentState.copyWith(isLoadingMore: false));
        }
      },
      (characterResponse) {
        isLoadingMore = false;
        rateLimitCooldownUntil = null; // Reset cooldown on successful request
        
        allCharacters.addAll(characterResponse.results);
        currentPagination = Pagination.fromCharacterInfo(characterResponse.info, nextPage);
        
        if (currentSearchQuery.isNotEmpty) {
          filteredCharacters = allCharacters
              .where((character) => 
                  character.name.toLowerCase().contains(currentSearchQuery.toLowerCase()))
              .toList();
        } else {
          filteredCharacters = List.from(allCharacters);
        }
        
        emit(CharacterListLoaded(
          characters: filteredCharacters,
          pagination: currentPagination!,
          isLoadingMore: false,
        ));
      },
    );
  }

  void searchCharacters(String query) {
    currentSearchQuery = query;
    
    if (query.isEmpty) {
      filteredCharacters = List.from(allCharacters);
    } else {
      filteredCharacters = allCharacters
          .where((character) => 
              character.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    if (currentPagination != null) {
      emit(CharacterListLoaded(
        characters: filteredCharacters,
        pagination: currentPagination!,
      ));
    }
  }

  Future<void> getCharacter(int id) async {
    emit(CharacterLoading());
    final result = await getCharacterUseCase.call(id);
    result.fold(
      (failure) => emit(CharacterError(message: failure.message, title: failure.title)),
      (character) => emit(CharacterDetailLoaded(character)),
    );
  }
}