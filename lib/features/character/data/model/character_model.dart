import 'package:hive_ce/hive.dart';

import '../../domain/entities/character_entity.dart';
import 'submodels/character_location_model.dart';

part 'character_model.g.dart';

@HiveType(typeId: 11)
class CharacterModel extends CharacterEntity {
  @override
  @HiveField(0)
  int get id => super.id;

  @override
  @HiveField(1)
  String get name => super.name;

  @override
  @HiveField(2)
  String get image => super.image;

  @override
  @HiveField(3)
  String get status => super.status;

  @override
  @HiveField(4)
  String get species => super.species;

  @override
  @HiveField(5)
  String get gender => super.gender;

  @override
  @HiveField(6)
  List<int> get episodes => super.episodes;

  @HiveField(7)
  final String type;
  @HiveField(8)
  final CharacterLocation origin;
  @HiveField(9)
  final CharacterLocation location;
  @HiveField(10)
  final List<String> episodeUrls;
  @HiveField(11)
  final String url;
  @HiveField(12)
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
