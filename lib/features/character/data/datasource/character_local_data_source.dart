import '../../../../global_imports.dart';
import '../model/character_model.dart';

abstract class CharacterLocalDataSource {
  Future<List<CharacterModel>> getAllCharacters();

  Future<void> saveCharacters(List<CharacterModel> characters);
}

class CharacterLocalDataSourceImpl extends CharacterLocalDataSource {
  final Box<CharacterModel> _box;

  CharacterLocalDataSourceImpl({
    required Box<CharacterModel> box,
  }) : _box = box;

  @override
  Future<List<CharacterModel>> getAllCharacters() async {
    return _box.values.toList();
  }

  @override
  Future<void> saveCharacters(List<CharacterModel> characters) async {
    await _box.putAll({
      for (final character in characters) character.id: character,
    });
  }
}
