// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'woo_product_categories.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WooProductCategoriesAdapter extends TypeAdapter<WooProductCategories> {
  @override
  final int typeId = 3;

  @override
  WooProductCategories read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WooProductCategories(
      id: fields[0] as int?,
      name: fields[1] as String?,
      slug: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WooProductCategories obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.slug);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductCategoriesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
