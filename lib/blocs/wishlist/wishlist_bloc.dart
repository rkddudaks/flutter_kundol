import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/api/responses/get_wishlist_on_start_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_product/woo_product.dart';
import 'package:flutter_kundol/blocs/wishlist_detail/wishlist_detail_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/repos/wishlist_repo.dart';
import 'package:hive/hive.dart';

part 'wishlist_event.dart';

part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishlistRepo wishlistRepo;
  final WishlistProductsBloc wishlistProductsBloc;

  WishlistBloc(this.wishlistRepo, this.wishlistProductsBloc)
      : super(WishlistInitial());

  @override
  Stream<WishlistState> mapEventToState(WishlistEvent event) async* {
    if (event is GetWishlistOnStart) {
      try {
        var box = await Hive.openBox<WooProduct>(AppConstants.TBL_WISHLIST);
        if (box.values.toList().isNotEmpty)
          yield WishlistLoaded(box.values.toList());
        else
          yield WishlistError("Empty");
      } on Error {
        yield WishlistError("Couldn't get results. Is the device online?");
      }
    } else if (event is LikeProduct) {
      // try {

      print("like$LikeProduct");

      var box = await Hive.openBox<WooProduct>(AppConstants.TBL_WISHLIST);
      box.add(event.product!);
      WooProduct? item;
      late int position;

      box.values.toList().asMap().forEach((index, element) {
        if (element.id == event.product?.id) {
          item = element;
          position = index;
        }
      });
      if (item != null) {
        print("putAt item to wishlist");
        box.putAt(position, item!);
      } else {
        print("add item to wishlist");
        box.add(event.product!);
      }
      if (box.values.toList().isNotEmpty)
        yield WishlistLoaded(box.values.toList());
      else
        yield WishlistError("Empty");
      //} on Error {
      yield WishlistError("Couldn't fetch weather. Is the device online?");
      // }
      box.close();
    } else if (event is UnLikeProduct) {
      try {
        var box = await Hive.openBox<WooProduct>(AppConstants.TBL_WISHLIST);
        for (int i = 0; i < box.values.toList().length; i++) {
          WooProduct data = box.values.toList()[i];
          if (data.id == event.product!.id) {
            box.deleteAt(i);
          }
        }
        AppData.favProducts = box.values.toList();
        if (box.values.toList().isNotEmpty) {
          wishlistProductsBloc.add(RefreshWishlistProducts());
          yield WishlistLoaded(box.values.toList());
        } else
          yield WishlistError("Empty");
      } on Error {
        yield WishlistError("Couldn't get results. Is the device online?");
      }
    }
  }
}
