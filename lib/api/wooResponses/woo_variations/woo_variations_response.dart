import 'package:flutter_kundol/api/wooResponses/woo_variations/woo_variation_image.dart';
import 'package:flutter_kundol/api/wooResponses/woo_variations/woo_variations_attributes.dart';
import 'package:hive/hive.dart';

part 'woo_variations_response.g.dart';

@HiveType(typeId: 6)
class WooVariationsResponse {
  WooVariationsResponse(
      {int? id,
      String? dateCreated,
      String? dateCreatedGmt,
      String? dateModified,
      String? dateModifiedGmt,
      String? description,
      String? permalink,
      String? sku,
      String? price,
      String? regularPrice,
      String? salePrice,
      dynamic dateOnSaleFrom,
      dynamic dateOnSaleFromGmt,
      dynamic dateOnSaleTo,
      dynamic dateOnSaleToGmt,
      bool? onSale,
      String? status,
      bool? purchasable,
      bool? virtual,
      bool? downloadable,
      List<dynamic>? downloads,
      int? downloadLimit,
      int? downloadExpiry,
      String? taxStatus,
      String? taxClass,
      bool? manageStock,
      dynamic stockQuantity,
      String? stockStatus,
      String? backorders,
      bool? backordersAllowed,
      bool? backordered,
      String? weight,
      String? shippingClass,
      int? shippingClassId,
      WooVariationImage? image,
      List<WooVariationsAttributes>? attributes,
      int? menuOrder}) {
    _id = id;
    _dateCreated = dateCreated;
    _dateCreatedGmt = dateCreatedGmt;
    _dateModified = dateModified;
    _dateModifiedGmt = dateModifiedGmt;
    _description = description;
    _permalink = permalink;
    _sku = sku;
    _price = price;
    _regularPrice = regularPrice;
    _salePrice = salePrice;
    _dateOnSaleFrom = dateOnSaleFrom;
    _dateOnSaleFromGmt = dateOnSaleFromGmt;
    _dateOnSaleTo = dateOnSaleTo;
    _dateOnSaleToGmt = dateOnSaleToGmt;
    _onSale = onSale;
    _status = status;
    _purchasable = purchasable;
    _virtual = virtual;
    _downloadable = downloadable;
    _downloadLimit = downloadLimit;
    _downloadExpiry = downloadExpiry;
    _taxStatus = taxStatus;
    _taxClass = taxClass;
    _manageStock = manageStock;
    _stockQuantity = stockQuantity;
    _stockStatus = stockStatus;
    _backorders = backorders;
    _backordersAllowed = backordersAllowed;
    _backordered = backordered;
    _weight = weight;
    _shippingClass = shippingClass;
    _shippingClassId = shippingClassId;
    _image = image;
    _attributes = attributes;
    _menuOrder = menuOrder;
  }

  WooVariationsResponse.fromJson(dynamic json) {
    _id = json['id'];
    _dateCreated = json['date_created'];
    _dateCreatedGmt = json['date_created_gmt'];
    _dateModified = json['date_modified'];
    _dateModifiedGmt = json['date_modified_gmt'];
    _description = json['description'];
    _permalink = json['permalink'];
    _sku = json['sku'];
    _price = json['price'];
    _regularPrice = json['regular_price'];
    _salePrice = json['sale_price'];
    _dateOnSaleFrom = json['date_on_sale_from'];
    _dateOnSaleFromGmt = json['date_on_sale_from_gmt'];
    _dateOnSaleTo = json['date_on_sale_to'];
    _dateOnSaleToGmt = json['date_on_sale_to_gmt'];
    _onSale = json['on_sale'];
    _status = json['status'];
    _purchasable = json['purchasable'];
    _virtual = json['virtual'];
    _downloadable = json['downloadable'];
    _downloadLimit = json['download_limit'];
    _downloadExpiry = json['download_expiry'];
    _taxStatus = json['tax_status'];
    _taxClass = json['tax_class'];
    _manageStock = json['manage_stock'];
    _stockQuantity = json['stock_quantity'];
    _stockStatus = json['stock_status'];
    _backorders = json['backorders'];
    _backordersAllowed = json['backorders_allowed'];
    _backordered = json['backordered'];
    _weight = json['weight'];
    _shippingClass = json['shipping_class'];
    _shippingClassId = json['shipping_class_id'];
    _image = json['image'] != null
        ? WooVariationImage.fromJson(json['image'])
        : null;
    if (json['attributes'] != null) {
      _attributes = [];
      json['attributes'].forEach((v) {
        _attributes!.add(WooVariationsAttributes.fromJson(v));
      });
    }
    _menuOrder = json['menu_order'];
  }

  WooVariationsResponse.withError(String error);

