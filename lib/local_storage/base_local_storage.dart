// import 'package:flutter_kundol/models/products/product.dart';
import 'package:hive/hive.dart';

import '../api/wooResponses/woo_product/woo_product.dart';

abstract class BaseLocalStorageRepository {
  Future<Box> openBox();
  List<WooProduct> getWishlist(Box box);
  Future<void> addProductToWishList(Box box, WooProduct product);
  Future<void> removeProductFromWishlist(Box box, WooProduct product);
  Future<void> clearWishlist(Box box);
}
