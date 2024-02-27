// import 'dart:collection';
// import 'dart:convert';
// import 'dart:developer';
// import 'dart:math';
// import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/wooResponses/woo_cart_data.dart';
import 'package:flutter_kundol/api/wooResponses/woo_product/woo_product.dart';
import 'package:flutter_kundol/api/wooResponses/woo_product/woo_product_attributes.dart';
// import 'package:flutter_kundol/api/wooResponses/woo_product_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_variations/woo_variations_response.dart';
// import 'package:flutter_kundol/blocs/wishlist/wishlist_bloc.dart';
// import 'package:flutter_kundol/ui/main_screen.dart';
import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
import 'package:flutter_kundol/blocs/detail_screen/detail_screen_bloc.dart';
import 'package:flutter_kundol/blocs/related_products/related_products_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/products/product.dart';
import 'package:flutter_kundol/repos/cart_repo.dart';
import 'package:flutter_kundol/repos/products_repo.dart';
// import 'package:flutter_kundol/repos/reviews_repo.dart';
// import 'package:flutter_kundol/ui/review_screen.dart';
// import 'package:flutter_kundol/blocs/reviews/reviews_bloc.dart';
import 'package:flutter_kundol/ui/widgets/app_bar.dart';
// import 'package:flutter_kundol/ui/widgets/products_widget.dart';
import 'package:flutter_kundol/ui/widgets/related_products_widget.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:hive/hive.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'cart_screen.dart';
import 'login_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  Function(Widget widget)? navigateToNext;
  WooProduct? product;

  static WooProduct? tempProduct;

  ProductDetailScreen(
      WooProduct product, Function(Widget widget)? navigateToNext) {
    this.product = product;
    tempProduct = product;
    this.navigateToNext = navigateToNext;
  }

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _sliderIndex = 0;
  int quantity = 1;
  List<int> groupedQuantity = [];
  List<WooVariationsResponse> variations = [];

  @override
  void initState() {
    // print((categories));
    super.initState();
    // final body1 = widget.product!.categories;
    print("product");
    print(widget.product!.id);

    //  final body = widget.product!.name;
    //  print("Detail screen "+body.toString());

    /*BlocProvider.of<DetailScreenBloc>(context)
        .add(GetProductById(widget.product.productId));*/
    if (widget.product!.type == AppConstants.PRODUCT_TYPE_GROUPED)
      BlocProvider.of<DetailScreenBloc>(context)
          .add(GetGroupedProducts(widget.product!.groupedProducts));
    else if (widget.product!.type == AppConstants.PRODUCT_TYPE_VARIABLE)
      BlocProvider.of<DetailScreenBloc>(context)
          .add(GetProductVariations(widget.product!.id));
    BlocProvider.of<DetailScreenBloc>(context)
        .add(GetProductReviews(widget.product!.id));
  }

  @override
  Widget build(BuildContext context) {
    // final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).scaffoldBackgroundColor
          : Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0), // here the desired height
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Theme.of(context).cardColor,
          )),
      body: BlocConsumer<DetailScreenBloc, DetailPageState>(
        listener: (context, state) {
          if (state is GetQuantityLoaded) {
            if (state.quantityData!.remainingStock == null ||
                int.tryParse(state.quantityData!.remainingStock!) == 0) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Stock is empty")));
            } else if (int.tryParse(state.quantityData!.remainingStock!)! <
                quantity) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Max stock available is: " +
                      state.quantityData!.remainingStock!)));
            } else if (int.tryParse(state.quantityData!.remainingStock!)! >=
                quantity) {
              /*BlocProvider.of<DetailScreenBloc>(context).add(AddToCart(
                  widget.product.productId,
                  quantity,
                  state.quantityData.productCombinationId));*/
            }
          } else if (state is ItemCartAdded) {
            Navigator.pop(context);
            AppData.cartItems = state.cartItems;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Added to cart")));
          }
          /*else if (state is ProductDetailsLoaded) {
            setState(() {
              widget.`product `= state.product;
            });
          }*/
          else if (state is ProductVariationsLoaded) {
            variations = state.variations;
          } else if (state is DetailPageError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error!)));
          } else if (state is ProductReviewsLoaded) {
          } else if (state is GroupedProductsLoaded) {
            groupedQuantity = [];
            for (int i = 0; i < state.products!.length; i++) {
              groupedQuantity.add(0);
            }
          } else {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Empty")));
          }
        },
        builder: (context, state) {
          //if (state is ProductDetailsLoaded)
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: [
                  MyAppBar(
                    leadingWidget: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Container(
                          width: 30,
                          height: 30,
                          child: Icon(
                            Icons.arrow_back_outlined,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    centerWidget: Center(
                        child: Text(
                      "Product Details",
                      style: TextStyle(
                          fontSize: 16.0, fontFamily: "MontserratSemiBold"),
                    )),
                    /*centerWidget: GestureDetector(
                onTap: () {
                  widget.navigateToNext(BlocProvider(
                    create: (context) => ProductsSearchBloc(RealProductsRepo()),
                    child: SearchScreen(),
                  ));
                },
                child: Container(
                  height: 35.0,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: AppStyles.COLOR_SEARCH_BAR,
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppStyles.CARD_RADIUS)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search_outlined,
                        size: 18.0,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "What are you looking for?",
                            style: Theme.of(context).textTheme.caption,
                          ))
                    ],
                  ),
                ),
              ),*/
                    trailingWidget: Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => widget.navigateToNext!(
                              (AppData.wooUser != null)
                                  ? BlocProvider(
                                      create: (context) =>
                                          CartBloc(RealCartRepo()),
                                      child: CartScreen())
                                  : SignIn(),
                            ),
                            child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  "assets/icons/ic_cart.svg",
                                  fit: BoxFit.none,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppStyles.COLOR_ICONS_DARK
                                      : AppStyles.COLOR_ICONS_LIGHT,
                                )),
                          ),
                        ],
                      ),
                    ),
                    /*trailingWidget: IconButton(
                icon: Icon(Icons.shopping_basket_outlined),
                onPressed: () {
                  widget.navigateToNext(BlocProvider(
                      create: (context) => CartBloc(RealCartRepo()),
                      child: CartScreen()));
                },
              ),*/
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
                            horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                        child: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(AppStyles.CARD_RADIUS),
                              child: Container(
                                width: double.maxFinite,
                                child: AspectRatio(
                                  aspectRatio: 1.5 / 1,
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      // CarouselSlider.builder(
                                      //   options: CarouselOptions(
                                      //     height: 200.0,
                                      //     autoPlay: true,
                                      //     viewportFraction: 1.0,
                                      //     enableInfiniteScroll: true,
                                      //     initialPage: 0,
                                      //     autoPlayInterval:
                                      //         Duration(seconds: 5),
                                      //     enlargeCenterPage: false,
                                      //     autoPlayAnimationDuration:
                                      //         Duration(milliseconds: 500),
                                      //     autoPlayCurve: Curves.fastOutSlowIn,
                                      //     pauseAutoPlayOnTouch: false,
                                      //     scrollDirection: Axis.horizontal,
                                      //     onPageChanged: (index, reason) {
                                      //       setState(() {
                                      //         _sliderIndex = index;
                                      //       });
                                      //     },
                                      //   ),
                                      //   itemBuilder: (BuildContext context,
                                      //       int index, int realIndex) {
                                      //     return Container(
                                      //       width: double.maxFinite,
                                      //       height: double.maxFinite,
                                      //       child: CachedNetworkImage(
                                      //         imageUrl: ApiProvider
                                      //                 .imgMediumUrlString +
                                      //             widget
                                      //                 .product
                                      //                 .productGallaryDetail[
                                      //                     index]
                                      //                 .gallaryName,
                                      //         fit: BoxFit.cover,
                                      //         progressIndicatorBuilder: (context,
                                      //                 url, downloadProgress) =>
                                      //             Center(
                                      //                 child: CircularProgressIndicator(
                                      //                     value:
                                      //                         downloadProgress
                                      //                             .progress)),
                                      //         errorWidget:
                                      //             (context, url, error) =>
                                      //                 Icon(Icons.error),
                                      //       ),
                                      //     );
                                      //   },
                                      //   itemCount: widget.product
                                      //       .productGallaryDetail.length,
                                      // ),
                                      // Container(
                                      //   height: 50.0,
                                      //   child: ListView.builder(
                                      //     shrinkWrap: true,
                                      //     scrollDirection: Axis.horizontal,
                                      //     itemBuilder: (context, index) {
                                      //       return Container(
                                      //         width: 8.0,
                                      //         height: 8.0,
                                      //         margin: EdgeInsets.symmetric(
                                      //             vertical: 12,
                                      //             horizontal: 2.0),
                                      //         decoration: BoxDecoration(
                                      //           border: Border.all(
                                      //               color: Colors.black54),
                                      //           shape: BoxShape.circle,
                                      //           color: _sliderIndex == index
                                      //               ? Colors.white54
                                      //               : Colors.transparent,
                                      //         ),
                                      //       );
                                      //     },
                                      //     itemCount: widget.product
                                      //         .productGallaryDetail.length,
                                      //   ),
                                      // ),
                                      CarouselSlider.builder(
                                        options: CarouselOptions(
                                          height: double.maxFinite,
                                          autoPlay: true,
                                          viewportFraction: 1.0,
                                          enableInfiniteScroll: true,
                                          initialPage: 0,
                                          autoPlayInterval:
                                              Duration(seconds: 5),
                                          enlargeCenterPage: false,
                                          autoPlayAnimationDuration:
                                              Duration(milliseconds: 500),
                                          autoPlayCurve: Curves.fastOutSlowIn,
                                          pauseAutoPlayOnTouch: false,
                                          scrollDirection: Axis.horizontal,
                                          onPageChanged: (index, reason) {
                                            setState(() {
                                              _sliderIndex = index;
                                            });
                                          },
                                        ),
                                        itemBuilder: (BuildContext context,
                                            int index, int realIndex) {
                                          return Container(
                                            width: double.maxFinite,
                                            height: double.maxFinite,
                                            child: CachedNetworkImage(
                                              imageUrl: widget
                                                  .product!.images![index].src!,
                                              fit: BoxFit.cover,
                                              progressIndicatorBuilder: (context,
                                                      url, downloadProgress) =>
                                                  Center(
                                                      child: CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress)),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          );
                                        },
                                        itemCount:
                                            widget.product!.images!.length,
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          margin: EdgeInsets.only(top: 150),
                                          height: 50.0,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                width: 8.0,
                                                height: 8.0,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 2.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black54),
                                                  shape: BoxShape.circle,
                                                  color: _sliderIndex == index
                                                      ? Colors.white54
                                                      : Colors.transparent,
                                                ),
                                              );
                                            },
                                            itemCount:
                                                widget.product!.images!.length,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: InkWell(
                                          splashColor: Colors.black12,
                                          onTap: () {
                                            print("like");
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: Colors.white,
                                            ),
                                            margin: EdgeInsets.all(12),
                                            width: 35,
                                            height: 35,
                                            // color: Colors.red,
                                            child: SvgPicture.asset(
                                              /*(checkForWishlist(
                                                        widget.product.productId))
                                                    ? "assets/icons/ic_heart_filled_new.svg"
                                                    :*/
                                              "assets/icons/ic_heart.svg",
                                              fit: BoxFit.none,
                                              width: 14,
                                              height: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 12.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    if (widget.product!.salePrice!.isNotEmpty)
                                      buildLabel(
                                        "SALE",
                                        Colors.red,
                                      ),
                                    SizedBox(width: 10),
                                    if (widget.product!.featured!)
                                      buildLabel(
                                        "FEATURED",
                                        Color(0xFF36AFFF),
                                      ),
                                    /*SizedBox(width: 10),
                                      buildLabel(
                                        "NEW",
                                        Color(0xFF18EF35),
                                      ),*/
                                  ],
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
/*
                                          if (AppData.wooUser != null) {
                                            if (checkForWishlist(widget.product.productId)) {
                                              for (int i = 0; i < AppData.wishlistData.length; i++) {
                                                if (AppData.wishlistData[i].productId == widget.product.productId) {
                                                  setState(() {
                                                    BlocProvider.of<WishlistBloc>(context).add(UnLikeProduct(
                                                            AppData
                                                                .wishlistData[i]
                                                                .wishlist));
                                                  });
                                                  break;
                                                }
                                              }
                                            } else {
                                              BlocProvider.of<WishlistBloc>(
                                                      context)
                                                  .add(LikeProduct(widget
                                                      .product.productId));
                                            }
                                          }
*/
                                      },
                                      child: Container(
                                          // child: ClipRRect(
                                          //   borderRadius:
                                          //       BorderRadius.circular(5),
                                          //   child: Container(
                                          //     width: 25,
                                          //     height: 25,
                                          //     color: Color(0x22000000),
                                          //     child: SvgPicture.asset(
                                          //       (checkForWishlist(
                                          //               widget.product.productId))
                                          //           ? "assets/icons/ic_heart_filled.svg"
                                          //           : "assets/icons/ic_heart.svg",
                                          //       fit: BoxFit.none,
                                          //       width: 14,
                                          //       height: 14,
                                          //       color: (false)
                                          //           ? Theme.of(context)
                                          //               .primaryColor
                                          //           : Colors.white,
                                          //     ),
                                          //   ),
                                          // ),
                                          ),
                                    ),
                                    SizedBox(width: 12.0),
                                    GestureDetector(
                                      onTap: () {
                                        Share.share(
                                            "Hi there, please check this app. i think you will love it. ");
                                      },
                                      child: Icon(
                                        Icons.share,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              widget.product!.name!,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: "MontserratSemiBold"),
                            ),
                            SizedBox(height: 6.0),
                            Html(
                              data: widget.product!.priceHtml,
                              style: {
                                "body": Style(
                                  margin: EdgeInsets.zero,
                                  padding: EdgeInsets.zero,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: FontSize(18.0),
                                  fontWeight: FontWeight.bold,
                                ),
                              },
                            ),
                            /*(widget.product.salePrice.isNotEmpty)
                                ? Row(
                                    children: [
                                      Text(
                                        AppData.currency.code +
                                            double.parse(widget
                                                    .product.salePrice
                                                    .toString())
                                                .toStringAsFixed(2),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        AppData.currency.code +
                                            double.parse(widget.product.price
                                                    .toString())
                                                .toStringAsFixed(2),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            .copyWith(
                                                decoration:
                                                    TextDecoration.lineThrough),
                                      ),
                                    ],
                                  )
                                : Text(
                                    AppData.currency.code +
                                        double.parse(
                                                widget.product.price.toString())
                                            .toStringAsFixed(2),
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: "MontserratSemiBold"),
                                  ),*/
