// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'woo_product_images.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WooProductImagesAdapter extends TypeAdapter<WooProductImages> {
  @override
  final int typeId = 5;

  @override
  WooProductImages read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WooProductImages(
      id: fields[0] as int?,
      dateCreated: fields[1] as String?,
      dateCreatedGmt: fields[2] as String?,
      dateModified: fields[3] as String?,
      dateModifiedGmt: fields[4] as String?,
      src: fields[5] as String?,
      name: fields[6] as String?,
      alt: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WooProductImages obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.dateCreated)
      ..writeByte(2)
      ..write(obj.dateCreatedGmt)
      ..writeByte(3)
      ..write(obj.dateModified)
      ..writeByte(4)
      ..write(obj.dateModifiedGmt)
      ..writeByte(5)
      ..write(obj.src)
      ..writeByte(6)
      ..write(obj.name)
      ..writeByte(7)
      ..write(obj.alt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductImagesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
