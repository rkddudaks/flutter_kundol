import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/wooResponses/woo_cart_data.dart';
import 'package:flutter_kundol/api/wooResponses/woo_checkout_params.dart';
import 'package:flutter_kundol/api/wooResponses/woo_coupon.dart';
import 'package:flutter_kundol/blocs/add_address/add_address_bloc.dart';
// import 'package:flutter_kundol/blocs/address/address_bloc.dart';
import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
import 'package:flutter_kundol/blocs/checkout/checkout_bloc.dart';
import 'package:flutter_kundol/blocs/countries/countries_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
// import 'package:flutter_kundol/models/coupon_data.dart';
import 'package:flutter_kundol/repos/address_repo.dart';
import 'package:flutter_kundol/repos/checkout_repo.dart';
import 'package:flutter_kundol/repos/countriesRepo.dart';
import 'package:flutter_kundol/tweaks/app_localization.dart';
import 'package:flutter_kundol/ui/checkout_screen.dart';
// import 'package:flutter_kundol/ui/shipping_screen.dart';
// import 'package:flutter_kundol/ui/widgets/app_bar.dart';
import 'package:flutter_kundol/ui/widgets/dialog_utils.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:hive/hive.dart';
// import 'package:intl/intl.dart';

import 'add_address_screen.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController _couponTextController = TextEditingController();
  List<WooCartData?> cartData = [];
  List<int?> pIds = [];
  List<WooCoupon> couponData = [];

  double subtotal = 0;
  double shipping = 0;
  double discount = 0;
  double tax = 0;
  double orderTotal = 0;

  @override
  void initState() {
    super.initState();
    cartData = AppData.cartItems;

    pIds = [];

    for (WooCartData? data in cartData) {
      print("PRintwoocartdata");
      print(data!.productData!.price);
      pIds.add(data.productData!.id);
    }

    BlocProvider.of<CartBloc>(context).add(GetCart(pIds));
  }

  @override
  Widget build(BuildContext context) {
    subtotal = 0;
    shipping = 0;
    discount = 0;
    tax = 0;
    orderTotal = 0;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).scaffoldBackgroundColor
          : Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).cardColor,
        title: Text(AppLocalizations.of(context)!.translate('cart')!,
            style: Theme.of(context).textTheme.titleLarge),
        elevation: 0.0,
      ),
      body: BlocConsumer(
        listener: (context, dynamic state) {
          if (state is CartError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error!)));
          } else if (state is CartCouponError) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
            BlocProvider.of<CartBloc>(context).add(GetCart(pIds));
          } else if (state is CartDeleted) {
            setState(() {
              cartData = AppData.cartItems;
              pIds.clear();
              for (WooCartData? data in cartData) {
                pIds.add(data!.productData!.id);
              }
            });
            //BlocProvider.of<CartBloc>(context).add(GetCart(pIds));
          } else if (state is CouponApplied) {
            Navigator.pop(context);
            if (!checkIfAlreadyApplied(state.couponData.first)) {
              if (validateCoupon(state.couponData.first)) {
                couponData.add(state.couponData.first);
                BlocProvider.of<CartBloc>(context).add(GetCart(pIds));
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Coupon Added Successfully")));
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Coupon already applied")));
            }
          }
        },
        bloc: BlocProvider.of<CartBloc>(context),
        builder: (context, dynamic state) {
          if (state is CartLoaded ||
              state is CartDeleted ||
              state is CouponApplied) {
            if (state.cartItems.isNotEmpty) {
              subtotal = 0;
              shipping = 0;
              tax = 0;
              orderTotal = 0;
              for (int i = 0; i < state.cartItems.length; i++) {
                subtotal += (double.parse(
                        state.cartItems[i].productData.price.toString()) *
                    state.cartItems[i].quantity);
                shipping = 0;
                tax = 0;
                orderTotal = subtotal;
              }
              applyCoupon();
/*
              if (couponData != null) if (couponData.discountType ==
                  AppConstants.COUPON_TYPE_FIXED) {
                discount = double.parse(couponData.amount.toString());
              } else if (couponData.discountType ==
                  AppConstants.COUPON_TYPE_PERCENTAGE) {
                discount = (double.parse(couponData.amount.toString()) / 100) *
                    subtotal;
              }
              else if (couponData.discountType == AppConstants.COUPON_FIXED_PRODUCT) {
                discount = double.parse(couponData.amount.toString());
              }
*/
              orderTotal = orderTotal - discount;
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
                            horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                        child: Column(
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              itemCount: state.cartItems.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) =>
                                  Container(
                                child: Row(
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 70,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            AppStyles.CARD_RADIUS),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "http://via.placeholder.com/350x150",
                                          //  state.cartItems[index]
                                          //     .productData.images.first.src,
                                          fit: BoxFit.cover,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress)),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      width: double.maxFinite,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.cartItems[index].productData
                                                .name,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            softWrap: false,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily:
                                                    "MontserratSemiBold"),
                                          ),
                                          Html(
                                            data: state.cartItems[index]
                                                .productData.priceHtml,
                                            style: {
                                              "body": Style(
                                                margin: EdgeInsets.zero,
                                                padding: EdgeInsets.zero,
                                                fontSize: FontSize(11.0),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            },
                                          ),
/*
                                                  Text(
                                                    AppData.currency.code +
                                                        double.tryParse(state
                                                            .cartItems[index].price
                                                            .toString())
                                                            .toStringAsFixed(2),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                  ),
*/
                                          SizedBox(height: 8.0),
                                          RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                              text: AppLocalizations.of(
                                                          context)!
                                                      .translate('category')! +
                                                  ": ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(fontSize: 11),
                                            ),
                                            TextSpan(
                                                text: state
                                                    .cartItems[index]
                                                    .productData
                                                    .categories
                                                    .first
                                                    .name,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                                .brightness ==
                                                            Brightness.dark
                                                        ? AppStyles
                                                            .COLOR_GREY_DARK
                                                        : AppStyles
                                                            .COLOR_GREY_LIGHT,
                                                    fontSize: 11)),
                                          ])),
                                          RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                              text: AppLocalizations.of(
                                                          context)!
                                                      .translate('quantity')! +
                                                  ": ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(fontSize: 11),
                                            ),
                                            TextSpan(
                                                text: state
                                                    .cartItems[index].quantity
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                                .brightness ==
                                                            Brightness.dark
                                                        ? AppStyles
                                                            .COLOR_GREY_DARK
                                                        : AppStyles
                                                            .COLOR_GREY_LIGHT,
                                                    fontSize: 11)),
                                          ])),
                                        ],
                                      ),
                                    )),
                                    Container(
                                      child: IconButton(
                                        icon: SvgPicture.asset(
                                            "assets/icons/ic_delete.svg",
                                            fit: BoxFit.none),
                                        onPressed: () async {
                                          BlocProvider.of<CartBloc>(context)
                                              .add(DeleteCartItem(
                                                  state.cartItems[index]
                                                      .productData.id,
                                                  cartData[index]!
                                                              .selectedVariation ==
                                                          null
                                                      ? null
                                                      : cartData[index]!
                                                          .selectedVariation!
                                                          .id));
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(height: 15);
                              },
                            ),
                            SizedBox(height: 10),
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(AppStyles.CARD_RADIUS),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey),
                                ),
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .translate(
                                                      'promo_code_vouchers')!),
                                        ),
                                        Icon(Icons.arrow_drop_down_sharp),
                                      ],
                                    ),
                                    SizedBox(height: 10.0),
                                    Container(
                                      padding:
                                          EdgeInsets.only(bottom: 4, left: 12),
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey,
                                            width: 1.0), // set border width
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                10.0)), // set rounded corner radius
                                      ),
                                      child: TextField(
                                        controller: _couponTextController,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: AppLocalizations.of(
                                                  context)!
                                              .translate('coupon_code_hint'),
                                          hintStyle: TextStyle(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? AppStyles.COLOR_GREY_DARK
                                                  : AppStyles.COLOR_GREY_LIGHT,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: Row(
                                        children: [
                                          if (discount != 0)
                                            Expanded(
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _couponTextController
                                                          .clear();
                                                      discount = 0.0;
                                                    });
                                                  },
                                                  child: Text(AppLocalizations
                                                          .of(context)!
                                                      .translate('remove')!)),
                                            ),
                                          Expanded(
                                            child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Theme.of(
                                                                      context)
                                                                  .brightness ==
                                                              Brightness.dark
                                                          ? Theme.of(context)
                                                              .cardColor
                                                          : Color(0xffCDD2D3)),
                                                ),
                                                onPressed: () {
                                                  if (_couponTextController.text
                                                      .toString()
                                                      .trim()
                                                      .isNotEmpty) {
                                                    DialogUtils
                                                        .showLoaderDialog(
                                                            context);
                                                    BlocProvider.of<CartBloc>(
                                                            context)
                                                        .add(ApplyCoupon(
                                                            _couponTextController
                                                                .text
                                                                .toString()
                                                                .trim()));
                                                  }
                                                },
                                                child: Text(AppLocalizations.of(
                                                        context)!
                                                    .translate('apply')!)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: couponData.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(couponData[index].code!),
                                          subtitle: Text(
                                              couponData[index].discountType!),
                                          trailing: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  couponData.removeAt(index);
                                                });
                                              },
                                              icon: Icon(
                                                  Icons.remove_circle_outline)),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(AppStyles.CARD_RADIUS),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor),
                                ),
                                padding: EdgeInsets.fromLTRB(12, 15, 12, 15),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(AppLocalizations.of(context)!
                                                .translate('subtotal')! +
                                            ": "),
                                        Text(/*AppData.currency.code +*/
                                            subtotal.toStringAsFixed(2)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(AppLocalizations.of(context)!
                                                .translate('welcome_back')! +
                                            ": "),
                                        Text(/*AppData.currency.code +*/
                                            "0.00"),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(AppLocalizations.of(context)!
                                                .translate('tax')! +
                                            ": "),
                                        Text(/*AppData.currency.code +*/
                                            "0.00"),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(AppLocalizations.of(context)!
                                                .translate('discount')! +
                                            ": "),
                                        Text(/*AppData.currency.code +*/
                                            discount.toStringAsFixed(2)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(AppLocalizations.of(context)!
                                                .translate('order_total')! +
                                            ": "),
                                        Text(
                                          /*AppData.currency.code +*/
                                          orderTotal.toStringAsFixed(2),
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
                        horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                    width: double.maxFinite,
                    height: 40.0,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ))),
                        onPressed: () {
                          if (AppData.settingsResponse.onePageCheckout ==
                              AppConstants.CHECKOUT_TYPE_ONE_PAGE) {
                            WooCheckoutParams objectParams =
                                new WooCheckoutParams();

                            objectParams.customerId = AppData.wooUser!.id;
                            objectParams.token = AppData.wooUser!.cookie;
                            List<CheckoutProducts> products = [];
                            cartData.forEach((element) {
                              CheckoutProducts checkoutProduct =
                                  new CheckoutProducts();
                              checkoutProduct.productId =
                                  element!.productData!.id;
                              checkoutProduct.total =
                                  (double.parse(element.productData!.price!) *
                                          element.quantity!)
                                      .toString();
                              checkoutProduct.price =
                                  element.productData!.price;
                              checkoutProduct.quantity = element.quantity;
                              products.add(checkoutProduct);
                            });
                            objectParams.products = products;
                            objectParams.onePage = AppData
                                .settingsResponse.onePageCheckout
                                .toString();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                      create: (BuildContext context) {
                                        return CheckoutBloc(RealCheckoutRepo());
                                      },
                                      child: CheckoutScreen(cartData,
                                          couponData, null, null, null, true))),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MultiBlocProvider(
                                          providers: [
                                            BlocProvider(
                                                create: (BuildContext context) {
                                              return AddAddressBloc(
                                                  RealAddressRepo());
                                            }),
                                            BlocProvider(
                                                create: (context) =>
                                                    CountriesBloc(
                                                        RealCountriesRepo())),
                                          ],
                                          child: AddAddressScreen(
                                              cartData, couponData))),
                            );
