import '../../domain/entities/character_entity.dart';
import 'submodels/character_location_model.dart';



class CharacterModel extends CharacterEntity {
  final String type;
  final CharacterLocation origin;
  final CharacterLocation location;
  final List<String> episodeUrls;
  final String url;
  final String created;

  CharacterModel({
    required super.id,
    required super.name,
    required super.image,
    required super.status,
    required super.species,
    required super.gender,
    required super.episodes,
    this.type = '',
    required this.origin,
    required this.location,
    required this.episodeUrls,
    this.url = '',
    this.created = '',
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    final episodeList = json['episode'] as List<dynamic>? ?? [];
    final episodeUrls = episodeList.map((e) => e.toString()).toList();
    final episodes = episodeUrls
        .map((url) {
          final match = RegExp(r'/episode/(\d+)$').firstMatch(url);
          return match != null ? int.tryParse(match.group(1) ?? '') : null;
        })
        .whereType<int>()
        .toList();

    return CharacterModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      status: json['status'] as String? ?? '',
      species: json['species'] as String? ?? '',
      type: json['type'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      origin: CharacterLocation.fromJson(
        Map<String, dynamic>.from(json['origin'] as Map? ?? {}),
      ),
      location: CharacterLocation.fromJson(
        Map<String, dynamic>.from(json['location'] as Map? ?? {}),
      ),
      image: json['image'] as String? ?? '',
      episodeUrls: episodeUrls,
      episodes: episodes,
      url: json['url'] as String? ?? '',
      created: json['created'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'status': status,
        'species': species,
        'type': type,
        'gender': gender,
        'origin': origin.toJson(),
        'location': location.toJson(),
        'image': image,
        'episode': episodeUrls,
        'url': url,
        'created': created,
      };
}
