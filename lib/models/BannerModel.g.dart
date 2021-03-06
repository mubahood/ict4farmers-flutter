// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BannerModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BannerModelAdapter extends TypeAdapter<BannerModel> {
  @override
  final int typeId = 20;

  @override
  BannerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BannerModel()
      ..id = fields[0] as int
      ..created_at = fields[1] as String
      ..section = fields[2] as String
      ..position = fields[3] as String
      ..name = fields[4] as String
      ..sub_title = fields[5] as String
      ..type = fields[6] as String
      ..category_id = fields[7] as String
      ..product_id = fields[8] as String
      ..clicks = fields[9] as String
      ..image = fields[10] as String;
  }

  @override
  void write(BinaryWriter writer, BannerModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.created_at)
      ..writeByte(2)
      ..write(obj.section)
      ..writeByte(3)
      ..write(obj.position)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.sub_title)
      ..writeByte(6)
      ..write(obj.type)
      ..writeByte(7)
      ..write(obj.category_id)
      ..writeByte(8)
      ..write(obj.product_id)
      ..writeByte(9)
      ..write(obj.clicks)
      ..writeByte(10)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BannerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