/*
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                      create: (BuildContext context) {
                                        return AddressBloc(RealAddressRepo())
                                          ..add(GetAddress());
                                      },
                                      child:
                                          ShippingScreen(cartData, couponData)),
                                ));
*/
                          }
                        },
                        child: Text(AppLocalizations.of(context)!
                            .translate('proceed_to_checkout')!)),
                  ),
                ],
              );
            } else {
              return Center(child: Text("Empty"));
            }
          } else if (state is CartLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
    );
  }

  bool validateCoupon(WooCoupon coupon) {
    int user_used_this_coupon_counter = 0;

    bool user_usage_limit_exceeds = false; // false
    bool coupon_usage_limit_exceeds = false; // false
    bool items_limit_exceeds_to_usage = false; // false

    bool user_email_valid_for_coupon = false; // true

    bool any_valid_item_in_cart = false; // true
    bool any_valid_category_item_in_cart = false; // true

    bool all_sale_items_in_cart = true; // false
    bool all_excluded_items_in_cart = true; // false
    bool all_excluded_category_items_in_cart = true; // false

/*
    for (int i = 0; i < coupon.usedBy.length; i++) {
      if (!"".equalsIgnoreCase(customerID)) if (coupon.usedBy
          .contains(customerID)) user_used_this_coupon_counter += 1;
    }
*/

    if (coupon.usageLimitPerUser != null) if (coupon.usageLimitPerUser != 0 &&
        user_used_this_coupon_counter >= coupon.usageLimitPerUser!) {
      user_usage_limit_exceeds = true;
    }

    if (coupon.usageLimit != null) if (coupon.usageLimit != 0 &&
        coupon.usageCount! >= coupon.usageLimit!) {
      coupon_usage_limit_exceeds = true;
    }

    if (coupon.limitUsageToXItems != null) if (coupon.limitUsageToXItems != 0 &&
        cartData.length > coupon.limitUsageToXItems!) {
      items_limit_exceeds_to_usage = true;
    }

/*    if (coupon.emailRestrictions.length > 0 &&
        !"".equalsIgnoreCase(customerEmailAddress)) {
      if (isStringExistsInList(
          customerEmailAddress, coupon.emailRestrictions)) {
        user_email_valid_for_coupon = true;
      }
    } else {
      user_email_valid_for_coupon = true;
    }*/
    user_email_valid_for_coupon = true;
    for (int i = 0; i < cartData.length; i++) {
      bool isValidProduct = true;
      bool isExcludedOnSale = false;
      bool isExcludedProduct = true;
      bool anyValidCategory = false;
      bool anyExcludedCategory = true;

      int? productID = cartData[i]!.productData!.id;
      List<int?> categoryIDsList = [];
      if (cartData[i]!.productData!.categories != null &&
          cartData[i]!.productData!.categories!.isNotEmpty) {
        cartData[i]!.productData!.categories!.forEach((element) {
          categoryIDsList.add(element.id);
        });
      }

      if (coupon.excludeSaleItems!) {
        if (!cartData[i]!.productData!.onSale!) {
          all_sale_items_in_cart = false;
        } else {
          isExcludedOnSale = true;
        }
      } else {
        all_sale_items_in_cart = false;
      }

      if (coupon.productIds!.length > 0) {
        if (coupon.productIds!.contains(productID)) {
          any_valid_item_in_cart = true;
        } else {
          isValidProduct = false;
        }
      } else {
        any_valid_item_in_cart = true;
      }

      if (coupon.productCategories!.length > 0 && categoryIDsList.length > 0) {
        for (int y = 0; y < categoryIDsList.length; y++) {
          if (coupon.productCategories!.contains(categoryIDsList[y])) {
            anyValidCategory = true;
            any_valid_category_item_in_cart = true;
          }
        }
      } else {
        anyValidCategory = true;
        any_valid_category_item_in_cart = true;
      }

      if (coupon.excludedProductIds!.length > 0) {
        if (!coupon.excludedProductIds!.contains(productID)) {
          isExcludedProduct = false;
          all_excluded_items_in_cart = false;
        }
      } else {
        isExcludedProduct = false;
        all_excluded_items_in_cart = false;
      }

      if (coupon.excludedProductCategories!.length > 0 &&
          categoryIDsList.length > 0) {
        for (int y = 0; y < categoryIDsList.length; y++) {
          if (!coupon.excludedProductCategories!.contains(categoryIDsList[y])) {
            anyExcludedCategory = false;
            all_excluded_category_items_in_cart = false;
          }
        }
      } else {
        anyExcludedCategory = false;
        all_excluded_category_items_in_cart = false;
      }

      if (!isExcludedOnSale &&
          !isExcludedProduct &&
          !anyExcludedCategory &&
          isValidProduct &&
          anyValidCategory) {
        cartData[i]!.isProductValidForCoupon = true;
      } else {
        cartData[i]!.isProductValidForCoupon = false;
      }
    }

    final now = DateTime.now();
    bool isExpired = false;
    if (coupon.dateExpires != null) {
      final expirationDate = DateTime.parse(coupon.dateExpires!
          .replaceAllMapped(RegExp(r'-\d\d:\d\d'), (match) => ""));
      isExpired = expirationDate.isBefore(now);
    }
    if (!isExpired) {
      if (!coupon_usage_limit_exceeds) {
        if (!user_usage_limit_exceeds) {
          if (user_email_valid_for_coupon) {
            if (double.parse(coupon.minimumAmount!) <= subtotal) {
              if (double.parse(coupon.maximumAmount!) == 0.0 ||
                  subtotal <= double.parse(coupon.maximumAmount!)) {
                if (!items_limit_exceeds_to_usage) {
                  if (!all_sale_items_in_cart) {
                    if (!all_excluded_category_items_in_cart) {
                      if (!all_excluded_items_in_cart) {
                        if (any_valid_category_item_in_cart) {
                          if (any_valid_item_in_cart) {
                            return true;
                          } else {
                            showSnackBarForCoupon(
                                "Coupon is not valid for these products!");
                            return false;
                          }
                        } else {
                          showSnackBarForCoupon(
                              "Coupon is not valid for these category of products!");
                          return false;
                        }
                      } else {
                        showSnackBarForCoupon(
                            "Coupon cannot be used on excluded products!");
                        return false;
                      }
                    } else {
                      showSnackBarForCoupon(
                          "Coupon cannot be used on excluded categories!");
                      return false;
                    }
                  } else {
                    showSnackBarForCoupon(
                        "Coupon cannot be used on sale items!");
                    return false;
                  }
                } else {
                  showSnackBarForCoupon(
                      "Coupon cannot be used on too many products!");
                  return false;
                }
              } else {
                showSnackBarForCoupon(
                    "Cart total does not meet the maximum amount for Coupon!");
                return false;
              }
            } else {
              showSnackBarForCoupon(
                  "Cart total does not meet the minimum amount for Coupon!");
              return false;
            }
          }
          // else {
          //   showSnackBarForCoupon("You are not applicable to use this Coupon!");
          //   return false;
          // }
        } else {
          showSnackBarForCoupon("You have already used this Coupon!");
          return false;
        }
      } else {
        showSnackBarForCoupon("Coupon has been used by limited users!");
        return false;
      }
    } else {
      showSnackBarForCoupon("Coupon is expired!");
      return false;
    }
  }

  bool isStringExistsInList(String str, List<String> stringList) {
    bool isExists = false;

    for (int i = 0; i < stringList.length; i++) {
      if (stringList[i] == str) {
        isExists = true;
      }
    }

    return isExists;
  }

  void showSnackBarForCoupon(String string) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(string)));
  }

  void applyCoupon() {
    discount = 0;
    couponData.forEach((coupon) {
      int validItemsCount = 0;
      double couponDiscount = 0.0;

      if (coupon.discountType == AppConstants.COUPON_TYPE_FIXED_PRODUCT) {
        for (int i = 0; i < cartData.length; i++) {
          if (cartData[i]!.isProductValidForCoupon!) {
            validItemsCount += cartData[i]!.quantity!;
            couponDiscount += (double.parse(coupon.amount!) * validItemsCount);
          }
        }
      } else if (coupon.discountType == AppConstants.COUPON_TYPE_FIXED_CART) {
        couponDiscount = double.parse(coupon.amount!);

        for (int i = 0; i < cartData.length; i++) {
          if (cartData[i]!.isProductValidForCoupon!) {
            validItemsCount += cartData[i]!.quantity!;
          }
        }
      } else if (coupon.discountType == AppConstants.COUPON_TYPE_PERCENTAGE) {
        couponDiscount = (subtotal * double.parse(coupon.amount!)) / 100;

        for (int i = 0; i < cartData.length; i++) {
          if (cartData[i]!.isProductValidForCoupon!) {
            validItemsCount += cartData[i]!.quantity!;
          }
        }
      }

      if ((couponDiscount >= subtotal)) {
        showSnackBarForCoupon("Coupon cannot be applied!");
      } else {
        double productDiscount = couponDiscount / validItemsCount;

        for (int i = 0; i < cartData.length; i++) {
          if (cartData[i]!.isProductValidForCoupon!) {
            if (0 >
                double.parse(cartData[i]!.productData!.price!) -
                    productDiscount) {
              cartData[i]!.isProductValidForCoupon = false;
              validItemsCount -= cartData[i]!.quantity!;
            }
          }
        }

        for (int i = 0; i < cartData.length; i++) {
          if (cartData[i]!.isProductValidForCoupon!) {
            coupon.validItems.add(cartData[i]!.productData!.id);
          }
        }

        if (validItemsCount > 0) {
          coupon.validItemsCount = validItemsCount;
          coupon.discount = couponDiscount.toString();

          discount += couponDiscount;
        } else {
          showSnackBarForCoupon("Coupon cannot be applied!");
        }
      }
    });
  }

  bool checkIfAlreadyApplied(WooCoupon couponEntered) {
    bool result = false;
    couponData.forEach((coupon) {
      if (coupon.id == couponEntered.id) result = true;
    });
    return result;
  }
}
