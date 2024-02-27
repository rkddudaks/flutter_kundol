import 'package:flutter_kundol/local_storage/base_local_storage.dart';
import 'package:hive/hive.dart';
// import 'package:flutter_kundol/models/products/product.dart';

import '../api/wooResponses/woo_product/woo_product.dart';

class LocalStorageRepository extends BaseLocalStorageRepository {
  String boxName = 'wishlist_products';
  @override
  Future<Box> openBox() async {
    Box box = await Hive.openBox<WooProduct>(boxName);
    return box;
  }

  @override
  List<WooProduct> getWishlist(Box box) {
    return box.values.toList() as List<WooProduct>;
  }

  @override
  Future<void> addProductToWishList(Box box, WooProduct product) async {
    await box.put(product.id, product);
  }

  @override
  Future<void> removeProductFromWishlist(Box box, WooProduct product) async {
    await box.delete(product.id);
  }

  @override
  Future<void> clearWishlist(Box box) async {
    await box.clear();
  }
}