/*
                            (widget.product.productType ==
                                    AppConstants.PRODUCT_TYPE_SIMPLE)
                                ? Row(
                                    children: [
                                      Text(
                                        "\$" +
                                            double.tryParse(
                                                    (widget.product.productPrice *
                                                            quantity)
                                                        .toString())
                                                .toStringAsFixed(2),
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                      ),
                                      if (widget.product.productDiscountPrice !=
                                          0)
                                        Text(
                                          "\$" +
                                              double.tryParse((widget.product
                                                              .productDiscountPrice *
                                                          quantity)
                                                      .toString())
                                                  .toStringAsFixed(2),
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1
                                              .copyWith(
                                                  decoration:
                                                      TextDecoration.lineThrough),
                                        ),
                                      Container(
                                        padding: EdgeInsets.all(1),
                                        color: Color(0xFFF1435A),
                                        child: Text(
                                          "-67%",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    ],
                                  )
                                : RichText(
                                    text: TextSpan(children: [
                                    TextSpan(
                                      text: "\$" +
                                          double.tryParse(widget.product
                                                  .productCombination.first.price
                                                  .toString())
                                              .toStringAsFixed(2),
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    TextSpan(text: " - "),
                                    TextSpan(
                                      text: "\$" +
                                          double.tryParse(widget.product
                                                  .productCombination.last.price
                                                  .toString())
                                              .toStringAsFixed(2),
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ])),
*/
                            SizedBox(height: 6.0),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: "Category:  ",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              TextSpan(

                                  //  text:"1st",
                                  text: widget.product!.categories!.first.name!,
                                  style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppStyles.COLOR_GREY_DARK
                                          : AppStyles.COLOR_GREY_LIGHT)),
                            ])),
                            SizedBox(height: 4.0),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: "ID:  ",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              TextSpan(
                                  text: widget.product!.id.toString(),
                                  style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppStyles.COLOR_GREY_DARK
                                          : AppStyles.COLOR_GREY_LIGHT)),
                            ])),
                            SizedBox(height: 4.0),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: "Tags:  ",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              TextSpan(
                                  text: widget.product!.slug == null
                                      ? ""
                                      : widget.product!.slug,
                                  style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppStyles.COLOR_GREY_DARK
                                          : AppStyles.COLOR_GREY_LIGHT)),
                            ])),
                            SizedBox(height: 8.0),
                            Text(
                              "Description:",
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: Theme.of(context).primaryColor),
                            ),
                            Html(
                              data: widget.product!.description,
                              style: {
                                "body": Style(
                                  margin: EdgeInsets.zero,
                                  padding: EdgeInsets.zero,
                                ),
                              },
                            ),
