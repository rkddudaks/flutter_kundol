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

class CardStyle3 extends StatefulWidget {
  final Function(Widget widget)? navigateToNext;
  final WooProduct product;
  final Color cardColor;

  const CardStyle3(this.navigateToNext, this.product, this.cardColor);

  @override
  _CardStyle3State createState() => _CardStyle3State();
}

class _CardStyle3State extends State<CardStyle3> {
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
                          height: double.maxFinite,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 50),
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
              Padding(
                padding: EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppStyles.CARD_RADIUS),
                  child: Container(
                    height: 60,
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
