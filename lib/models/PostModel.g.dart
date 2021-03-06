// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PostModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostModelAdapter extends TypeAdapter<PostModel> {
  @override
  final int typeId = 53;

  @override
  PostModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostModel()
      ..id = fields[0] as int
      ..created_at = fields[1] as String
      ..administrator_id = fields[2] as String
      ..views = fields[3] as String
      ..comments = fields[4] as String
      ..text = fields[5] as String
      ..thumnnail = fields[6] as String
      ..images = fields[7] as String
      ..audio = fields[8] as String
      ..posted_by = fields[9] as String
      ..post_category_id = fields[10] as String;
  }

  @override
  void write(BinaryWriter writer, PostModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.created_at)
      ..writeByte(2)
      ..write(obj.administrator_id)
      ..writeByte(3)
      ..write(obj.views)
      ..writeByte(4)
      ..write(obj.comments)
      ..writeByte(5)
      ..write(obj.text)
      ..writeByte(6)
      ..write(obj.thumnnail)
      ..writeByte(7)
      ..write(obj.images)
      ..writeByte(8)
      ..write(obj.audio)
      ..writeByte(9)
      ..write(obj.posted_by)
      ..writeByte(10)
      ..write(obj.post_category_id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
