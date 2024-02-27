import 'package:flutter_kundol/api/api_provider.dart';
// import 'package:flutter_kundol/api/responses/cart_response.dart';
import 'package:flutter_kundol/api/responses/delete_cart_response.dart';
import 'package:flutter_kundol/api/responses/quantity_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_coupon.dart';
import 'package:flutter_kundol/api/wooResponses/woo_product_response.dart';
import 'package:flutter_kundol/models/add_to_cart/add_to_cart.dart';
// import 'package:flutter_kundol/models/coupon_response.dart';

abstract class CartRepo {
  Future<QuantityResponse> checkQuantity(
      int productId, String productType, int combinationId);
  Future<WooProductsResponse> getCart(List<int?> productIds);
  Future<DeleteCartResponse> deleteCartItem(int productId, int combinationId);
  Future<AddToCartResponse> addToCart(
      int productId, int qty, int combinationId);
  Future<List<WooCoupon>> applyCoupon(String coupon);
}

class RealCartRepo implements CartRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<QuantityResponse> checkQuantity(
      int productId, String productType, int combinationId) {
    _apiProvider = ApiProvider();
    return _apiProvider.getQuantity(productId, productType, combinationId);
  }

  @override
  Future<WooProductsResponse> getCart(List<int?> productIds) {
    _apiProvider = ApiProvider();
    return _apiProvider.getWooGroupedProducts(productIds);
  }

  @override
  Future<DeleteCartResponse> deleteCartItem(int productId, int combinationId) {
    _apiProvider = ApiProvider();
    return _apiProvider.deleteCartItem(productId, combinationId);
  }

  @override
  Future<AddToCartResponse> addToCart(
      int productId, int qty, int combinationId) {
    return _apiProvider.addToCart(productId, qty, combinationId);
  }

  @override
  Future<List<WooCoupon>> applyCoupon(String coupon) {
    return _apiProvider.getWooCoupon(coupon);
  }
}

class FakeCartRepo implements CartRepo {
  @override
  Future<QuantityResponse> checkQuantity(
      int productId, String productType, int combinationId) {
    throw UnimplementedError();
  }

  @override
  Future<WooProductsResponse> getCart(List<int?> productIds) {
    throw UnimplementedError();
  }

  @override
  Future<DeleteCartResponse> deleteCartItem(int productId, int combinationId) {
    throw UnimplementedError();
  }

  @override
  Future<AddToCartResponse> addToCart(
      int productId, int qty, int combinationId) {
    throw UnimplementedError();
  }

  @override
  Future<List<WooCoupon>> applyCoupon(String coupon) {
    throw UnimplementedError();
  }
}
