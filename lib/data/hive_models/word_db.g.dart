// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WordDBAdapter extends TypeAdapter<WordDB> {
  @override
  final int typeId = 0;

  @override
  WordDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WordDB(
      id: fields[0] as String?,
      word: fields[1] as String?,
      isFavourite: fields[2] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, WordDB obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.word)
      ..writeByte(2)
      ..write(obj.isFavourite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
