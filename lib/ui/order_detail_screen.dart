// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/wooResponses/woo_order.dart';
// import 'package:flutter_kundol/api/wooResponses/woo_order_detail.dart';
// import 'package:flutter_kundol/blocs/address/address_bloc.dart';
// import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
// import 'package:flutter_kundol/blocs/checkout/checkout_bloc.dart';
// import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
// import 'package:flutter_kundol/models/address_data.dart';
// import 'package:flutter_kundol/models/cart_data.dart';
// import 'package:flutter_kundol/models/orders_data.dart';
// import 'package:flutter_kundol/ui/thank_you_screen.dart';
// import 'package:flutter_kundol/ui/widgets/app_bar.dart';

class OrderDetailScreen extends StatefulWidget {
  final WooOrder ordersData;

  OrderDetailScreen(this.ordersData);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    double subtotal = 0;
    // double shipping = 0;
    // double tax = 0;
    double orderTotal = 0;

    for (int i = 0; i < widget.ordersData.lineItems!.length; i++) {
      subtotal +=
          double.parse(widget.ordersData.lineItems![i].price.toString());
      // shipping = 0;
      // tax = 0;
      orderTotal = subtotal;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).scaffoldBackgroundColor
          : Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).cardColor,
        title:
            Text("Order Detail", style: Theme.of(context).textTheme.titleLarge),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 15, right: 15),
                itemCount: widget.ordersData.lineItems!.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) => Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
/*
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                AppStyles.CARD_RADIUS),
                            child: Container(
                              height: 70,
                              width: 70,
                              child: CachedNetworkImage(
                                imageUrl:
                                ApiProvider.imgMediumUrlString +
                                    widget.ordersData.lineItems[index].name,
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress)),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
*/
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 218,
                                child: Text(
                                  widget.ordersData.lineItems![index].name!,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  softWrap: false,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                widget.ordersData.currency! +
                                    double.tryParse(widget
                                            .ordersData.lineItems![index].price
                                            .toString())!
                                        .toStringAsFixed(2),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context).primaryColor),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                "1, Black, Large",
                                style: TextStyle(fontSize: 10),
                              ),
                              Text(
                                "Qty: " +
                                    widget.ordersData.lineItems![index].quantity
                                        .toString(),
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 15);
                },
              ),
              SizedBox(
                height: 12,
              ),
              // Divider(
              //   thickness: 4,
              //   color: Color(0xFFE6E8E9),
              // ),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppStyles.CARD_RADIUS),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 1.0), // set border width
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0)), // set rounded corner radius
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.location_pin,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.ordersData.shipping!.firstName! +
                                  " " +
                                  widget.ordersData.shipping!.lastName!),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.ordersData.shipping!.address1!,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                widget.ordersData.billing!.phone!,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              // ListTile(
              //   onLongPress: () {},
              //   enabled: true,
              //   isThreeLine: true,
              //   tileColor: Colors.white,
              //   leading: Icon(Icons.location_pin),
              //   title: Text(),
              //   subtitle: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: <Widget>[
              //       Text(),
              //       Text(),
              //     ],
              //   ),
              // ),
              // Divider(
              //   thickness: 4,
              //   color: Color(0xFFE6E8E9),
              // ),
              SizedBox(
                height: 12,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppStyles.CARD_RADIUS),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 1.0), // set border width
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0)), // set rounded corner radius
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.account_balance_wallet,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.ordersData.billing!.firstName! +
                                  " " +
                                  widget.ordersData.billing!.lastName!),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.ordersData.billing!.address1!,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                widget.ordersData.billing!.phone!,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              // ListTile(
              //   onLongPress: () {},
              //   enabled: true,
              //   isThreeLine: true,
              //   tileColor: Colors.white,
              //   leading: Icon(Icons.account_balance_wallet),
              //   title: Text(),
              //   subtitle: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: <Widget>[
              //       Text(),
              //       Text(),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 12,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppStyles.CARD_RADIUS),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 1.0), // set border width
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0)), // set rounded corner radius
                  ),
                  padding: EdgeInsets.fromLTRB(12, 15, 12, 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Subtotal:"),
                          Text(widget.ordersData.currency! +
                              subtotal.toStringAsFixed(2)),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Discount:"),
                          Text(widget.ordersData.currency! + "0.00"),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Estimated Shipping:"),
                          Text(widget.ordersData.currency! + "0.00"),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tax:"),
                          Text(widget.ordersData.currency! + "0.00"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Order Total:"),
                          Text(
                            widget.ordersData.currency! +
                                orderTotal.toStringAsFixed(2),
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      )
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
}
