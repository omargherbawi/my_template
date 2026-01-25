import '../../../domain/entities/sub_entities/character_origin.dart';

class CharacterOriginModel extends CharacterOrigin {
  CharacterOriginModel({
    required super.name,
    required super.url,
  });

  factory CharacterOriginModel.fromJson(Map<String, dynamic> json) {
    return CharacterOriginModel(
      name: json['name'] as String? ?? '',
      url: json['url'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}