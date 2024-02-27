// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'woo_variation_image.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WooVariationImageAdapter extends TypeAdapter<WooVariationImage> {
  @override
  final int typeId = 7;

  @override
  WooVariationImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WooVariationImage()
      .._id = fields[0] as int?
      .._dateCreated = fields[1] as String?
      .._dateCreatedGmt = fields[2] as String?
      .._dateModified = fields[3] as String?
      .._dateModifiedGmt = fields[4] as String?
      .._src = fields[5] as String?
      .._name = fields[6] as String?
      .._alt = fields[7] as String?;
  }

  @override
  void write(BinaryWriter writer, WooVariationImage obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj._id)
      ..writeByte(1)
      ..write(obj._dateCreated)
      ..writeByte(2)
      ..write(obj._dateCreatedGmt)
      ..writeByte(3)
      ..write(obj._dateModified)
      ..writeByte(4)
      ..write(obj._dateModifiedGmt)
      ..writeByte(5)
      ..write(obj._src)
      ..writeByte(6)
      ..write(obj._name)
      ..writeByte(7)
      ..write(obj._alt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooVariationImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
