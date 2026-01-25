import '../../../domain/entities/sub_entities/character_info.dart';

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