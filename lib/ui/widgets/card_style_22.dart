import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/wooResponses/woo_product/woo_product.dart';
// import 'package:flutter_kundol/blocs/detail_screen/detail_screen_bloc.dart';
// import 'package:flutter_kundol/blocs/wishlist/wishlist_bloc.dart';
// import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
// import 'package:flutter_kundol/models/products/product.dart';
// import 'package:flutter_kundol/repos/cart_repo.dart';
// import 'package:flutter_kundol/repos/products_repo.dart';

import '../detail_screen.dart';

class CardStyle22 extends StatefulWidget {
  final Function(Widget widget)? navigateToNext;
  final WooProduct product;
  final Color cardColor;

  const CardStyle22(this.navigateToNext, this.product, this.cardColor);

  @override
  _CardStyle22State createState() => _CardStyle22State();
}

class _CardStyle22State extends State<CardStyle22> {
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
                                    StarRating(
                                        starCount: 5,
                                        rating:
                                            widget.product.averageRating != null
                                                ? double.parse(widget
                                                    .product.averageRating
                                                    .toString())
                                                : 0,
                                        onRatingChanged: (rating) {}),
                                    Text(
                                      widget.product.name!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
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
                child: Container(
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (widget.product.onSale!)
                        Container(
                            alignment: Alignment.center,
                            height: 20,
                            width: 45,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                            child: Text("Sale",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12))),
                      SizedBox(height: 4.0),
                      if (widget.product.featured!)
                        Container(
                            alignment: Alignment.center,
                            height: 20,
                            width: 65,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xff444444), width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                            child: Text("Featured",
                                style: TextStyle(
                                    color: Color(0xff444444), fontSize: 12))),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(6.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 50),
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
                              widget.navigateToNext!(
                                ProductDetailScreen(
                                    widget.product, widget.navigateToNext),
                              );
                            },
                            child: IconTheme(
                                data: IconThemeData(color: Colors.white),
                                child: Icon(
                                  Icons.shopping_basket_outlined,
                                  size: 24,
                                )),
                          ),
                        )),
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
