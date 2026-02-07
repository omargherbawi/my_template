
import '../../../../core/services/api.service.dart';
import '../endpoint/character_endpoint.dart';
import '../model/character_model.dart';

class CharacterRemoteDataSource {
final ApiServices apiServices;

CharacterRemoteDataSource({required this.apiServices});

 Future<List<CharacterModel>> getAllCharacters({int page = 1}) async {
  final response = await apiServices.getData(CharacterEndpoint.getCharacters, queryParameters: {
    'page': page,
  });
  return (response['results'] as List).map((e) => CharacterModel.fromJson(e)).toList();
}

  Future<CharacterModel> getCharacterById(int id) async {
    final response = await apiServices.getData(CharacterEndpoint.getCharacters + '/$id');
    return CharacterModel.fromJson(response);
  }

}