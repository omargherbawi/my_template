// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterModelAdapter extends TypeAdapter<CharacterModel> {
  @override
  final typeId = 11;

  @override
  CharacterModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharacterModel(
      id: (fields[0] as num).toInt(),
      name: fields[1] as String,
      image: fields[2] as String,
      status: fields[3] as String,
      species: fields[4] as String,
      gender: fields[5] as String,
      episodes: (fields[6] as List).cast<int>(),
      type: fields[7] == null ? '' : fields[7] as String,
      origin: fields[8] as CharacterLocation,
      location: fields[9] as CharacterLocation,
      episodeUrls: (fields[10] as List).cast<String>(),
      url: fields[11] == null ? '' : fields[11] as String,
      created: fields[12] == null ? '' : fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CharacterModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.species)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.episodes)
      ..writeByte(7)
      ..write(obj.type)
      ..writeByte(8)
      ..write(obj.origin)
      ..writeByte(9)
      ..write(obj.location)
      ..writeByte(10)
      ..write(obj.episodeUrls)
      ..writeByte(11)
      ..write(obj.url)
      ..writeByte(12)
      ..write(obj.created);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
