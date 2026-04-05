import 'package:hive_ce/hive.dart';

part 'character_location_model.g.dart';

@HiveType(typeId: 10)
class CharacterLocation {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String url;

  const CharacterLocation({required this.name, required this.url});

  factory CharacterLocation.fromJson(Map<String, dynamic> json) {
    return CharacterLocation(
      name: json['name'] as String? ?? '',
      url: json['url'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'name': name, 'url': url};
}
