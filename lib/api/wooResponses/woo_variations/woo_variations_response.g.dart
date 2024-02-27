// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'woo_variations_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WooVariationsResponseAdapter extends TypeAdapter<WooVariationsResponse> {
  @override
  final int typeId = 6;

  @override
  WooVariationsResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WooVariationsResponse()
      .._id = fields[0] as int?
      .._dateCreated = fields[1] as String?
      .._dateCreatedGmt = fields[2] as String?
      .._dateModified = fields[3] as String?
      .._dateModifiedGmt = fields[4] as String?
      .._description = fields[5] as String?
      .._permalink = fields[6] as String?
      .._sku = fields[7] as String?
      .._price = fields[8] as String?
      .._regularPrice = fields[9] as String?
      .._salePrice = fields[10] as String?
      .._dateOnSaleFrom = fields[11] as dynamic
      .._dateOnSaleFromGmt = fields[12] as dynamic
      .._dateOnSaleTo = fields[13] as dynamic
      .._dateOnSaleToGmt = fields[14] as dynamic
      .._onSale = fields[15] as bool?
      .._status = fields[16] as String?
      .._purchasable = fields[17] as bool?
      .._virtual = fields[18] as bool?
      .._downloadable = fields[19] as bool?
      .._downloadLimit = fields[20] as int?
      .._downloadExpiry = fields[21] as int?
      .._taxStatus = fields[22] as String?
      .._taxClass = fields[23] as String?
      .._manageStock = fields[24] as bool?
      .._stockQuantity = fields[25] as dynamic
      .._stockStatus = fields[26] as String?
      .._backorders = fields[27] as String?
      .._backordersAllowed = fields[28] as bool?
      .._backordered = fields[29] as bool?
      .._weight = fields[30] as String?
      .._shippingClass = fields[31] as String?
      .._shippingClassId = fields[32] as int?
      .._image = fields[33] as WooVariationImage?
      .._attributes = (fields[34] as List?)?.cast<WooVariationsAttributes>()
      .._menuOrder = fields[35] as int?;
  }

  @override
  void write(BinaryWriter writer, WooVariationsResponse obj) {
    writer
      ..writeByte(36)
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
      ..write(obj._description)
      ..writeByte(6)
      ..write(obj._permalink)
      ..writeByte(7)
      ..write(obj._sku)
      ..writeByte(8)
      ..write(obj._price)
      ..writeByte(9)
      ..write(obj._regularPrice)
      ..writeByte(10)
      ..write(obj._salePrice)
      ..writeByte(11)
      ..write(obj._dateOnSaleFrom)
      ..writeByte(12)
      ..write(obj._dateOnSaleFromGmt)
      ..writeByte(13)
      ..write(obj._dateOnSaleTo)
      ..writeByte(14)
      ..write(obj._dateOnSaleToGmt)
      ..writeByte(15)
      ..write(obj._onSale)
      ..writeByte(16)
      ..write(obj._status)
      ..writeByte(17)
      ..write(obj._purchasable)
      ..writeByte(18)
      ..write(obj._virtual)
      ..writeByte(19)
      ..write(obj._downloadable)
      ..writeByte(20)
      ..write(obj._downloadLimit)
      ..writeByte(21)
      ..write(obj._downloadExpiry)
      ..writeByte(22)
      ..write(obj._taxStatus)
      ..writeByte(23)
      ..write(obj._taxClass)
      ..writeByte(24)
      ..write(obj._manageStock)
      ..writeByte(25)
      ..write(obj._stockQuantity)
      ..writeByte(26)
      ..write(obj._stockStatus)
      ..writeByte(27)
      ..write(obj._backorders)
      ..writeByte(28)
      ..write(obj._backordersAllowed)
      ..writeByte(29)
      ..write(obj._backordered)
      ..writeByte(30)
      ..write(obj._weight)
      ..writeByte(31)
      ..write(obj._shippingClass)
      ..writeByte(32)
      ..write(obj._shippingClassId)
      ..writeByte(33)
      ..write(obj._image)
      ..writeByte(34)
      ..write(obj._attributes)
      ..writeByte(35)
      ..write(obj._menuOrder);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooVariationsResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
