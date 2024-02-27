import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/wooResponses/woo_cart_data.dart';
import 'package:flutter_kundol/api/wooResponses/woo_coupon.dart';
// import 'package:flutter_kundol/api/wooResponses/woo_product/woo_product.dart';
// import 'package:flutter_kundol/api/wooResponses/woo_product_response.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
// import 'package:flutter_kundol/models/cart_data.dart';
// import 'package:flutter_kundol/models/coupon_data.dart';
// import 'package:flutter_kundol/models/coupon_response.dart';
import 'package:flutter_kundol/repos/cart_repo.dart';
import 'package:hive/hive.dart';

part 'cart_state.dart';

part 'cart_event.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepo cartRepo;

  CartBloc(this.cartRepo) : super(CartInitial());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is GetCart) {
      try {
        if (event.productIds.isNotEmpty) {
          final cartResponse = await cartRepo.getCart(event.productIds);
          if (cartResponse.status == AppConstants.STATUS_SUCCESS &&
              cartResponse.data != null) {
            var box = await Hive.openBox<WooCartData>(AppConstants.TBL_CART);
            for (int i = 0; i < box.values.toList().length; i++) {
              cartResponse.data!.forEach((element) {
                if (box.values.toList()[i].productData!.id == element.id) {
                  WooCartData temp = box.values.toList()[i];
                  temp.productData = element;
                  box.putAt(i, temp);
                }
              });
            }
            yield CartLoaded(box.values.toList());
          } else
            yield CartError(cartResponse.error);
        }
      } on Error {
        yield CartError("Some error occurred. Is the device online?");
      }
    } else if (event is DeleteCartItem) {
      try {
        var box = await Hive.openBox<WooCartData>(AppConstants.TBL_CART);
        for (int i = 0; i < box.values.toList().length; i++) {
          WooCartData data = box.values.toList()[i];
          if (data.productData!.id == event.productId) {
            if (data.selectedVariation != null) {
              if (data.selectedVariation!.id == event.combinationId) {
                box.deleteAt(i);
              }
            } else {
              box.deleteAt(i);
            }
          }
        }
        AppData.cartItems = box.values.toList();
        yield CartDeleted(box.values.toList());
      } on Error {
        yield CartError("Some error occurred. Is the device online?");
      }
    } else if (event is ApplyCoupon) {
      try {
        final applyCouponResponse = await cartRepo.applyCoupon(event.coupon);
        if (applyCouponResponse.isNotEmpty) {
          var box = await Hive.openBox<WooCartData>(AppConstants.TBL_CART);
          yield CouponApplied(applyCouponResponse, box.values.toList());
        } else
          yield CartCouponError("Not Found");
      } on Error {
        yield CartCouponError("Some error occurred. Is the device online?");
      }
    }
  }
}