/*
                            Text(widget.product.description,
                                style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppStyles.COLOR_GREY_DARK
                                      : AppStyles.COLOR_GREY_LIGHT,
                                )),
*/
                            Text(
                              "Seller Information:",
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: Theme.of(context).primaryColor),
                            ),
                            Text(
                              "Sold by " +
                                  widget.product!.store!.vendorDisplayName
                                      .toString(),
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: Theme.of(context).primaryColor),
                            ),
                            if (state is GroupedProductsLoaded)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8.0),
                                  Text(
                                    "Linked Products:",
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            color:
                                                Theme.of(context).primaryColor),
                                  ),
                                  SizedBox(height: 4.0),
                                  ListView.builder(
                                    itemCount: state.products!.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => ListTile(
                                      onTap: () {
                                        if (state.products![index].type !=
                                            AppConstants.PRODUCT_TYPE_SIMPLE) {
                                          widget.navigateToNext!(
                                            BlocProvider(
                                                create: (context) =>
                                                    DetailScreenBloc(
                                                        RealCartRepo(),
                                                        RealProductsRepo()),
                                                child: ProductDetailScreen(
                                                    state.products![index],
                                                    widget.navigateToNext)),
                                          );
                                        }
                                      },
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      leading: Container(
                                        width: 70,
                                        height: 70,
                                        child: CachedNetworkImage(
                                          imageUrl: state.products![index]
                                              .images!.first.src!,
                                          fit: BoxFit.contain,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                      title: Text(
                                        state.products![index].name!,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      subtitle: Html(
                                        data: state.products![index].priceHtml,
                                        style: {
                                          "body": Style(
                                            margin: EdgeInsets.zero,
                                            padding: EdgeInsets.zero,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: FontSize(12.0),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        },
                                      ),
                                      trailing: Container(
                                        child: (state.products![index].type ==
                                                AppConstants
                                                    .PRODUCT_TYPE_SIMPLE)
                                            ? Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    height: 24,
                                                    width: 24,
                                                    child: MaterialButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          if (groupedQuantity[
                                                                  index] >
                                                              0)
                                                            groupedQuantity[
                                                                index]--;
                                                        });
                                                      },
                                                      color: Colors.grey,
                                                      textColor: Colors.white,
                                                      child: Text(
                                                        "-",
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                      padding: EdgeInsets.only(
                                                          bottom: 3),
                                                      shape: CircleBorder(),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 22.0),
                                                      child: Text(
                                                        groupedQuantity[index]
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium,
                                                      )),
                                                  Container(
                                                    height: 24,
                                                    width: 24,
                                                    child: MaterialButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          groupedQuantity[
                                                              index]++;
                                                        });
                                                      },
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      textColor: Colors.white,
                                                      child: Text(
                                                        "+",
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                      padding: EdgeInsets.only(
                                                          bottom: 3),
                                                      shape: CircleBorder(),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Container(
                                                height: 24,
                                                width: 24,
                                                child: MaterialButton(
                                                  onPressed: () {},
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  textColor: Colors.white,
                                                  child: Center(
                                                      child: Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: 14,
                                                  )),
                                                  padding: EdgeInsets.only(
                                                      bottom: 0),
                                                  shape: CircleBorder(),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            else
                              (widget.product!.type ==
                                      AppConstants.PRODUCT_TYPE_VARIABLE)
                                  ? Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          side: BorderSide(
                                            width: 1,
                                            color:
                                                Theme.of(context).primaryColor,
                                          )),
                                      elevation: 5,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Theme.of(context)
                                              .scaffoldBackgroundColor
                                          : Colors.white,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: ListTile(
                                          onTap: () {
                                            buildBottomSheet(context);
                                          },
                                          dense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 0),
                                          title: Text(
                                              "Select Color, Size & Quality"),
                                          trailing: Icon(Icons.chevron_right),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      child: ListTile(
                                        dense: true,
                                        contentPadding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                        title: Text("Quantity"),
                                        trailing: Container(
                                          // decoration: BoxDecoration(
                                          //   border: Border.all(
                                          //       color: Theme.of(context).brightness ==
                                          //               Brightness.dark
                                          //           ? AppStyles.COLOR_GREY_DARK
                                          //           : AppStyles.COLOR_GREY_LIGHT),
                                          //   borderRadius: BorderRadius.all(
                                          //       Radius.circular(8.0)),
                                          // ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                height: 24,
                                                width: 24,
                                                child: MaterialButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      if (quantity > 1)
                                                        quantity--;
                                                    });
                                                  },
                                                  color: Colors.grey,
                                                  textColor: Colors.white,
                                                  child: Text(
                                                    "-",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  padding: EdgeInsets.only(
                                                      bottom: 3),
                                                  shape: CircleBorder(),
                                                ),
                                              ),
                                              // IconButton(
                                              //     icon: Icon(Icons.chevron_left),
                                              //     onPressed: () {
                                              //       setState(() {
                                              //         if (quantity > 1) quantity--;
                                              //       });
                                              //     }
                                              //     ),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 22.0),
                                                  child: Text(
                                                    quantity.toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium,
                                                  )),
                                              Container(
                                                height: 24,
                                                width: 24,
                                                child: MaterialButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      quantity++;
                                                    });
                                                  },
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  textColor: Colors.white,
                                                  child: Text(
                                                    "+",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  padding: EdgeInsets.only(
                                                      bottom: 3),
                                                  shape: CircleBorder(),
                                                ),
                                              ),
                                              // IconButton(
                                              //     icon: Icon(Icons.chevron_right),
                                              //     onPressed: () {
                                              //       setState(() {
                                              //         quantity++;
                                              //       });
                                              //     }),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                            if (state is ProductReviewsLoaded)
                              GestureDetector(
                                /*onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                          create: (BuildContext context) {
                                            return ReviewsBloc(
                                                RealReviewsRepo());
                                          },
                                          child: ReviewScreen(
                                              widget.product.productId)),
                                    )),*/
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Reviews",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ),
                                          Text(
                                            "See All",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        widget.product!.name!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      SizedBox(height: 12.0),
                                      StarRating(
                                          starCount: 5,
                                          rating:
                                              widget.product!.averageRating !=
                                                      null
                                                  ? double.parse(widget
                                                      .product!.averageRating!)
                                                  : 0,
                                          onRatingChanged: (rating) {}),
                                      SizedBox(height: 12.0),
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: (widget.product!
                                                        .averageRating !=
                                                    null)
                                                ? double.tryParse(widget
                                                        .product!.averageRating
                                                        .toString())!
                                                    .toStringAsFixed(1)
                                                : 0.0.toString(),
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? AppStyles.COLOR_GREY_DARK
                                                    : AppStyles
                                                        .COLOR_GREY_LIGHT)),
                                        TextSpan(
                                            text: " (" +
                                                widget.product!.ratingCount
                                                    .toString() +
                                                " Reviews)",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? AppStyles.COLOR_GREY_DARK
                                                    : AppStyles
                                                        .COLOR_GREY_LIGHT)),
                                      ])),
                                      SizedBox(height: 12.0),
                                      ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: state.reviews.length,
                                        itemBuilder: (context, index) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            StarRating(
                                                starCount: 5,
                                                rating: state.reviews[index]
                                                            .rating !=
                                                        null
                                                    ? state
                                                        .reviews[index].rating!
                                                        .toDouble()
                                                    : 0.0,
                                                onRatingChanged: (rating) {}),
                                            Text(
                                              state.reviews[index].reviewer!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                            ),
                                            SizedBox(
                                              height: 2.0,
                                            ),
                                            Text(
                                              state.reviews[index].dateCreated!,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? AppStyles
                                                          .COLOR_GREY_DARK
                                                      : AppStyles
                                                          .COLOR_GREY_LIGHT),
                                            ),
                                            SizedBox(
                                              height: 2.0,
                                            ),
                                            Text(
                                              state.reviews[index].review!,
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.dark
                                                          ? AppStyles
                                                              .COLOR_GREY_DARK
                                                          : AppStyles
                                                              .COLOR_GREY_LIGHT),
                                            ),
                                            SizedBox(
                                              height: 4.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                      //SizedBox(height: 12.0),
                                      SizedBox(height: 12.0),
                                    ],
                                  ),
                                ),
                              ),
                            BlocProvider(
                              create: (context) =>
                                  RelatedProductsBloc(RealProductsRepo()),
                              child: RelatedProductsWidget(
                                  widget.product!.categories!.length,
                                  // widget.product!.categories?.first.id,
                                  widget.navigateToNext),
                            ),
                            //ProductsWidget(null, null),
                            SizedBox(
                              height: 75.0,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
                    horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                height: 45.0,
                width: double.maxFinite,
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  label: Text(
                      (widget.product!.type != AppConstants.PRODUCT_TYPE_SIMPLE)
                          ? 'ADD TO CART'
                          : (widget.product!.stockStatus ==
                                  AppConstants.PRODUCT_IN_STOCK)
                              ? 'ADD TO CART'
                              : 'OUT OF STOCK'),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ))),
                  onPressed: () async {
                    if (widget.product!.type ==
                        AppConstants.PRODUCT_TYPE_VARIABLE)
                      buildBottomSheet(context);
                    else if (widget.product!.type ==
                        AppConstants.PRODUCT_TYPE_EXTERNAL)
                      // ignore: deprecated_member_use
                      await launch(widget.product!.permalink!);
                    else if (widget.product!.type ==
                        AppConstants.PRODUCT_TYPE_GROUPED) {
                      if (state is GroupedProductsLoaded) {
                        List<WooCartData> groupedCartData = [];
                        for (int i = 0; i < state.products!.length; i++) {
                          if (groupedQuantity[i] > 0 &&
                              state.products![i].stockStatus ==
                                  AppConstants.PRODUCT_IN_STOCK) {
                            WooCartData cartData = WooCartData();
                            cartData.productData = state.products![i];
                            cartData.productType = state.products![i].type;
                            cartData.link = state.products![i].permalink;
                            cartData.quantity = groupedQuantity[i];
                            groupedCartData.add(cartData);
                          }
                        }
                        addToCartGrouped(groupedCartData);
                      }
                    } else {
                      if (widget.product!.stockStatus ==
                          AppConstants.PRODUCT_IN_STOCK) {
                        WooCartData cartData = WooCartData();
                        cartData.productData = widget.product;
                        cartData.productType = widget.product!.type;
                        cartData.link = widget.product!.permalink;
                        cartData.quantity = quantity;
                        addToCart(cartData);
                      }
                    }
                    /*else {
                        BlocProvider.of<DetailScreenBloc>(context).add(
                            GetQuantity(
                                widget.product.productId, "simple", null));
                      }*/
                  },
                ),
              ),
            ],
          );
          /*else
            return Center(child: CircularProgressIndicator());*/
        },
      ),
    );
  }

  void buildBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BottomSheetContent(
          tempProduct: widget.product,
          allProductVariationsList: variations,
          onVariationSelected:
              (selectedVariation, variationSelectionText, quantity) =>
                  onVariationSelected(
                      selectedVariation!, variationSelectionText, quantity),
        );
      },
    );
  }

  void onVariationSelected(WooVariationsResponse selectedVariation,
      String variationSelectionText, int quantity) {
    WooCartData cartData = WooCartData();
    cartData.productData = widget.product;
    cartData.productType = widget.product!.type;
    cartData.link = widget.product!.permalink;
    cartData.selectedVariation = selectedVariation;
    cartData.variationSelectionText = variationSelectionText;
    cartData.quantity = quantity;
    addToCart(cartData);
/*
    Navigator.pop(context);
    this.quantity = quantity;
    BlocProvider.of<DetailScreenBloc>(context)
        .add(GetQuantity(widget.product.productId, "variable", combinationId));
*/
  }

  Widget buildDivider(BuildContext context) {
    return Divider(
      color: Theme.of(context).brightness == Brightness.dark
          ? AppStyles.COLOR_LITE_GREY_DARK
          : AppStyles.COLOR_LITE_GREY_LIGHT,
      thickness: 4,
    );
  }

  Widget buildSection(
      List<Widget> children, bool isDividerVisible, bool isPaddingEnabled) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: isPaddingEnabled
              ? EdgeInsets.symmetric(
                  vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
                  horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL)
              : EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
        if (isDividerVisible)
          Divider(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppStyles.COLOR_LITE_GREY_DARK
                : AppStyles.COLOR_LITE_GREY_LIGHT,
            thickness: 4,
          ),
      ],
    );
  }

  Widget buildLabel(String text, Color color) {
    return Container(
      width: 70,
      height: 20,
      padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 8),
        ),
      ),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
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

  void addToCart(WooCartData wooCartData) async {
    BlocProvider.of<DetailScreenBloc>(context).add(AddToCart(wooCartData));
  }

  void addToCartGrouped(List<WooCartData> wooCartData) async {
    BlocProvider.of<DetailScreenBloc>(context)
        .add(AddToCartGrouped(wooCartData));
  }
}

