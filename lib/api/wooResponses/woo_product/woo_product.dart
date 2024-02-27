import 'package:flutter_kundol/api/wooResponses/woo_product/woo_product_attributes.dart';
import 'package:flutter_kundol/api/wooResponses/woo_product/woo_product_categories.dart';
import 'package:flutter_kundol/api/wooResponses/woo_product/woo_product_dimensions.dart';
import 'package:flutter_kundol/api/wooResponses/woo_product/woo_product_images.dart';
import 'package:flutter_kundol/api/wooResponses/woo_product/woo_product_store.dart';
import 'package:hive/hive.dart';
part 'woo_product.g.dart';

@HiveType(typeId: 1)
class WooProduct {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? slug;
  @HiveField(3)
  String? permalink;
  @HiveField(4)
  String? dateCreated;
  @HiveField(5)
  String? dateCreatedGmt;
  @HiveField(6)
  String? dateModified;
  @HiveField(7)
  String? dateModifiedGmt;
  @HiveField(8)
  String? type;
  @HiveField(9)
  String? status;
  @HiveField(10)
  bool? featured;
  @HiveField(11)
  String? catalogVisibility;
  @HiveField(12)
  String? description;
  @HiveField(13)
  String? shortDescription;
  @HiveField(14)
  String? sku;
  @HiveField(15)
  String? price;
  @HiveField(16)
  String? regularPrice;
  @HiveField(17)
  String? salePrice;
  @HiveField(18)
  String? dateOnSaleFrom;
  @HiveField(19)
  String? dateOnSaleFromGmt;
  @HiveField(20)
  String? dateOnSaleTo;
  @HiveField(21)
  String? dateOnSaleToGmt;
  @HiveField(22)
  String? priceHtml;
  @HiveField(23)
  bool? onSale;
  @HiveField(24)
  bool? purchasable;
  @HiveField(25)
  int? totalSales;
  @HiveField(26)
  bool? virtual;
  @HiveField(27)
  bool? downloadable;
  @HiveField(28)
  int? downloadLimit;
  @HiveField(29)
  int? downloadExpiry;
  @HiveField(30)
  String? externalUrl;
  @HiveField(31)
  String? buttonText;
  @HiveField(32)
  String? taxStatus;
  @HiveField(33)
  String? taxClass;
  @HiveField(34)
  bool? manageStock;
  @HiveField(35)
  String? stockStatus;
  @HiveField(36)
  String? backorders;
  @HiveField(37)
  bool? backordersAllowed;
  @HiveField(38)
  bool? backordered;
  @HiveField(39)
  bool? soldIndividually;
  @HiveField(40)
  String? weight;
  @HiveField(41)
  WooProductDimensions? dimensions;
  @HiveField(42)
  bool? shippingRequired;
  @HiveField(43)
  bool? shippingTaxable;
  @HiveField(44)
  String? shippingClass;
  @HiveField(45)
  int? shippingClassId;
  @HiveField(46)
  bool? reviewsAllowed;
  @HiveField(47)
  String? averageRating;
  @HiveField(48)
  int? ratingCount;
  @HiveField(49)
  List<int>? relatedIds;
  @HiveField(50)
  int? parentId;
  @HiveField(51)
  String? purchaseNote;
  @HiveField(52)
  List<WooProductCategories>? categories;
  @HiveField(53)
  List<WooProductImages>? images;
  @HiveField(54)
  List<WooProductAttributes>? attributes;
  @HiveField(55)
  List<int>? variations;
  @HiveField(56)
  List<int>? groupedProducts;
  @HiveField(57)
  int? menuOrder;
  @HiveField(58)
  WooProductStore? store;

  WooProduct(
      {this.id,
      this.name,
      this.slug,
      this.permalink,
      this.dateCreated,
      this.dateCreatedGmt,
      this.dateModified,
      this.dateModifiedGmt,
      this.type,
      this.status,
      this.featured,
      this.catalogVisibility,
      this.description,
      this.shortDescription,
      this.sku,
      this.price,
      this.regularPrice,
      this.salePrice,
      this.dateOnSaleFrom,
      this.dateOnSaleFromGmt,
      this.dateOnSaleTo,
      this.dateOnSaleToGmt,
      this.priceHtml,
      this.onSale,
      this.purchasable,
      this.totalSales,
      this.virtual,
      this.downloadable,
      this.downloadLimit,
      this.downloadExpiry,
      this.externalUrl,
      this.buttonText,
      this.taxStatus,
      this.taxClass,
      this.manageStock,
      this.stockStatus,
      this.backorders,
      this.backordersAllowed,
      this.backordered,
      this.soldIndividually,
      this.weight,
      this.dimensions,
      this.shippingRequired,
      this.shippingTaxable,
      this.shippingClass,
      this.shippingClassId,
      this.reviewsAllowed,
      this.averageRating,
      this.ratingCount,
      this.relatedIds,
      this.parentId,
      this.purchaseNote,
      this.categories,
      this.images,
      this.attributes,
      this.variations,
      this.groupedProducts,
      this.menuOrder,
      this.store});

  WooProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    permalink = json['permalink'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    type = json['type'];
    status = json['status'];
    featured = json['featured'];
    catalogVisibility = json['catalog_visibility'];
    description = json['description'];
    shortDescription = json['short_description'];
    sku = json['sku'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    dateOnSaleFrom = json['date_on_sale_from'];
    dateOnSaleFromGmt = json['date_on_sale_from_gmt'];
    dateOnSaleTo = json['date_on_sale_to'];
    dateOnSaleToGmt = json['date_on_sale_to_gmt'];
    priceHtml = json['price_html'];
    onSale = json['on_sale'];
    purchasable = json['purchasable'];
    totalSales = json['total_sales'];
    virtual = json['virtual'];
    downloadable = json['downloadable'];
    downloadLimit = json['download_limit'];
    downloadExpiry = json['download_expiry'];
    externalUrl = json['external_url'];
    buttonText = json['button_text'];
    taxStatus = json['tax_status'];
    taxClass = json['tax_class'];
    manageStock = json['manage_stock'];
    stockStatus = json['stock_status'];
    backorders = json['backorders'];
    backordersAllowed = json['backorders_allowed'];
    backordered = json['backordered'];
    soldIndividually = json['sold_individually'];
    weight = json['weight'];
    dimensions = json['dimensions'] != null
        ? new WooProductDimensions.fromJson(json['dimensions'])
        : null;
    shippingRequired = json['shipping_required'];
    shippingTaxable = json['shipping_taxable'];
    shippingClass = json['shipping_class'];
    shippingClassId = json['shipping_class_id'];
    reviewsAllowed = json['reviews_allowed'];
    averageRating = json['average_rating'];
    ratingCount = json['rating_count'];
    relatedIds = json['related_ids'].cast<int>();
    parentId = json['parent_id'];
    purchaseNote = json['purchase_note'];
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories!.add(new WooProductCategories.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images!.add(new WooProductImages.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = [];
      json['attributes'].forEach((v) {
        attributes!.add(new WooProductAttributes.fromJson(v));
      });
    }
    variations = json['variations'].cast<int>();
    groupedProducts = json['grouped_products'].cast<int>();
    menuOrder = json['menu_order'];
    store = json['store'] != null
        ? new WooProductStore.fromJson(json['store'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['permalink'] = this.permalink;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['type'] = this.type;
    data['status'] = this.status;
    data['featured'] = this.featured;
    data['catalog_visibility'] = this.catalogVisibility;
    data['description'] = this.description;
    data['short_description'] = this.shortDescription;
    data['sku'] = this.sku;
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['date_on_sale_from'] = this.dateOnSaleFrom;
    data['date_on_sale_from_gmt'] = this.dateOnSaleFromGmt;
    data['date_on_sale_to'] = this.dateOnSaleTo;
    data['date_on_sale_to_gmt'] = this.dateOnSaleToGmt;
    data['price_html'] = this.priceHtml;
    data['on_sale'] = this.onSale;
    data['purchasable'] = this.purchasable;
    data['total_sales'] = this.totalSales;
    data['virtual'] = this.virtual;
    data['downloadable'] = this.downloadable;
    data['download_limit'] = this.downloadLimit;
    data['download_expiry'] = this.downloadExpiry;
    data['external_url'] = this.externalUrl;
    data['button_text'] = this.buttonText;
    data['tax_status'] = this.taxStatus;
    data['tax_class'] = this.taxClass;
    data['manage_stock'] = this.manageStock;
    data['stock_status'] = this.stockStatus;
    data['backorders'] = this.backorders;
    data['backorders_allowed'] = this.backordersAllowed;
    data['backordered'] = this.backordered;
    data['sold_individually'] = this.soldIndividually;
    data['weight'] = this.weight;
    if (this.dimensions != null) {
      data['dimensions'] = this.dimensions!.toJson();
    }
    data['shipping_required'] = this.shippingRequired;
    data['shipping_taxable'] = this.shippingTaxable;
    data['shipping_class'] = this.shippingClass;
    data['shipping_class_id'] = this.shippingClassId;
    data['reviews_allowed'] = this.reviewsAllowed;
    data['average_rating'] = this.averageRating;
    data['rating_count'] = this.ratingCount;
    data['related_ids'] = this.relatedIds;
    data['parent_id'] = this.parentId;
    data['purchase_note'] = this.purchaseNote;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    }
    data['variations'] = this.variations;
    data['grouped_products'] = this.groupedProducts;
    data['menu_order'] = this.menuOrder;
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    return data;
  }
}
