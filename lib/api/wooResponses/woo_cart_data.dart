
import 'package:flutter_kundol/api/wooResponses/woo_product/woo_product.dart';
import 'package:flutter_kundol/api/wooResponses/woo_product/woo_product_attributes.dart';
import 'package:flutter_kundol/api/wooResponses/woo_variations/woo_variations_response.dart';
import 'package:hive/hive.dart';
part 'woo_cart_data.g.dart';

@HiveType(typeId: 0)
class WooCartData {
  @HiveField(0)
  int? customerId;
  @HiveField(1)
  String? productType;
  @HiveField(2)
  String? link;
  @HiveField(3)
  int? quantity;
  @HiveField(4)
  WooProduct? productData;
  @HiveField(5)
  WooVariationsResponse? selectedVariation;
  @HiveField(6)
  String? variationSelectionText;
  @HiveField(7)
  List<WooProductAttributes>? productAttributes;
  @HiveField(8)
  bool? isProductValidForCoupon;

  WooCartData({
      this.customerId,
      this.productType,
      this.link,
      this.quantity,
      this.productData,
      this.selectedVariation,
      this.variationSelectionText,
      this.productAttributes,
      this.isProductValidForCoupon});
}