import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/api/responses/product_detail_response.dart';
// import 'package:flutter_kundol/api/responses/quantity_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_cart_data.dart';
import 'package:flutter_kundol/api/wooResponses/woo_product/woo_product.dart';
// import 'package:flutter_kundol/api/wooResponses/woo_product_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_variations/woo_variations_response.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/models/products/product.dart';
import 'package:flutter_kundol/models/quantity_data.dart';
import 'package:flutter_kundol/repos/cart_repo.dart';
import 'package:flutter_kundol/repos/products_repo.dart';
import 'package:hive/hive.dart';

import '../../api/wooResponses/woo_reviews_response.dart';

part 'detail_screen_event.dart';

part 'detail_screen_state.dart';

class DetailScreenBloc extends Bloc<DetailPageEvent, DetailPageState> {
  final CartRepo cartRepo;
  final ProductsRepo productsRepo;

  DetailScreenBloc(this.cartRepo, this.productsRepo)
      : super(DetailPageInitial());

  @override
  Stream<DetailPageState> mapEventToState(DetailPageEvent event) async* {
    if (event is GetQuantity) {
      try {
        final response = await cartRepo.checkQuantity(
            event.productId, event.productType, event.combinationId);
        if (response.status == AppConstants.STATUS_SUCCESS &&
            response.data != null) {
          yield GetQuantityLoaded(response.data);
        } else {
          yield DetailPageError(response.message);
        }
      } on Error {
        yield DetailPageError("Some Error Occurred");
      }
    } else if (event is AddToCart) {
      try {
        var box = await Hive.openBox<WooCartData>(AppConstants.TBL_CART);
        WooCartData? item;
        late int position;
        box.values.toList().asMap().forEach((index, element) {
          if (element.productData!.id == event.cartItem.productData!.id) {
            item = element;
            position = index;
          }
        });
        if (item != null) {
          item!.quantity = item!.quantity! + 1;
          box.putAt(position, item!);
        } else {
          box.add(event.cartItem);
        }
        AppData.cartItems = box.values.toList();
        yield ItemCartAdded(box.values.toList());
      } on Error {
        yield DetailPageError("Some Error Occurred");
      }
    } else if (event is AddToCartGrouped) {
      try {
        var box = await Hive.openBox<WooCartData>(AppConstants.TBL_CART);
        event.cartItem.asMap().forEach((key, value) {
          WooCartData? item;
          late int position;
          box.values.toList().asMap().forEach((index, element) {
            if (element.productData!.id == value.productData!.id) {
              item = element;
              position = index;
            }
          });
          if (item != null) {
            item!.quantity = item!.quantity! + 1;
            box.putAt(position, item!);
          } else {
            box.add(value);
          }
        });
        yield ItemCartAdded(box.values.toList());
      } on Error {
        yield DetailPageError("Some Error Occurred");
      }
    } else if (event is GetProductById) {
      try {
        final response = await productsRepo.fetchProductById(event.productId);
        if (response.status == AppConstants.STATUS_SUCCESS &&
            response.data != null) {
          yield ProductDetailsLoaded(response.data);
        } else {
          yield DetailPageError(response.message);
        }
      } on Error {
        yield DetailPageError("Some Error Occurred");
      }
    } else if (event is GetProductReviews) {
      try {
        final response =
            await productsRepo.fetchProductReviews(event.productId);
        if (response != null && response.isNotEmpty) {
          yield ProductReviewsLoaded(response);
        }
      } on Error {
        yield DetailPageError("Some Error Occurred");
      }
    } else if (event is GetGroupedProducts) {
      try {
        final response =
            await productsRepo.fetchGroupedProduct(event.productIds);
        if (response.status == AppConstants.STATUS_SUCCESS &&
            response.data != null) {
          yield GroupedProductsLoaded(response.data);
        }
      } on Error {
        yield DetailPageError("Some Error Occurred");
      }
    } else if (event is GetProductVariations) {
      try {
        final response =
            await productsRepo.fetchProductVariations(event.productId);
        if (response.isNotEmpty) {
          yield ProductVariationsLoaded(response);
        }
      } on Error {
        yield DetailPageError("Some Error Occurred");
      }
    }
  }
}
