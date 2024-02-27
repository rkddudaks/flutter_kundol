import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_html/shims/dart_ui_real.dart';
// import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/wooResponses/woo_cart_data.dart';
import 'package:flutter_kundol/api/wooResponses/woo_product/woo_product.dart';
// import 'package:flutter_kundol/api/wooResponses/woo_product_response.dart';
import 'package:flutter_kundol/blocs/detail_screen/detail_screen_bloc.dart';
import 'package:flutter_kundol/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
// import 'package:flutter_kundol/models/products/product.dart';
// import 'package:flutter_kundol/repos/cart_repo.dart';
// import 'package:flutter_kundol/repos/products_repo.dart';
import 'package:flutter_svg/svg.dart';

import '../detail_screen.dart';

class CardStyleNew1 extends StatefulWidget {
  final Function(Widget widget)? navigateToNext;
  final WooProduct product;
  final Color cardColor;

  const CardStyleNew1(this.navigateToNext, this.product, this.cardColor);

  @override
  _CardStyleNew1State createState() => _CardStyleNew1State();
}

class _CardStyleNew1State extends State<CardStyleNew1> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.navigateToNext!(
          ProductDetailScreen(widget.product, widget.navigateToNext),
        );
      },
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppStyles.CARD_RADIUS),
          color: widget.cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 4,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: (widget.product.images!.isEmpty)
                    ? Container()
                    : Container(
                        width: double.maxFinite,
                        child: CachedNetworkImage(
                          imageUrl: widget.product.images!.first.src!,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
              ),
              Container(
                color: widget.cardColor,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Html(
                                data: widget.product.priceHtml,
                                style: {
                                  "body": Style(
                                    margin: EdgeInsets.zero,
                                    padding: EdgeInsets.zero,
                                    fontSize: FontSize(11.0),
                                    fontWeight: FontWeight.bold,
                                  ),
                                },
                              )),
                              SizedBox(
                                height: 24,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      18.0)))),
                                  onPressed: () {
                                    if (widget.product.type ==
                                        AppConstants.PRODUCT_TYPE_SIMPLE) {
                                      WooCartData cartData = WooCartData();
                                      cartData.productData = widget.product;
                                      cartData.productType =
                                          widget.product.type;
                                      cartData.link = widget.product.permalink;
                                      cartData.quantity = quantity;
                                      BlocProvider.of<DetailScreenBloc>(context)
                                          .add(AddToCart(cartData));

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text("Added to cart")));
                                    } else {
                                      widget.navigateToNext!(
                                        ProductDetailScreen(widget.product,
                                            widget.navigateToNext),
                                      );
                                    }
                                  },
                                  child: Text(
                                    widget.product.type ==
                                            AppConstants.PRODUCT_TYPE_SIMPLE
                                        ? "Add to Cart"
                                        : "View Details",
                                    style: TextStyle(fontSize: 9),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              GestureDetector(
                onTap: () {
                  if (AppData.wooUser != null) {
                    if (checkForWishlist(widget.product.id)) {
                      for (int i = 0; i < AppData.favProducts.length; i++) {
                        if (AppData.favProducts[i]!.id == widget.product.id) {
                          setState(() {
                            BlocProvider.of<WishlistBloc>(context)
                                .add(UnLikeProduct(AppData.favProducts[i]));
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Removed from Wishlist")));
                          break;
                        }
                      }
                    } else {
                      BlocProvider.of<WishlistBloc>(context)
                          .add(LikeProduct(widget.product));
                      print(LikeProduct(widget.product));
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Added to Wishlist")));
                    }
                  }

                  //   } else {
                  //     BlocProvider.of<WishlistBloc>(context)
                  //         .add(LikeProduct(widget.product));
                  //   }
                  // } else {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //       SnackBar(content: Text("Added to Wishlist")));
                  // }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    width: 25,
                    height: 25,
                    color: Color(0x22000000),
                    child: SvgPicture.asset(
                      (checkForWishlist(widget.product.id))
                          ? "assets/icons/ic_heart_filled.svg"
                          : "assets/icons/ic_heart.svg",
                      fit: BoxFit.none,
                      width: 14,
                      height: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5),
              if (widget.product.onSale!)
                (widget.product.salePrice!.isNotEmpty)
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                            width: 25,
                            height: 25,
                            color: Theme.of(context).primaryColor,
                            child: Center(
                                child: Text(
                                    "-" +
                                        ((double.parse(widget
                                                        .product.regularPrice
                                                        .toString()) -
                                                    double.parse(widget
                                                        .product.salePrice
                                                        .toString())) /
                                                double.parse(widget
                                                    .product.regularPrice
                                                    .toString()) *
                                                100)
                                            .toStringAsFixed(0) +
                                        "%",
                                    style: TextStyle(
                                        fontSize: 8,
                                        color: Colors.white,
                                        fontFamily: "MontserratSemiBold")))),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                            width: 25,
                            height: 25,
                            color: Theme.of(context).primaryColor,
                            child: Center(
                                child: Text(
                              "Sale",
                              style:
                                  TextStyle(fontSize: 9, color: Colors.white),
                            ))),
                      ),
            ]),
          ),
        ]),
      ),
    );
  }

  bool checkForWishlist(int? productId) {
    for (int i = 0; i < AppData.favProducts.length; i++) {
      if (productId == AppData.favProducts[i]!.id) {
        return true;
      }
    }
    return false;
  }
}
