// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderModelAdapter extends TypeAdapter<OrderModel> {
  @override
  final int typeId = 81;

  @override
  OrderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderModel()
      ..id = fields[0] as int
      ..created_at = fields[3] as String
      ..updated_at = fields[4] as String
      ..customer_name = fields[5] as String
      ..customer_phone = fields[6] as String
      ..customer_address = fields[7] as String
      ..product_price = fields[8] as String
      ..product_name = fields[9] as String
      ..product_id = fields[10] as String
      ..product_photos = fields[11] as String;
  }

  @override
  void write(BinaryWriter writer, OrderModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.created_at)
      ..writeByte(4)
      ..write(obj.updated_at)
      ..writeByte(5)
      ..write(obj.customer_name)
      ..writeByte(6)
      ..write(obj.customer_phone)
      ..writeByte(7)
      ..write(obj.customer_address)
      ..writeByte(8)
      ..write(obj.product_price)
      ..writeByte(9)
      ..write(obj.product_name)
      ..writeByte(10)
      ..write(obj.product_id)
      ..writeByte(11)
      ..write(obj.product_photos);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
