import '../../../domain/entities/sub_entities/character_location.dart';

class CharacterLocationModel extends CharacterLocation {
  CharacterLocationModel({
    required super.name,
    required super.url,
  });

  factory CharacterLocationModel.fromJson(Map<String, dynamic> json) {
    return CharacterLocationModel(
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