// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/wooResponses/woo_order.dart';
// import 'package:flutter_kundol/blocs/address/address_bloc.dart';
// import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
import 'package:flutter_kundol/blocs/orders/orders_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
// import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
// import 'package:flutter_kundol/models/orders_data.dart';
// import 'package:flutter_kundol/repos/address_repo.dart';
import 'package:flutter_kundol/repos/orders_repo.dart';
import 'package:flutter_kundol/ui/order_detail_screen.dart';
// import 'package:flutter_kundol/ui/shipping_screen.dart';
// import 'package:flutter_kundol/ui/widgets/app_bar.dart';

import '../blocs/order_details/order_detail_bloc.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OrdersBloc, OrdersState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is OrdersLoaded) {
            return DefaultTabController(
              length: 7,
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  iconTheme: Theme.of(context).iconTheme,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  title: Text("Orders",
                      style: Theme.of(context).textTheme.titleLarge),
                  elevation: 0.0,
                  bottom: TabBar(
                      isScrollable: true,
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BubbleTabIndicator(
                        indicatorHeight: 34.0,
                        indicatorRadius: 12,
                        indicatorColor: Theme.of(context).primaryColor,
                        tabBarIndicatorSize: TabBarIndicatorSize.tab,
                      ),
                      labelStyle: TextStyle(),
                      unselectedLabelColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? AppStyles.COLOR_GREY_DARK
                              : AppStyles.COLOR_GREY_LIGHT,
                      tabs: [
                        Tab(text: "Processing"),
                        Tab(text: "Pending"),
                        Tab(text: "On-Hold"),
                        Tab(text: "Completed"),
                        Tab(text: "Cancelled"),
                        Tab(text: "Refunded"),
                        Tab(text: "Failed"),
                      ]),
                ),
                body: TabBarView(children: [
                  buildPage(getOrdersBy(
                      state.ordersData, AppConstants.ORDER_STATUS_PROCESSING)),
                  buildPage(getOrdersBy(
                      state.ordersData, AppConstants.ORDER_STATUS_PENDING)),
                  buildPage(getOrdersBy(
                      state.ordersData, AppConstants.ORDER_STATUS_ON_HOLD)),
                  buildPage(getOrdersBy(
                      state.ordersData, AppConstants.ORDER_STATUS_COMPLETED)),
                  buildPage(getOrdersBy(
                      state.ordersData, AppConstants.ORDER_STATUS_CANCELLED)),
                  buildPage(getOrdersBy(
                      state.ordersData, AppConstants.ORDER_STATUS_REFUND)),
                  buildPage(getOrdersBy(
                      state.ordersData, AppConstants.ORDER_STATUS_PROCESSING)),
                ]),
              ),
            );
          } else if (state is OrdersError) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildPage(List<WooOrder> ordersData) {
    return ListView.builder(
      itemCount: ordersData.length,
      itemBuilder: (context, index1) {
        double subtotal = 0;
        double orderTotal = 0;

        for (int i = 0; i < ordersData[index1].lineItems!.length; i++) {
          subtotal +=
              double.parse(ordersData[index1].lineItems![i].total.toString());
          orderTotal = subtotal;
        }

        return Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Order ID: " + ordersData[index1].id.toString()),
                        Text("Placed on 22-12-20, 13:15",
                            style: TextStyle(
                                color: Colors.grey[350], fontSize: 10)),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                      create: (context) =>
                                          OrderDetailBloc(RealOrdersRepo()),
                                      child:
                                          OrderDetailScreen(ordersData[index1]),
                                    )));
                      },
                      child: Text("View Details >",
                          style:
                              TextStyle(color: Colors.grey[350], fontSize: 10)),
                    )
                  ],
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 15, right: 15),
                itemCount: ordersData[index1].lineItems!.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index2) => Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          /*ClipRRect(
                            borderRadius:
                                BorderRadius.circular(AppStyles.CARD_RADIUS),
                            child: Container(
                              height: 70,
                              width: 70,
                              child: CachedNetworkImage(
                                imageUrl: ApiProvider.imgMediumUrlString +
                                    ordersData[index1]
                                        .lineItems[index2].name,
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress)),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),*/
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 218,
                                  child: Text(
                                    ordersData[index1].lineItems![index2].name!,
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
                                  double.parse(ordersData[index1]
                                          .lineItems![index2]
                                          .price
                                          .toString())
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
                                      ordersData[index1]
                                          .lineItems![index2]
                                          .quantity
                                          .toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
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
              Padding(
                padding: const EdgeInsets.only(right: 15, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "2 Items, Total:",
                      style: TextStyle(fontSize: 12, color: Colors.grey[350]),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      orderTotal.toString(),
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
              // Divider(
              //   thickness: 4,
              //   color: Color(0xFFE6E8E9),
              // ),
            ],
          ),
        );
      },
    );
  }

  List<WooOrder> getOrdersBy(List<WooOrder> ordersData, String filterBy) {
    List<WooOrder> tempOrders = [];

    for (int i = 0; i < ordersData.length; i++) {
      if (ordersData[i].status == filterBy) {
        tempOrders.add(ordersData[i]);
      }
    }
    return tempOrders;
  }
}