/*
class RelatedProducts extends StatelessWidget {
  const RelatedProducts({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: AppStyles.SCREEN_MARGIN_VERTICAL),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppStyles.GRID_SPACING,
        mainAxisSpacing: AppStyles.GRID_SPACING,
        childAspectRatio: 0.75,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
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
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://i.pinimg.com/originals/66/f1/6e/66f16eee76fa106a4cc160cbf6a58611.jpg",
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "This is large text title for product. This is large text title for product. ",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "\$1200.00",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "\$1200.00",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(
                                                decoration:
                                                    TextDecoration.lineThrough),
                                      ),
                                    ],
                                  ),
                                )
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 8)),
                            )),
                        Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Center(
                              child: IconTheme(
                                  data: IconThemeData(color: Colors.white),
                                  child: Icon(
                                    Icons.favorite_border,
                                    size: 18,
                                  )),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
*/

typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback? onRatingChanged;
  final Color? color;

  StarRating(
      {this.starCount = 5, this.rating = .0, this.onRatingChanged, this.color});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = new Icon(
        Icons.star_border,
        // ignore: deprecated_member_use
        color: Theme.of(context).buttonColor,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = new Icon(
        Icons.star_half,
        color: color ?? Theme.of(context).primaryColor,
      );
    } else {
      icon = new Icon(
        Icons.star,
        color: color ?? Theme.of(context).primaryColor,
      );
    }
    return new InkResponse(
      onTap:
          onRatingChanged == null ? null : () => onRatingChanged!(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
        mainAxisSize: MainAxisSize.min,
        children:
            new List.generate(starCount, (index) => buildStar(context, index)));
  }
}

