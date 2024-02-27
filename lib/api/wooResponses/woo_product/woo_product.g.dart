// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'woo_product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WooProductAdapter extends TypeAdapter<WooProduct> {
  @override
  final int typeId = 1;

  @override
  WooProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WooProduct(
      id: fields[0] as int?,
      name: fields[1] as String?,
      slug: fields[2] as String?,
      permalink: fields[3] as String?,
      dateCreated: fields[4] as String?,
      dateCreatedGmt: fields[5] as String?,
      dateModified: fields[6] as String?,
      dateModifiedGmt: fields[7] as String?,
      type: fields[8] as String?,
      status: fields[9] as String?,
      featured: fields[10] as bool?,
      catalogVisibility: fields[11] as String?,
      description: fields[12] as String?,
      shortDescription: fields[13] as String?,
      sku: fields[14] as String?,
      price: fields[15] as String?,
      regularPrice: fields[16] as String?,
      salePrice: fields[17] as String?,
      dateOnSaleFrom: fields[18] as String?,
      dateOnSaleFromGmt: fields[19] as String?,
      dateOnSaleTo: fields[20] as String?,
      dateOnSaleToGmt: fields[21] as String?,
      priceHtml: fields[22] as String?,
      onSale: fields[23] as bool?,
      purchasable: fields[24] as bool?,
      totalSales: fields[25] as int?,
      virtual: fields[26] as bool?,
      downloadable: fields[27] as bool?,
      downloadLimit: fields[28] as int?,
      downloadExpiry: fields[29] as int?,
      externalUrl: fields[30] as String?,
      buttonText: fields[31] as String?,
      taxStatus: fields[32] as String?,
      taxClass: fields[33] as String?,
      manageStock: fields[34] as bool?,
      stockStatus: fields[35] as String?,
      backorders: fields[36] as String?,
      backordersAllowed: fields[37] as bool?,
      backordered: fields[38] as bool?,
      soldIndividually: fields[39] as bool?,
      weight: fields[40] as String?,
      dimensions: fields[41] as WooProductDimensions?,
      shippingRequired: fields[42] as bool?,
      shippingTaxable: fields[43] as bool?,
      shippingClass: fields[44] as String?,
      shippingClassId: fields[45] as int?,
      reviewsAllowed: fields[46] as bool?,
      averageRating: fields[47] as String?,
      ratingCount: fields[48] as int?,
      relatedIds: (fields[49] as List?)?.cast<int>(),
      parentId: fields[50] as int?,
      purchaseNote: fields[51] as String?,
      categories: (fields[52] as List?)?.cast<WooProductCategories>(),
      images: (fields[53] as List?)?.cast<WooProductImages>(),
      attributes: (fields[54] as List?)?.cast<WooProductAttributes>(),
      variations: (fields[55] as List?)?.cast<int>(),
      groupedProducts: (fields[56] as List?)?.cast<int>(),
      menuOrder: fields[57] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, WooProduct obj) {
    writer
      ..writeByte(58)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.slug)
      ..writeByte(3)
      ..write(obj.permalink)
      ..writeByte(4)
      ..write(obj.dateCreated)
      ..writeByte(5)
      ..write(obj.dateCreatedGmt)
      ..writeByte(6)
      ..write(obj.dateModified)
      ..writeByte(7)
      ..write(obj.dateModifiedGmt)
      ..writeByte(8)
      ..write(obj.type)
      ..writeByte(9)
      ..write(obj.status)
      ..writeByte(10)
      ..write(obj.featured)
      ..writeByte(11)
      ..write(obj.catalogVisibility)
      ..writeByte(12)
      ..write(obj.description)
      ..writeByte(13)
      ..write(obj.shortDescription)
      ..writeByte(14)
      ..write(obj.sku)
      ..writeByte(15)
      ..write(obj.price)
      ..writeByte(16)
      ..write(obj.regularPrice)
      ..writeByte(17)
      ..write(obj.salePrice)
      ..writeByte(18)
      ..write(obj.dateOnSaleFrom)
      ..writeByte(19)
      ..write(obj.dateOnSaleFromGmt)
      ..writeByte(20)
      ..write(obj.dateOnSaleTo)
      ..writeByte(21)
      ..write(obj.dateOnSaleToGmt)
      ..writeByte(22)
      ..write(obj.priceHtml)
      ..writeByte(23)
      ..write(obj.onSale)
      ..writeByte(24)
      ..write(obj.purchasable)
      ..writeByte(25)
      ..write(obj.totalSales)
      ..writeByte(26)
      ..write(obj.virtual)
      ..writeByte(27)
      ..write(obj.downloadable)
      ..writeByte(28)
      ..write(obj.downloadLimit)
      ..writeByte(29)
      ..write(obj.downloadExpiry)
      ..writeByte(30)
      ..write(obj.externalUrl)
      ..writeByte(31)
      ..write(obj.buttonText)
      ..writeByte(32)
      ..write(obj.taxStatus)
      ..writeByte(33)
      ..write(obj.taxClass)
      ..writeByte(34)
      ..write(obj.manageStock)
      ..writeByte(35)
      ..write(obj.stockStatus)
      ..writeByte(36)
      ..write(obj.backorders)
      ..writeByte(37)
      ..write(obj.backordersAllowed)
      ..writeByte(38)
      ..write(obj.backordered)
      ..writeByte(39)
      ..write(obj.soldIndividually)
      ..writeByte(40)
      ..write(obj.weight)
      ..writeByte(41)
      ..write(obj.dimensions)
      ..writeByte(42)
      ..write(obj.shippingRequired)
      ..writeByte(43)
      ..write(obj.shippingTaxable)
      ..writeByte(44)
      ..write(obj.shippingClass)
      ..writeByte(45)
      ..write(obj.shippingClassId)
      ..writeByte(46)
      ..write(obj.reviewsAllowed)
      ..writeByte(47)
      ..write(obj.averageRating)
      ..writeByte(48)
      ..write(obj.ratingCount)
      ..writeByte(49)
      ..write(obj.relatedIds)
      ..writeByte(50)
      ..write(obj.parentId)
      ..writeByte(51)
      ..write(obj.purchaseNote)
      ..writeByte(52)
      ..write(obj.categories)
      ..writeByte(53)
      ..write(obj.images)
      ..writeByte(54)
      ..write(obj.attributes)
      ..writeByte(55)
      ..write(obj.variations)
      ..writeByte(56)
      ..write(obj.groupedProducts)
      ..writeByte(57)
      ..write(obj.menuOrder);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
