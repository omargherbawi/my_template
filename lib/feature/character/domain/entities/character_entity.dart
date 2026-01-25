class CharacterEntity {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final CharacterOrigin origin;
  final CharacterLocation location;
  final String image;
  final List<String> episode;
  final String url;
  final String created;

  CharacterEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });
}

class CharacterOrigin {
  final String name;
  final String url;

  CharacterOrigin({
    required this.name,
    required this.url,
  });
}

class CharacterLocation {
  final String name;
  final String url;

  CharacterLocation({
    required this.name,
    required this.url,
  });
}

class CharacterResponse {
  final CharacterInfo info;
  final List<CharacterEntity> results;

  CharacterResponse({
    required this.info,
    required this.results,
  });
}

class CharacterInfo {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  CharacterInfo({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });
}