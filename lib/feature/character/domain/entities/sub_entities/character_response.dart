import '../character_entity.dart';
import 'character_info.dart';

class CharacterResponse {
  final CharacterInfo info;
  final List<CharacterEntity> results;

  CharacterResponse({
    required this.info,
    required this.results,
  });
}