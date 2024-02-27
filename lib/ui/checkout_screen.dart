import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/wooResponses/WooPaymentMethod.dart';
import 'package:flutter_kundol/api/wooResponses/woo_cart_data.dart';
import 'package:flutter_kundol/api/wooResponses/woo_checkout_params.dart';
import 'package:flutter_kundol/api/wooResponses/woo_coupon.dart';
import 'package:flutter_kundol/api/wooResponses/woo_shipping_method.dart';
import 'package:flutter_kundol/api/wooResponses/woo_user_billing.dart';
import 'package:flutter_kundol/api/wooResponses/woo_user_shipping.dart';
// import 'package:flutter_kundol/blocs/address/address_bloc.dart';
// import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
import 'package:flutter_kundol/blocs/checkout/checkout_bloc.dart';
import 'package:flutter_kundol/constants/app_config.dart';
// import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/address_data.dart';
// import 'package:flutter_kundol/models/cart_data.dart';
// import 'package:flutter_kundol/models/coupon_data.dart';
// import 'package:flutter_kundol/models/payment_method.dart';
import 'package:flutter_kundol/tweaks/app_localization.dart';
import 'package:flutter_kundol/ui/thank_you_screen.dart';
// import 'package:flutter_kundol/ui/widgets/app_bar.dart';
import 'package:flutter_kundol/ui/widgets/dialog_utils.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckoutScreen extends StatefulWidget {
  final List<WooCartData?> cartItems;
  final List<WooCoupon> couponData;
  final AddressData? addressData;
  final WooPaymentMethod? paymentMethod;
  final WooShippingMethod? shippingMethod;
  final bool isWebRedirect;

  CheckoutScreen(this.cartItems, this.couponData, this.addressData,
      this.shippingMethod, this.paymentMethod, this.isWebRedirect);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<CheckoutScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.isWebRedirect) {
      placerOrder();
    }
  }

  @override
  Widget build(BuildContext context) {
    double subtotal = 0;
    // double shipping = 0;
    double discount = 0;
    // double tax = 0;
    double orderTotal = 0;

    for (int i = 0; i < widget.cartItems.length; i++) {
      subtotal +=
          (double.parse(widget.cartItems[i]!.productData!.price.toString()) *
              widget.cartItems[i]!.quantity!);
      // shipping = 0;
      // tax = 0;
      orderTotal = subtotal;
    }

    /*if (widget.couponData != null) if (widget.couponData.type ==
        AppConstants.COUPON_TYPE_FIXED_CART) {
      discount = double.parse(widget.couponData.amount.toString());
    } else if (widget.couponData.type == AppConstants.COUPON_TYPE_PERCENTAGE) {
      discount =
          (double.parse(widget.couponData.amount.toString()) / 100) * subtotal;
    }*/
    orderTotal = orderTotal - discount;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).scaffoldBackgroundColor
          : Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).cardColor,
        title: Text(AppLocalizations.of(context)!.translate('checkout')!,
            style: Theme.of(context).textTheme.titleLarge),
        elevation: 0.0,
      ),
      body: BlocListener<CheckoutBloc, CheckoutState>(
        listener: (BuildContext context, state) {
          if (state is CheckoutLoaded) {
            Navigator.pop(context); // dialog
            //Navigator.of(context).popUntil((route) => route.isFirst);
            /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ThankYouScreen()),
            );*/
            showWebViewForPayment(state.orderId);
          } else if (state is CheckoutError) {
            Navigator.pop(context); // dialog
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: (!widget.isWebRedirect)
            ? Column(
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
                              padding: EdgeInsets.only(left: 15, right: 15),
                              itemCount: widget.cartItems.length,
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
                                          imageUrl: widget.cartItems[index]!
                                              .productData!.images!.first.src!,
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
                                      height: 70,
                                      width: double.maxFinite,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.cartItems[index]!
                                                .productData!.name!,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            softWrap: false,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily:
                                                    "MontserratSemiBold"),
                                          ),
                                          Text(
                                            "\$" +
                                                double.tryParse(widget
                                                        .cartItems[index]!
                                                        .productData!
                                                        .price
                                                        .toString())!
                                                    .toStringAsFixed(2),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          /*SizedBox(height: 8.0),
                                          Text(
                                            "1, Black, Large",
                                            style: TextStyle(fontSize: 10),
                                          ),*/
                                          Text(
                                            "Qty: " +
                                                widget
                                                    .cartItems[index]!.quantity
                                                    .toString(),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(height: 15);
                              },
                            ),
                            SizedBox(height: 10.0),
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(AppStyles.CARD_RADIUS),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 1.0), // set border width
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          10.0)), // set rounded corner radius
                                ),
                                child: ListTile(
                                  onLongPress: () {},
                                  enabled: true,
                                  isThreeLine: true,
                                  leading: SvgPicture.asset(
                                      "assets/icons/ic_location.svg",
                                      fit: BoxFit.none),
                                  title: Text(widget.addressData!.firstName! +
                                      " " +
                                      widget.addressData!.lastName!),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(widget.addressData!.address1!),
                                      Text(widget.addressData!.phone!),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(AppStyles.CARD_RADIUS),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 1.0), // set border width
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          10.0)), // set rounded corner radius
                                ),
                                child: ListTile(
                                  onLongPress: () {},
                                  enabled: true,
                                  isThreeLine: true,
                                  leading: SvgPicture.asset(
                                      "assets/icons/ic_card.svg",
                                      fit: BoxFit.none),
                                  title: Text(widget.addressData!.firstName! +
                                      " " +
                                      widget.addressData!.lastName!),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(widget.addressData!.address1!),
                                      Text(widget.addressData!.phone!),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(AppStyles.CARD_RADIUS),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 1.0), // set border width
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          10.0)), // set rounded corner radius
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
                                        Text(
                                            "\$" + subtotal.toStringAsFixed(2)),
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
                                        Text(
                                            "\$" + discount.toStringAsFixed(2)),
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
                                                .translate(
                                                    'estimated_shipping')! +
                                            ": "),
                                        Text("\$" + "0.00"),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Tax:"),
                                        Text("\$" + "0.00"),
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
                                          "\$" + orderTotal.toStringAsFixed(2),
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
                            SizedBox(height: 10.0),
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
                          placerOrder();
                        },
                        child: Text(AppLocalizations.of(context)!
                            .translate('place_order')!)),
                  ),
                ],
              )
            : Container(),
      ),
    );
  }

  void showWebViewForPayment(int? orderId) async {
    String? success = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WebViewExample(orderId)),
    );

    if (success == "Success") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ThankYouScreen()),
      );
    }
  }

  void placerOrder() {
    DialogUtils.showLoaderDialog(context);
    WooCheckoutParams orderCheckout = new WooCheckoutParams();

    // customer info
    orderCheckout.customerId = AppData.wooUser!.id;
    orderCheckout.token = AppData.wooUser!.cookie;

    // cart Products into
    List<CheckoutProducts> products = [];
    widget.cartItems.forEach((element) {
      CheckoutProducts checkoutProduct = new CheckoutProducts();
      checkoutProduct.productId = element!.productData!.id;
      checkoutProduct.total =
          (double.parse(element.productData!.price!) * element.quantity!)
              .toString();
      checkoutProduct.price = element.productData!.price;
      checkoutProduct.quantity = element.quantity;
      products.add(checkoutProduct);
    });
    orderCheckout.products = products;

    // cart coupon info
    if (widget.couponData != null && widget.couponData.isNotEmpty) {
      List<WooCheckoutCoupon> checkoutCoupons = [];

      widget.couponData.forEach((element) {
        WooCheckoutCoupon couponInfo = new WooCheckoutCoupon();
        couponInfo.code = element.code;
        couponInfo.discount = element.discount;
        checkoutCoupons.add(couponInfo);
      });

      orderCheckout.coupons = checkoutCoupons;
    }

    // shipping address
    if (widget.addressData != null) {
      WooUserShipping shippingInfo = new WooUserShipping();
      shippingInfo.firstName = widget.addressData!.firstName;
      shippingInfo.lastName = widget.addressData!.lastName;
      shippingInfo.company = widget.addressData!.company;
      shippingInfo.address1 = widget.addressData!.address1;
      shippingInfo.address2 = widget.addressData!.address2;
      shippingInfo.city = widget.addressData!.city;
      shippingInfo.postcode = widget.addressData!.postcode;
      shippingInfo.country = widget.addressData!.country!.value;
      shippingInfo.state = widget.addressData!.state!.value;
      orderCheckout.shippingInfo = shippingInfo;
    }

    // billing address
    if (widget.addressData != null) {
      WooUserBilling billingInfo = new WooUserBilling();
      billingInfo.firstName = widget.addressData!.firstName;
      billingInfo.lastName = widget.addressData!.lastName;
      billingInfo.company = widget.addressData!.company;
      billingInfo.address1 = widget.addressData!.address1;
      billingInfo.address2 = widget.addressData!.address2;
      billingInfo.city = widget.addressData!.city;
      billingInfo.postcode = widget.addressData!.postcode;
      billingInfo.country = widget.addressData!.country!.value;
      billingInfo.state = widget.addressData!.state!.value;
      billingInfo.email = AppData.wooUser!.email;
      billingInfo.phone = "";
      orderCheckout.billingInfo = billingInfo;
    }

    // shipping method
    if (widget.shippingMethod != null) {
      List<ShippingIds> shippingMethod = [];
      ShippingIds shippingMethodInfo = new ShippingIds();
      shippingMethodInfo.shipId = widget.shippingMethod!.id;
      shippingMethodInfo.methodId = widget.shippingMethod!.methodId;
      shippingMethodInfo.methodTitle = widget.shippingMethod!.methodTitle;
      shippingMethodInfo.total = (widget.shippingMethod!.settings!.cost != null)
          ? widget.shippingMethod!.settings!.cost!.value
          : "0";
      shippingMethod.add(shippingMethodInfo);
      orderCheckout.shippingIds = shippingMethod;
    }

    // payment method
    if (widget.paymentMethod != null) {
      orderCheckout.paymentMethod = widget.paymentMethod!.id;
      orderCheckout.paymentMethodTitle = widget.paymentMethod!.title;
    }

    orderCheckout.customerNote = "";
    orderCheckout.platform = "web";
    orderCheckout.onePage = AppData.settingsResponse.onePageCheckout.toString();

    BlocProvider.of<CheckoutBloc>(context).add(SaveOrder(orderCheckout));
  }
}

class WebViewExample extends StatefulWidget {
  int? orderId;

  WebViewExample(this.orderId);

  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  String url = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    url = AppConfig.WOO_ECOMMERCE_URL + "/mobile-checkout/";
    url += "?order_id=" + widget.orderId.toString();

    SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        int count = 0;
        Navigator.of(context).popUntil((_) => count++ >= 2);
        return false;
      },
      child: Stack(
        children: [
          WebView(
            javascriptMode: JavascriptMode.unrestricted,
            onProgress: (progress) {
              setState(() {
                isLoading = true;
              });
            },
            onPageFinished: (url) {
              setState(() {
                isLoading = false;
              });
            },
/*
            navigationDelegate: (NavigationRequest request) {
              if (request.url.contains("thankyou")) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Thankyou")));
              }
              return NavigationDecision.navigate;
            },
*/
            onPageStarted: (url) {
              print(url);
              if (url.contains("order-received")) {
                Navigator.pop(context, "Success");
              }
            },
            initialUrl: url,
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}
