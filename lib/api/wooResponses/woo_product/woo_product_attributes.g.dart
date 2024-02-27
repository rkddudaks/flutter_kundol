// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'woo_product_attributes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WooProductAttributesAdapter extends TypeAdapter<WooProductAttributes> {
  @override
  final int typeId = 2;

  @override
  WooProductAttributes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WooProductAttributes(
      id: fields[0] as int?,
      name: fields[1] as String?,
      position: fields[2] as int?,
      visible: fields[3] as bool?,
      variation: fields[4] as bool?,
      options: (fields[6] as List?)?.cast<String>(),
    )..option = fields[5] as String?;
  }

  @override
  void write(BinaryWriter writer, WooProductAttributes obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.position)
      ..writeByte(3)
      ..write(obj.visible)
      ..writeByte(4)
      ..write(obj.variation)
      ..writeByte(5)
      ..write(obj.option)
      ..writeByte(6)
      ..write(obj.options);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductAttributesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
