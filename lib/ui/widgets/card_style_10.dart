import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/wooResponses/woo_cart_data.dart';
import 'package:flutter_kundol/api/wooResponses/woo_product/woo_product.dart';
import 'package:flutter_kundol/blocs/detail_screen/detail_screen_bloc.dart';
import 'package:flutter_kundol/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
// import 'package:flutter_kundol/models/products/product.dart';
// import 'package:flutter_kundol/repos/cart_repo.dart';
// import 'package:flutter_kundol/repos/products_repo.dart';

import '../detail_screen.dart';

class CardStyle10 extends StatefulWidget {
  final Function(Widget widget)? navigateToNext;
  final WooProduct product;
  final Color cardColor;

  const CardStyle10(this.navigateToNext, this.product, this.cardColor);

  @override
  _CardStyle10State createState() => _CardStyle10State();
}

class _CardStyle10State extends State<CardStyle10> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.navigateToNext!(
          ProductDetailScreen(widget.product, widget.navigateToNext),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppStyles.CARD_RADIUS),
        child: new Card(
          color: widget.cardColor,
          margin: EdgeInsets.zero,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: (widget.product.images!.isEmpty)
                            ? Container()
                            : Container(
                                width: double.maxFinite,
                                child: CachedNetworkImage(
                                  imageUrl: widget.product.images!.first.src!,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                      ),
                    ),
                  ),
                  Container(
                    color: widget.cardColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.product.name!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints.tightFor(
                                            width: double.maxFinite,
                                            height: 22),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                          ))),
                                          onPressed: () {
                                            if (widget.product.type ==
                                                AppConstants
                                                    .PRODUCT_TYPE_SIMPLE) {
                                              WooCartData cartData =
                                                  WooCartData();
                                              cartData.productData =
                                                  widget.product;
                                              cartData.productType =
                                                  widget.product.type;
                                              cartData.link =
                                                  widget.product.permalink;
                                              cartData.quantity = quantity;
                                              BlocProvider.of<DetailScreenBloc>(
                                                      context)
                                                  .add(AddToCart(cartData));

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Added to cart")));
                                            } else {
                                              widget.navigateToNext!(
                                                ProductDetailScreen(
                                                    widget.product,
                                                    widget.navigateToNext),
                                              );
                                            }
                                          },
                                          child: Text(
                                            widget.product.type ==
                                                    AppConstants
                                                        .PRODUCT_TYPE_SIMPLE
                                                ? "Add to Cart"
                                                : "View Details",
                                            style: TextStyle(fontSize: 9),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 5, bottom: 5, left: 10),
                      alignment: Alignment.center,
                      width: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        color: Color(0xff444444),
                      ),
                      child: Html(
                        data: widget.product.priceHtml,
                        style: {
                          "body": Style(
                            color: Colors.white,
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            fontSize: FontSize(11.0),
                            fontWeight: FontWeight.bold,
                          ),
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(6.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              if (AppData.wooUser != null) {
                                if (checkForWishlist(widget.product.id)) {
                                  for (int i = 0;
                                      i < AppData.favProducts.length;
                                      i++) {
                                    if (AppData.favProducts[i]!.id ==
                                        widget.product.id) {
                                      setState(() {
                                        BlocProvider.of<WishlistBloc>(context)
                                            .add(UnLikeProduct(
                                                AppData.favProducts[i]));
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Removed from Wishlist")));
                                      break;
                                    }
                                  }
                                } else {
                                  BlocProvider.of<WishlistBloc>(context)
                                      .add(LikeProduct(widget.product));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("Added to Wishlist")));
                              }
                            },
                            child: IconTheme(
                                data: IconThemeData(color: Colors.white),
                                child: Icon(
                                  (checkForWishlist(widget.product.id))
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.white,
                                  size: 24,
                                )),
                          ),
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
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
