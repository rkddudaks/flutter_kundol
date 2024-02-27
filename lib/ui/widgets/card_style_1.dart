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

class CardStyle1 extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final WooProduct product;
  final Color cardColor;

  const CardStyle1(this.navigateToNext, this.product, this.cardColor);

  @override
  _CardStyle1State createState() => _CardStyle1State();
}

class _CardStyle1State extends State<CardStyle1> {
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
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      AppStyles.CARD_RADIUS),
                                  color: widget.cardColor,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      AppStyles.CARD_RADIUS),
                                  color: widget.cardColor,
                                ),
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
                    Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Center(
                          child: Text("-67%",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 8)),
                        )),
                    Container(
                        height: 30,
                        width: 30,
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
                                  size: 18,
                                )),
                          ),
                        )),
                  ],
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
