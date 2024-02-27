import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/wooResponses/woo_cart_data.dart';
import 'package:flutter_kundol/api/wooResponses/woo_product/woo_product.dart';
import 'package:flutter_kundol/blocs/detail_screen/detail_screen_bloc.dart';
// import 'package:flutter_kundol/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
// import 'package:flutter_kundol/models/products/product.dart';
// import 'package:flutter_kundol/repos/cart_repo.dart';
// import 'package:flutter_kundol/repos/products_repo.dart';

import '../detail_screen.dart';

class CardStyle27 extends StatefulWidget {
  final Function(Widget widget)? navigateToNext;
  final WooProduct product;
  final Color cardColor;

  const CardStyle27(this.navigateToNext, this.product, this.cardColor);

  @override
  _CardStyle27State createState() => _CardStyle27State();
}

class _CardStyle27State extends State<CardStyle27> {
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
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppStyles.CARD_RADIUS),
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
                height: double.maxFinite,
                padding: EdgeInsets.only(bottom: 80),
              ),
              Padding(
                padding: EdgeInsets.all(6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.product.featured!)
                      Container(
                          alignment: Alignment.center,
                          height: 20,
                          width: 65,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                            color: Color(0xff444444),
                          ),
                          child: Text("Featured",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12))),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Theme.of(context).cardColor
                        : Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(AppStyles.CARD_RADIUS),
                  ),
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        widget.product.name!,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        height: 25.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppStyles.COLOR_GREY_DARK
                                  : AppStyles.COLOR_GREY_LIGHT),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (quantity > 1) quantity--;
                                  });
                                },
                                child: Icon(
                                  Icons.remove,
                                  size: 16.0,
                                )),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 22.0),
                                child: Text(
                                  quantity.toString(),
                                  style: Theme.of(context).textTheme.bodySmall,
                                )),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              child: Icon(
                                Icons.add,
                                size: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      Html(
                        data: widget.product.priceHtml,
                        style: {
                          "body": Style(
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            fontSize: FontSize(11.0),
                            fontWeight: FontWeight.bold,
                          ),
                        },
                      ),
                      Container(
                        width: double.maxFinite,
                        height: 24,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ))),
                          onPressed: () {
                            if (widget.product.type ==
                                AppConstants.PRODUCT_TYPE_SIMPLE) {
                              WooCartData cartData = WooCartData();
                              cartData.productData = widget.product;
                              cartData.productType = widget.product.type;
                              cartData.link = widget.product.permalink;
                              cartData.quantity = quantity;
                              BlocProvider.of<DetailScreenBloc>(context)
                                  .add(AddToCart(cartData));

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Added to cart")));
                            } else {
                              widget.navigateToNext!(
                                ProductDetailScreen(
                                    widget.product, widget.navigateToNext),
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool checkForWishlist(int productId) {
    for (int i = 0; i < AppData.favProducts.length; i++) {
      if (productId == AppData.favProducts[i]!.id) {
        return true;
      }
    }
    return false;
  }
}
