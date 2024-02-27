// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'woo_cart_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WooCartDataAdapter extends TypeAdapter<WooCartData> {
  @override
  final int typeId = 0;

  @override
  WooCartData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WooCartData(
      customerId: fields[0] as int?,
      productType: fields[1] as String?,
      link: fields[2] as String?,
      quantity: fields[3] as int?,
      productData: fields[4] as WooProduct?,
      selectedVariation: fields[5] as WooVariationsResponse?,
      variationSelectionText: fields[6] as String?,
      productAttributes: (fields[7] as List?)?.cast<WooProductAttributes>(),
      isProductValidForCoupon: fields[8] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, WooCartData obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.customerId)
      ..writeByte(1)
      ..write(obj.productType)
      ..writeByte(2)
      ..write(obj.link)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.productData)
      ..writeByte(5)
      ..write(obj.selectedVariation)
      ..writeByte(6)
      ..write(obj.variationSelectionText)
      ..writeByte(7)
      ..write(obj.productAttributes)
      ..writeByte(8)
      ..write(obj.isProductValidForCoupon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooCartDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