// ignore: must_be_immutable
class BottomSheetContent extends StatefulWidget {
  WooProduct? tempProduct;
  List<WooVariationsResponse>? allProductVariationsList;
  Function(WooVariationsResponse? selectedVariation,
      String variationSelectionText, int quantity)? onVariationSelected;

  BottomSheetContent(
      {this.tempProduct,
      this.allProductVariationsList,
      this.onVariationSelected});

  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class OptionObj {
  String? name;
  bool enabled;

  OptionObj(this.name, this.enabled);
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  List<WooProductAttributes>? productAttributesList = [];
  Map<String?, List<OptionObj>> attributeNames =
      Map<String?, List<OptionObj>>();
  Map<String?, String> selectedOptions = Map<String?, String>();
  WooVariationsResponse? selectedVariation;
  ProductCombination? selectedCombination;
  String selectionText = "";
  List<String> selectedVariations = [];
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    productAttributesList = widget.tempProduct!.attributes;

/*
    attributeNames["color"] = ["Gray", "Maroon", "Sky Blue"];
    attributeNames["Size"] = ["Large", "Medium", "Small"];
    attributeNames["quality"] = ["A", "B", "C"];
*/

    for (int i = 0; i < productAttributesList!.length; i++) {
      List<OptionObj> temp = [];
      productAttributesList![i].options!.forEach((element) {
        temp.add(OptionObj(element, true));
      });
      attributeNames[productAttributesList![i].name] = temp;
    }

    String tmp = "";

    attributeNames.forEach((key, value) {
      tmp += "   ---" + key.toString() + " = ";
      value.forEach((element) {
        tmp += element.enabled.toString();
      });
    });

    print(tmp);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
        color: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).scaffoldBackgroundColor
            : Color(0xffF6F6F6),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL,
          vertical: AppStyles.SCREEN_MARGIN_VERTICAL),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Center(
              child: Container(
            width: 70,
            height: 4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Color(0xffCCCCCC)),
          )),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                width: 80.0,
                height: 80.0,
                child: CachedNetworkImage(
                  imageUrl: (selectedVariation == null)
                      ? widget.tempProduct!.images!.first.src!
                      : selectedVariation!.image!.src!,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress)),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(
                width: 12.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    /*AppData.currency.code +*/
                    double.tryParse((double.tryParse(selectedVariation == null
                                    ? widget.tempProduct!.price!
                                    : selectedVariation!.price!)! *
                                quantity)
                            .toString())!
                        .toStringAsFixed(2),
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: "Selection:  ",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextSpan(
                        text: selectionText,
                        style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppStyles.COLOR_GREY_DARK
                                    : AppStyles.COLOR_GREY_LIGHT)),
                  ])),
                ],
              )
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: attributeNames.keys.length,
            itemBuilder: (context, index) {
              //WooProductAttributes productAttribute = attributesList[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(attributeNames.keys.toList()[index]!),
                  SizedBox(
                    height: 12.0,
                  ),
                  ChoiceChips(
                    chipName:
                        attributeNames[attributeNames.keys.toList()[index]],
                    choiceChipsCallback: (option) {
                      optionSelected(
                          attributeNames.keys.toList()[index], option!, index);
                    },
                  ),
                ],
              );
            },
          ),
          SizedBox(
            height: 16.0,
          ),
          Text("Quantity"),
          SizedBox(
            height: 12.0,
          ),
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 24,
                  width: 24,
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        if (quantity > 1) quantity--;
                      });
                    },
                    color: Colors.grey,
                    textColor: Colors.white,
                    child: Text(
                      "-",
                      style: TextStyle(fontSize: 20),
                    ),
                    padding: EdgeInsets.only(bottom: 3),
                    shape: CircleBorder(),
                  ),
                ),
                // IconButton(
                //     icon: Icon(Icons.chevron_left),
                //     onPressed: () {
                //       setState(() {
                //         if (quantity > 1) quantity--;
                //       });
                //     }),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22.0),
                    child: Text(
                      quantity.toString(),
                      style: Theme.of(context).textTheme.titleMedium,
                    )),
                // IconButton(
                //     icon: Icon(Icons.chevron_right),
                //     onPressed: () {
                //       setState(() {
                //         quantity++;
                //       });
                //     }),
                Container(
                  height: 24,
                  width: 24,
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: Text(
                      "+",
                      style: TextStyle(fontSize: 20),
                    ),
                    padding: EdgeInsets.only(bottom: 3),
                    shape: CircleBorder(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: AppStyles.SCREEN_MARGIN_VERTICAL),
            height: 45.0,
            width: double.maxFinite,
            child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ))),
                onPressed: () {
                  selectedOptions.clear();
                  attributeNames.clear();
                  for (int i = 0; i < productAttributesList!.length; i++) {
                    List<OptionObj> temp = [];
                    productAttributesList![i].options!.forEach((element) {
                      temp.add(OptionObj(element, true));
                    });
                    attributeNames[productAttributesList![i].name] = temp;
                  }

                  setState(() {});
                },
                child: Text("Clear")),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: AppStyles.SCREEN_MARGIN_VERTICAL),
            height: 45.0,
            width: double.maxFinite,
            child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ))),
                onPressed: () {
                  widget.onVariationSelected!(
                      selectedVariation, selectionText, quantity);
                },
                child: Text("Continue")),
          ),
        ],
      ),
    );
  }

  void optionSelected(
      String? selectedAttributeName, String selectedOption, int index) {
    selectedOptions[selectedAttributeName] = selectedOption;
    List<WooVariationsResponse> filteredVariations = [];
    List<WooVariationsResponse> filteredAnyVariations = [];

    //filterVariations
    for (int j = 0; j < widget.allProductVariationsList!.length; j++) {
      int count = 0;
      for (int k = 0;
          k < widget.allProductVariationsList![j].attributes!.length;
          k++) {
        for (int i = 0; i < selectedOptions.length; i++) {
          if (selectedOptions.keys.toList()[i] ==
                  widget.allProductVariationsList![j].attributes![k].name &&
              selectedOptions[selectedOptions.keys.toList()[i]] ==
                  widget.allProductVariationsList![j].attributes![k].option) {
            count++;
          }
        }
        if (count == selectedOptions.length) {
          filteredVariations.add(widget.allProductVariationsList![j]);
          if (widget.allProductVariationsList![j].attributes!.length !=
              widget.tempProduct!.attributes!.length) {
            filteredAnyVariations.add(widget.allProductVariationsList![j]);
          }
          break;
        }
      }
    }
    // List<WooVariationsResponse> filteredTempAnyVariations = [];
    for (int i = 0; i < selectedOptions.length; i++) {
      for (int j = 0; j < widget.allProductVariationsList!.length; j++) {
        if (widget.allProductVariationsList![j].attributes!.length !=
            widget.tempProduct!.attributes!.length) {
          bool found = true;
          for (int k = 0;
              k < widget.allProductVariationsList![j].attributes!.length;
              k++) {
            if (selectedOptions.keys.toList()[i] ==
                widget.allProductVariationsList![j].attributes![k].name) {
              found = false;
              break;
            }
          }
          if (found) {
            filteredVariations.add(widget.allProductVariationsList![j]);
          }
        }
      }
    }

    // find variation combination
    if (selectedOptions.length == widget.tempProduct!.attributes!.length) {
      for (int i = 0; i < widget.allProductVariationsList!.length; i++) {
        bool found = true;
        for (int j = 0;
            j < widget.allProductVariationsList![i].attributes!.length;
            j++) {
          if (selectedOptions[
                  widget.allProductVariationsList![i].attributes![j].name] !=
              widget.allProductVariationsList![i].attributes![j].option) {
            found = false;
            break;
          }
        }
        if (found) {
          selectedVariation = widget.allProductVariationsList![i];
          break;
        }
      }
      if (selectedVariation != null) print(selectedVariation!.id.toString());
    }
    if (filteredAnyVariations.isNotEmpty) {
      for (int i = 0; i < filteredAnyVariations.length; i++) {
        bool found = true;
        for (int j = 0; j < filteredAnyVariations[i].attributes!.length; j++) {
          if (selectedOptions[filteredAnyVariations[i].attributes![j].name] !=
              filteredAnyVariations[i].attributes![j].option) {
            found = false;
          }
        }
        if (found) {
          selectedVariation = filteredAnyVariations[i];
          break;
        }
      }
    }

    Map<String?, List<String?>?> filteredAttributeNames =
        Map<String?, List<String?>?>();
    for (int i = 0; i < filteredVariations.length; i++) {
      for (int j = 0; j < filteredVariations[i].attributes!.length; j++) {
        if (selectedAttributeName !=
            filteredVariations[i].attributes![j].name) {
          if (filteredAttributeNames[
                  filteredVariations[i].attributes![j].name] ==
              null)
            filteredAttributeNames[filteredVariations[i].attributes![j].name] =
                [];
          if (!filteredAttributeNames[
                  filteredVariations[i].attributes![j].name]!
              .contains(filteredVariations[i].attributes![j].option))
            filteredAttributeNames[filteredVariations[i].attributes![j].name]!
                .add(filteredVariations[i].attributes![j].option);
        }
      }
    }
    if (filteredAnyVariations.isNotEmpty) {
      List<WooProductAttributes> tempAttributes = [];
      for (int i = 0; i < filteredAnyVariations.length; i++) {
        for (int j = 0; j < widget.tempProduct!.attributes!.length; j++) {
          for (int k = 0;
              k < filteredAnyVariations[i].attributes!.length;
              k++) {
            if (filteredAnyVariations[i].attributes![k].name !=
                widget.tempProduct!.attributes![j].name) {
              tempAttributes.add(widget.tempProduct!.attributes![j]);
            }
          }
        }
      }

      for (int i = 0; i < tempAttributes.length; i++) {
        filteredAttributeNames[tempAttributes[i].name] =
            tempAttributes[i].options;
      }
    }

    for (int i = 0; i < attributeNames.keys.toList().length; i++) {
      for (int j = 0;
          j < attributeNames[attributeNames.keys.toList()[i]]!.length;
          j++) {
        if (filteredAttributeNames[attributeNames.keys.toList()[i]] != null) {
          if (!filteredAttributeNames[attributeNames.keys.toList()[i]]!
              .contains(
                  attributeNames[attributeNames.keys.toList()[i]]![j].name)) {
            attributeNames[attributeNames.keys.toList()[i]]![j].enabled = false;
          } else {
            attributeNames[attributeNames.keys.toList()[i]]![j].enabled = true;
          }
        }
      }
    }

/*
    String tmp ="";

    attributeNames.forEach((key, value) {
      tmp += "   ---" + key.toString() +" = ";
      value.forEach((element) {
        tmp += element.enabled.toString();
      });
    });

    print(tmp);
*/
    selectionText = "";
    for (int i = 0; i < selectedOptions.length; i++) {
      selectionText += selectedOptions[selectedOptions.keys.toList()[i]]!;
      if (i + 1 != selectedOptions.length) {
        selectionText += ", ";
      }
    }
    setState(() {});
  }
}

