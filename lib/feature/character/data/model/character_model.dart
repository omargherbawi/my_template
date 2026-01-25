import '../../domain/entities/character_entity.dart';

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

class CharacterInfoModel extends CharacterInfo {
  CharacterInfoModel({
    required super.count,
    required super.pages,
    super.next,
    super.prev,
  });

  factory CharacterInfoModel.fromJson(Map<String, dynamic> json) {
    return CharacterInfoModel(
      count: json['count'] as int? ?? 0,
      pages: json['pages'] as int? ?? 0,
      next: json['next'] as String?,
      prev: json['prev'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'pages': pages,
      'next': next,
      'prev': prev,
    };
  }
}

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