  @HiveField(0)
  int? _id;
  @HiveField(1)
  String? _dateCreated;
  @HiveField(2)
  String? _dateCreatedGmt;
  @HiveField(3)
  String? _dateModified;
  @HiveField(4)
  String? _dateModifiedGmt;
  @HiveField(5)
  String? _description;
  @HiveField(6)
  String? _permalink;
  @HiveField(7)
  String? _sku;
  @HiveField(8)
  String? _price;
  @HiveField(9)
  String? _regularPrice;
  @HiveField(10)
  String? _salePrice;
  @HiveField(11)
  dynamic _dateOnSaleFrom;
  @HiveField(12)
  dynamic _dateOnSaleFromGmt;
  @HiveField(13)
  dynamic _dateOnSaleTo;
  @HiveField(14)
  dynamic _dateOnSaleToGmt;
  @HiveField(15)
  bool? _onSale;
  @HiveField(16)
  String? _status;
  @HiveField(17)
  bool? _purchasable;
  @HiveField(18)
  bool? _virtual;
  @HiveField(19)
  bool? _downloadable;
  @HiveField(20)
  int? _downloadLimit;
  @HiveField(21)
  int? _downloadExpiry;
  @HiveField(22)
  String? _taxStatus;
  @HiveField(23)
  String? _taxClass;
  @HiveField(24)
  bool? _manageStock;
  @HiveField(25)
  dynamic _stockQuantity;
  @HiveField(26)
  String? _stockStatus;
  @HiveField(27)
  String? _backorders;
  @HiveField(28)
  bool? _backordersAllowed;
  @HiveField(29)
  bool? _backordered;
  @HiveField(30)
  String? _weight;
  @HiveField(31)
  String? _shippingClass;
  @HiveField(32)
  int? _shippingClassId;
  @HiveField(33)
  WooVariationImage? _image;
  @HiveField(34)
  List<WooVariationsAttributes>? _attributes;
  @HiveField(35)
  int? _menuOrder;

  int? get id => _id;

  String? get dateCreated => _dateCreated;

  String? get dateCreatedGmt => _dateCreatedGmt;

  String? get dateModified => _dateModified;

  String? get dateModifiedGmt => _dateModifiedGmt;

  String? get description => _description;

  String? get permalink => _permalink;

  String? get sku => _sku;

  String? get price => _price;

  String? get regularPrice => _regularPrice;

  String? get salePrice => _salePrice;

  dynamic get dateOnSaleFrom => _dateOnSaleFrom;

  dynamic get dateOnSaleFromGmt => _dateOnSaleFromGmt;

  dynamic get dateOnSaleTo => _dateOnSaleTo;

  dynamic get dateOnSaleToGmt => _dateOnSaleToGmt;

  bool? get onSale => _onSale;

  String? get status => _status;

  bool? get purchasable => _purchasable;

  bool? get virtual => _virtual;

  bool? get downloadable => _downloadable;

  int? get downloadLimit => _downloadLimit;

  int? get downloadExpiry => _downloadExpiry;

  String? get taxStatus => _taxStatus;

  String? get taxClass => _taxClass;

  bool? get manageStock => _manageStock;

  dynamic get stockQuantity => _stockQuantity;

  String? get stockStatus => _stockStatus;

  String? get backorders => _backorders;

  bool? get backordersAllowed => _backordersAllowed;

  bool? get backordered => _backordered;

  String? get weight => _weight;

  String? get shippingClass => _shippingClass;

  int? get shippingClassId => _shippingClassId;

  WooVariationImage? get image => _image;

  List<WooVariationsAttributes>? get attributes => _attributes;

  int? get menuOrder => _menuOrder;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date_created'] = _dateCreated;
    map['date_created_gmt'] = _dateCreatedGmt;
    map['date_modified'] = _dateModified;
    map['date_modified_gmt'] = _dateModifiedGmt;
    map['description'] = _description;
    map['permalink'] = _permalink;
    map['sku'] = _sku;
    map['price'] = _price;
    map['regular_price'] = _regularPrice;
    map['sale_price'] = _salePrice;
    map['date_on_sale_from'] = _dateOnSaleFrom;
    map['date_on_sale_from_gmt'] = _dateOnSaleFromGmt;
    map['date_on_sale_to'] = _dateOnSaleTo;
    map['date_on_sale_to_gmt'] = _dateOnSaleToGmt;
    map['on_sale'] = _onSale;
    map['status'] = _status;
    map['purchasable'] = _purchasable;
    map['virtual'] = _virtual;
    map['downloadable'] = _downloadable;
    map['download_limit'] = _downloadLimit;
    map['download_expiry'] = _downloadExpiry;
    map['tax_status'] = _taxStatus;
    map['tax_class'] = _taxClass;
    map['manage_stock'] = _manageStock;
    map['stock_quantity'] = _stockQuantity;
    map['stock_status'] = _stockStatus;
    map['backorders'] = _backorders;
    map['backorders_allowed'] = _backordersAllowed;
    map['backordered'] = _backordered;
    map['weight'] = _weight;
    map['shipping_class'] = _shippingClass;
    map['shipping_class_id'] = _shippingClassId;
    if (_image != null) {
      map['image'] = _image!.toJson();
    }
    if (_attributes != null) {
      map['attributes'] = _attributes!.map((v) => v.toJson()).toList();
    }
    map['menu_order'] = _menuOrder;
    return map;
  }
}