typedef void ChoiceChipsCallback(String? option);

class ChoiceChips extends StatefulWidget {
  List<OptionObj>? chipName;
  ChoiceChipsCallback? choiceChipsCallback;

  ChoiceChips({this.chipName, this.choiceChipsCallback});

  @override
  _ChoiceChipsState createState() => _ChoiceChipsState();
}

class _ChoiceChipsState extends State<ChoiceChips> {
  String? _selected = "";

  @override
  void initState() {
    super.initState();
    //_selected = widget.chipName.first;
  }

  _buildChoiceList() {
    List<Widget> choices = [];
    widget.chipName!.forEach((item) {
      choices.add(Container(
        child: FilterChip(
          checkmarkColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.transparent,
          label: Text(item.name!),
          labelStyle: TextStyle(
              color: _selected == item.name
                  ? Theme.of(context).primaryColor
                  : (item.enabled)
                      ? (Theme.of(context).brightness == Brightness.dark
                          ? AppStyles.COLOR_GREY_DARK
                          : AppStyles.COLOR_GREY_LIGHT)
                      : Colors.black26),
          // shape: RoundedRectangleBorder(
          //   side: BorderSide(
          //       color: _selected == item.productVariation.detail.first.name
          //           ? Colors.transparent
          //           : Theme.of(context).brightness == Brightness.dark
          //               ? AppStyles.COLOR_GREY_DARK
          //               : AppStyles.COLOR_GREY_LIGHT,
          //       width: 1),
          //   borderRadius: BorderRadius.circular(5),
          // ),
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: (item.enabled) ? Colors.black87 : Colors.black26,
                width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          // selectedColor: Theme.of(context).primaryColor,
          selectedColor: Colors.transparent,
          selected: _selected == item.name,
          onSelected: (selected) {
            if (item.enabled) {
              setState(() {
                _selected = item.name;
                widget.choiceChipsCallback!(item.name);
              });
            }
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5.0,
      runSpacing: 3.0,
      children: _buildChoiceList(),
    );
  }
}
