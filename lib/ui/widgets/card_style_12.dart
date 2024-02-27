import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/wooResponses/woo_cart_data.dart';
import 'package:flutter_kundol/blocs/detail_screen/detail_screen_bloc.dart';
// import 'package:flutter_kundol/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
// import 'package:flutter_kundol/constants/app_styles.dart';
// import 'package:flutter_kundol/models/products/product.dart';
// import 'package:flutter_kundol/repos/cart_repo.dart';
// import 'package:flutter_kundol/repos/products_repo.dart';

import '../../api/wooResponses/woo_product/woo_product.dart';
import '../detail_screen.dart';

class CardStyle12 extends StatefulWidget {
  final Function(Widget widget)? navigateToNext;
  final WooProduct product;
  final Color cardColor;

  const CardStyle12(this.navigateToNext, this.product, this.cardColor);

  @override
  _CardStyle12State createState() => _CardStyle12State();
}

class _CardStyle12State extends State<CardStyle12> {
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
        borderRadius: BorderRadius.circular(0),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 6,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              child: Text(
                                widget.product.name!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6),
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
                            SizedBox(
                              height: 6,
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                                              ((double.parse(widget.product
                                                              .regularPrice
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
                                    style: TextStyle(
                                        fontSize: 9, color: Colors.white),
                                  ))),
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
