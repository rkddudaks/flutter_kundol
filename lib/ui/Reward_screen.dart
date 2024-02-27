import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_kundol/api/wooResponses/woo_reward_response.dart';
// import 'package:flutter_kundol/blocs/address/address_bloc.dart';
import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
import 'package:flutter_kundol/blocs/reward_points/reward_bloc.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
// import 'package:flutter_kundol/models/reward/reward_point.dart';
// import 'package:flutter_kundol/repos/address_repo.dart';
// import 'package:flutter_kundol/ui/shipping_screen.dart';
// import 'package:flutter_kundol/ui/widgets/app_bar.dart';

class RewardScreen extends StatefulWidget {
  @override
  _RewardScreenState createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RewardBloc>(context).add(GetRewardPoints());
  }

  @override
  Widget build(BuildContext context) {
    late Widget mainWidget;
    return Scaffold(
      body: BlocConsumer<RewardBloc, RewardState>(
        builder: (context, state) {
          if (state is RewardLoaded) {
            double points = 0.0;
            for (int i = 0; i < state.rewardPointsResponse!.data!.length; i++) {
              points += double.parse(
                  state.rewardPointsResponse!.data![i].points.toString());
            }
            mainWidget = DefaultTabController(
              length: 3,
              child: Scaffold(
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Colors.white,
                appBar: AppBar(
                  centerTitle: true,
                  iconTheme: Theme.of(context).iconTheme,
                  backgroundColor: Theme.of(context).cardColor,
                  title: Text("Reward Points",
                      style: Theme.of(context).textTheme.titleLarge),
                  elevation: 0.0,
                  bottom: TabBar(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BubbleTabIndicator(
                        indicatorHeight: 34.0,
                        indicatorRadius: 12,
                        indicatorColor: Theme.of(context).primaryColor,
                        tabBarIndicatorSize: TabBarIndicatorSize.tab,
                        // Other flags
                        // indicatorRadius: 1,
                        // insets: EdgeInsets.all(1),
                        // padding: EdgeInsets.all(10)
                      ),
                      // indicator: UnderlineTabIndicator(
                      //   borderSide: BorderSide(
                      //       width: 2.0, color: Theme.of(context).primaryColor),
                      // ),
                      labelStyle: TextStyle(),
                      unselectedLabelColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? AppStyles.COLOR_GREY_DARK
                              : AppStyles.COLOR_GREY_LIGHT,
                      // labelColor: Theme.of(context).primaryColor,
                      labelColor: Colors.white,
                      tabs: [
                        Tab(text: "Available"),
                        Tab(text: "Applied"),
                        Tab(text: "Expired"),
                      ]),
                ),
                body: TabBarView(children: [
                  buildPage(state.rewardPointsResponse!.data!),
                  buildPage(state.rewardPointsResponse!.data!),
                  buildPage(state.rewardPointsResponse!.data!),
                ]),
              ),
            );
            return mainWidget;
          } else if (state is RedeemLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.redeemResponse.message!)));
            return mainWidget;
          } else if (state is CartLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return Container();
        },
        listener: (context, state) {
          if (state is RewardError) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error!)));
          } else if (state is RedeemLoaded) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.redeemResponse.message!)));
          }
        },
      ),
    );
  }

  Widget buildPage(List<WooRewardData> rewardPoints) {
    double points = 0.0;
    for (int i = 0; i < rewardPoints.length; i++) {
      points += double.parse(rewardPoints[i].points.toString());
    }
    return Column(
      children: [
        Container(
          // height: 120,
          width: double.maxFinite,
          child: Center(
            child: Text(
              points.toStringAsFixed(2),
              style: TextStyle(fontSize: 26),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: rewardPoints.length,
            itemBuilder: (context, index1) {
              return Container(
                margin: EdgeInsets.all(8.0),
                // decoration: BoxDecoration(
                //  color:Theme.of(context).brightness == Brightness.dark ? Theme.of(context).cardColor : Colors.white, // set border width
                //   borderRadius: BorderRadius.all(
                //       Radius.circular(
                //           10.0)), // set rounded corner radius
                // ),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).cardColor
                      : Colors.white,
                  border: Border.all(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(AppStyles
                          .CARD_RADIUS) //                 <--- border radius here
                      ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      child: Text(
                        double.parse(rewardPoints[index1].points.toString())
                            .toStringAsFixed(2),
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).primaryColor),
                      ),
                      padding: EdgeInsets.only(top: 14, left: 8),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 0, left: 8, bottom: 12),
                        child: Text(
                          rewardPoints[index1].type!,
                          style: TextStyle(fontSize: 14),
                        )),
                    Divider(
                      color: Theme.of(context).primaryColor,
                    ),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Text(
                          "Validity: Jan 11, 2021 - Feb 11, 2021",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0.0),
                            topRight: Radius.circular(10.0),
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.zero,
                          ),
                          color: Theme.of(context)
                              .primaryColor // set rounded corner radius
                          ),
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "NEW MEMBER DISCOUNT",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 60),
      ],
    );
  }
}
