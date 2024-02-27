import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/wooResponses/woo_product/woo_product.dart';
// import 'package:flutter_kundol/blocs/detail_screen/detail_screen_bloc.dart';
import 'package:flutter_kundol/blocs/wishlist/wishlist_bloc.dart';
// import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
// import 'package:flutter_kundol/models/products/product.dart';
// import 'package:flutter_kundol/repos/cart_repo.dart';
// import 'package:flutter_kundol/repos/products_repo.dart';

import '../detail_screen.dart';

class CardStyleFav extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final WooProduct product;

  const CardStyleFav(this.navigateToNext, this.product);

  @override
  _CardStyleFavState createState() => _CardStyleFavState();
}

class _CardStyleFavState extends State<CardStyleFav> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.navigateToNext(
          ProductDetailScreen(widget.product, widget.navigateToNext),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppStyles.CARD_RADIUS),
        child: new Card(
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
                        borderRadius:
                            BorderRadius.circular(AppStyles.CARD_RADIUS),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.name!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
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
                            SizedBox(height: 6.0),
                            Container(
                              width: double.maxFinite,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                  ),
                                  onPressed: () {
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
                                        break;
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Remove",
                                    style: TextStyle(fontSize: 12),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
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
    for (int i = 0; i < AppData.wishlistData.length; i++) {
      if (productId == AppData.wishlistData[i].productId) {
        return true;
      }
    }
    return false;
  }
}
