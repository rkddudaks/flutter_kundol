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

class CardStyle26 extends StatefulWidget {
  final Function(Widget widget)? navigateToNext;
  final WooProduct product;
  final Color cardColor;

  const CardStyle26(this.navigateToNext, this.product, this.cardColor);

  @override
  _CardStyle26State createState() => _CardStyle26State();
}

class _CardStyle26State extends State<CardStyle26> {
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
                    child: Stack(
                      children: [
                        Container(
                          height: double.maxFinite,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(0),
                            child: (widget.product.images!.isEmpty)
                                ? Container()
                                : Container(
                                    width: double.maxFinite,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          widget.product.images!.first.src!,
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.all(6.0),
                            child: ConstrainedBox(
                              constraints: BoxConstraints.tightFor(
                                  width: double.maxFinite, height: 22),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0),
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
                                        SnackBar(
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
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Theme.of(context).cardColor,
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    if (widget.product.categories!.isNotEmpty)
                                      Text(
                                        widget.product.categories!.first.name!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    Text(
                                      widget.product.name!,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    SizedBox(
                                      height: 12.0,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      height: 25.0,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Theme.of(context)
                                                        .brightness ==
                                                    Brightness.dark
                                                ? AppStyles.COLOR_GREY_DARK
                                                : AppStyles.COLOR_GREY_LIGHT),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
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
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 22.0),
                                              child: Text(
                                                quantity.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
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
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        color: Color(0xff444444),
                      ),
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
                      ),
                    ),
                  ],
                ),
              )
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
