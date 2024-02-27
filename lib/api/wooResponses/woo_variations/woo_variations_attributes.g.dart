// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'woo_variations_attributes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WooVariationsAttributesAdapter
    extends TypeAdapter<WooVariationsAttributes> {
  @override
  final int typeId = 8;

  @override
  WooVariationsAttributes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WooVariationsAttributes()
      .._id = fields[0] as int?
      .._name = fields[1] as String?
      .._option = fields[2] as String?;
  }

  @override
  void write(BinaryWriter writer, WooVariationsAttributes obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj._id)
      ..writeByte(1)
      ..write(obj._name)
      ..writeByte(2)
      ..write(obj._option);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooVariationsAttributesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
