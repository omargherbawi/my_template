import '../../../domain/entities/sub_entities/character_response.dart';
import '../character_model.dart';
import 'character_info_model.dart';

class CharacterResponseModel extends CharacterResponse {
  CharacterResponseModel({
    required super.info,
    required super.results,
  });

  factory CharacterResponseModel.fromJson(Map<String, dynamic> json) {
    return CharacterResponseModel(
      info: CharacterInfoModel.fromJson(json['info'] as Map<String, dynamic>? ?? {}),
      results: (json['results'] as List<dynamic>? ?? [])
          .map((item) => CharacterModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'info': (info as CharacterInfoModel).toJson(),
      'results': results.map((character) => (character as CharacterModel).toJson()).toList(),
    };
  }
}