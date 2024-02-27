// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'woo_product_dimensions.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WooProductDimensionsAdapter extends TypeAdapter<WooProductDimensions> {
  @override
  final int typeId = 4;

  @override
  WooProductDimensions read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WooProductDimensions(
      length: fields[0] as String?,
      width: fields[1] as String?,
      height: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WooProductDimensions obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.length)
      ..writeByte(1)
      ..write(obj.width)
      ..writeByte(2)
      ..write(obj.height);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductDimensionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
