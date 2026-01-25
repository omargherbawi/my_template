import '../../domain/entities/character_entity.dart';
import 'sub_models/character_origin_model.dart';
import 'sub_models/character_location_model.dart';

class CharacterModel extends CharacterEntity {
  CharacterModel({
    required super.id,
    required super.name,
    required super.status,
    required super.species,
    required super.type,
    required super.gender,
    required super.origin,
    required super.location,
    required super.image,
    required super.episode,
    required super.url,
    required super.created,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      status: json['status'] as String? ?? '',
      species: json['species'] as String? ?? '',
      type: json['type'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      origin: CharacterOriginModel.fromJson(json['origin'] as Map<String, dynamic>? ?? {}),
      location: CharacterLocationModel.fromJson(json['location'] as Map<String, dynamic>? ?? {}),
      image: json['image'] as String? ?? '',
      episode: List<String>.from(json['episode'] as List? ?? []),
      url: json['url'] as String? ?? '',
      created: json['created'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'origin': (origin as CharacterOriginModel).toJson(),
      'location': (location as CharacterLocationModel).toJson(),
      'image': image,
      'episode': episode,
      'url': url,
      'created': created,
    };
  }
}