// import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_kundol/blocs/address/address_bloc.dart';
import 'package:flutter_kundol/blocs/auth/auth_bloc.dart';
import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
import 'package:flutter_kundol/blocs/contact_us/contact_us_bloc.dart';
import 'package:flutter_kundol/blocs/orders/orders_bloc.dart';
import 'package:flutter_kundol/blocs/reward_points/reward_bloc.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/repos/address_repo.dart';
import 'package:flutter_kundol/repos/cart_repo.dart';
import 'package:flutter_kundol/repos/contact_us_repo.dart';
import 'package:flutter_kundol/repos/orders_repo.dart';
import 'package:flutter_kundol/repos/reward_repo.dart';
import 'package:flutter_kundol/tweaks/app_localization.dart';
import 'package:flutter_kundol/ui/Reward_screen.dart';
import 'package:flutter_kundol/ui/contact_screen.dart';
import 'package:flutter_kundol/ui/edit_profile_screen.dart';
import 'package:flutter_kundol/ui/login_screen.dart';
import 'package:flutter_kundol/ui/my_address_screen.dart';
import 'package:flutter_kundol/ui/orders_screen.dart';
import 'package:flutter_kundol/ui/settings.dart';
// import 'package:flutter_kundol/ui/wallet_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';

import 'cart_screen.dart';

class MeFragment extends StatelessWidget {
  final Function(Widget widget) navigateToNext;

  MeFragment(this.navigateToNext);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
          SliverAppBar(
            leading: GestureDetector(
              onTap: () => navigateToNext(Settings()),
              child: Container(
                child: SvgPicture.asset("assets/icons/ic_setting.svg",
                    fit: BoxFit.none),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () => navigateToNext(
                  (AppData.wooUser != null)
                      ? BlocProvider(
                          create: (context) => CartBloc(RealCartRepo()),
                          child: CartScreen())
                      : SignIn(),
                ),
                child: Padding(
                    padding: EdgeInsets.only(right: 12.0),
                    child: SvgPicture.asset("assets/icons/ic_cart.svg",
                        fit: BoxFit.none, color: Colors.white)),
              ),
            ],
            expandedHeight: 140.0,
            pinned: true,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (BuildContext context, state) {
                        return InkWell(
                          onTap: () {
                            if (state is Authenticated) {
                              navigateToNext(EditProfileScreen());
                            } else
                              navigateToNext(SignIn());
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                            child: Row(
                              children: [
                                Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration:
                                      new BoxDecoration(shape: BoxShape.circle),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "https://i.pinimg.com/originals/7c/c7/a6/7cc7a630624d20f7797cb4c8e93c09c1.png",
                                      fit: BoxFit.fill,
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                              .translate('welcome')! +
                                          ((AppData.wooUser != null)
                                              ? AppData.wooUser!.firstName!
                                              : ""),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 2.0,
                                    ),
                                    Text(
                                      (AppData.wooUser != null)
                                          ? AppData.wooUser!.email!
                                          : AppLocalizations.of(context)!
                                              .translate('please_login')!,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Expanded(child: SizedBox()),
                                IconTheme(
                                    data: IconThemeData(color: Colors.white),
                                    child: Icon(Icons.navigate_next)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    /*Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text("0",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                                Text(
                                  "Rewards",
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.white),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text("Rs0.00",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                                Text(
                                  "Wallet",
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.white),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text("0",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                                Text(
                                  "Points",
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.white),
                                )
                              ],
                            ),
                          ]),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              color: Theme.of(context).primaryColor,
                              height: 55,
                            ),
                            Container(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              height: 55,
                            )
                          ],
                        ),
                        Card(
                          color: Color(0xFF444444),
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  AppStyles.SCREEN_MARGIN_HORIZONTAL * 2),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Membership Benefits",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .copyWith(
                                              color: Color(0xFFFFC854),
                                            )),
                                    Icon(
                                      Icons.chevron_right,
                                      size: 16.0,
                                      color: Color(0xFFFFC854),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Membership Benefits \n5% OFF",
                                          style: TextStyle(
                                            color: Color(0xFFFFC854),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Birthday Gift \n5% OFF",
                                          style: TextStyle(
                                            color: Color(0xFFFFC854),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),*/
                  ],
                ),
              ),
            ),
          ),
        ],
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView(
              children: [
/*
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.5, color: Color(0xFFFFC854)),
                            borderRadius: BorderRadius.circular(3),
                            color: Color(0xFFF7ECD5)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Check In',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Claim your 20 points',
                                      style: TextStyle(
                                          fontSize: 8,
                                          color: Color(0xFF0478ED)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: ClipOval(
                                  child: Image.asset(
                                      'assets/images/logo_checkin.png',
                                      fit: BoxFit.fill,
                                      height: 50,
                                      width: 50),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15.0),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.5, color: Color(0xFF97CBFF)),
                            borderRadius: BorderRadius.circular(3),
                            color: Color(0xFFC4DCF4)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Share',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Up to \$1000 wallet',
                                      style: TextStyle(
                                          fontSize: 8,
                                          color: Color(0xFF0478ED)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: ClipOval(
                                  child: Image.asset(
                                      'assets/images/logo_share.png',
                                      fit: BoxFit.fill,
                                      height: 50,
                                      width: 50),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
*/
                Padding(
                  padding: EdgeInsets.only(top: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: (Theme.of(context).brightness == Brightness.dark)
                          ? Theme.of(context).cardColor
                          : Color(0xFFEAF3DE),
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black.withOpacity(0.4)
                              : Colors.grey.withOpacity(0.6),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .translate('my_orders')!,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (AppData.wooUser != null)
                                  navigateToNext(BlocProvider(
                                      create: (BuildContext context) {
                                        return OrdersBloc(RealOrdersRepo())
                                          ..add(GetOrders());
                                      },
                                      child: OrdersScreen()));
                                else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Login first")));
                                }
                              },
                              child: Text(
                                AppLocalizations.of(context)!
                                    .translate('view_all')!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 11.0,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        GridView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10.0,
                                  childAspectRatio: 1.3),
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (AppData.wooUser != null)
                                  navigateToNext(BlocProvider(
                                      create: (BuildContext context) {
                                        return OrdersBloc(RealOrdersRepo())
                                          ..add(GetOrders());
                                      },
                                      child: OrdersScreen()));
                                else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Login first")));
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      "assets/icons/ic_in_progress.svg",
                                      fit: BoxFit.none,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppStyles.COLOR_ICONS_DARK
                                          : AppStyles.COLOR_ICONS_LIGHT),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .translate('in_progress')!,
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (AppData.wooUser != null)
                                  navigateToNext(BlocProvider(
                                      create: (BuildContext context) {
                                        return OrdersBloc(RealOrdersRepo())
                                          ..add(GetOrders());
                                      },
                                      child: OrdersScreen()));
                                else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Login first")));
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      "assets/icons/ic_delivered.svg",
                                      fit: BoxFit.none,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppStyles.COLOR_ICONS_DARK
                                          : AppStyles.COLOR_ICONS_LIGHT),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .translate('delivered')!,
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (AppData.wooUser != null)
                                  navigateToNext(BlocProvider(
                                      create: (BuildContext context) {
                                        return OrdersBloc(RealOrdersRepo())
                                          ..add(GetOrders());
                                      },
                                      child: OrdersScreen()));
                                else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Login first")));
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      "assets/icons/ic_reviews.svg",
                                      fit: BoxFit.none,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppStyles.COLOR_ICONS_DARK
                                          : AppStyles.COLOR_ICONS_LIGHT),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .translate('in_review')!,
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: (Theme.of(context).brightness == Brightness.dark)
                          ? Theme.of(context).cardColor
                          : Color(0XFFFBE5E2),
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black.withOpacity(0.4)
                              : Colors.grey.withOpacity(0.6),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!
                              .translate('help_and_info')!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        GridView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 10.0,
                                  childAspectRatio: 1),
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (AppData.wooUser != null)
                                  navigateToNext(BlocProvider(
                                      create: (BuildContext context) {
                                        return AddressBloc(RealAddressRepo())
                                          ..add(GetAddress());
                                      },
                                      child: MyAddressScreen()));
                                else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Login first")));
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      "assets/icons/ic_address.svg",
                                      fit: BoxFit.none,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppStyles.COLOR_ICONS_DARK
                                          : AppStyles.COLOR_ICONS_LIGHT),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .translate('address')!,
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            /*Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/icons/ic_payment.svg",
                                    fit: BoxFit.none),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "Payment",
                                  style: TextStyle(fontSize: 12),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),*/
                            GestureDetector(
                              onTap: () {
                                if (AppData.wooUser != null)
                                  navigateToNext(EditProfileScreen());
                                else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Login first")));
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      "assets/icons/ic_profile.svg",
                                      fit: BoxFit.none,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppStyles.COLOR_ICONS_DARK
                                          : AppStyles.COLOR_ICONS_LIGHT),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .translate('profile')!,
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => navigateToNext(BlocProvider(
                                  create: (BuildContext context) =>
                                      RewardBloc(RealRewardPoints()),
                                  child: RewardScreen())),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/icons/ic_help.svg",
                                      fit: BoxFit.none,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppStyles.COLOR_ICONS_DARK
                                          : AppStyles.COLOR_ICONS_LIGHT),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .translate('rewards')!,
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => navigateToNext(BlocProvider(
                                  create: (BuildContext context) =>
                                      ContactUsBloc(RealContactUsRepo()),
                                  child: ContactUsScreen())),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      "assets/icons/ic_feedback.svg",
                                      fit: BoxFit.none,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppStyles.COLOR_ICONS_DARK
                                          : AppStyles.COLOR_ICONS_LIGHT),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .translate('feedback')!,
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Share.share(
                                  'check out this app Flutter Rawal'),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.share,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppStyles.COLOR_ICONS_DARK
                                          : AppStyles.COLOR_ICONS_LIGHT),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .translate('share')!,
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => LaunchReview.launch(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.star_border_outlined,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppStyles.COLOR_ICONS_DARK
                                          : AppStyles.COLOR_ICONS_LIGHT),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .translate('rate_us')!,
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
/*
                ListTile(
                  dense: true,
                  onTap: () {
                    navigateToNext(BlocProvider(
                      create: (context) => RewardBloc(RealRewardPoints()),
                      child: RewardScreen(),
                    ));
                  },
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                  leading: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.receipt_long_outlined)),
                  title: Text(
                    "Rewards",
                  ),
                  trailing: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.chevron_right)),
                ),
                ListTile(
                  dense: true,
                  onTap: () {
                    navigateToNext(WalletScreen());
                  },
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                  leading: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.account_balance_wallet_outlined)),
                  title: Text(
                    "Wallet",
                  ),
                  trailing: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.chevron_right)),
                ),
                ListTile(
                  dense: true,
                  onTap: () {},
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                  leading: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.account_balance_wallet_outlined)),
                  title: Text(
                    "Points",
                  ),
                  trailing: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.chevron_right)),
                ),
                ListTile(
                  dense: true,
                  onTap: () {
                    navigateToNext(
                      BlocProvider(
                          create: (BuildContext context) {
                            return AddressBloc(RealAddressRepo())
                              ..add(GetAddress());
                          },
                          child: AddressScreen()),
                    );
                  },
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                  leading: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.location_on_outlined)),
                  title: Text(
                    "Address Book",
                  ),
                  trailing: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.chevron_right)),
                ),
                ListTile(
                  dense: true,
                  onTap: () {},
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                  leading: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.credit_card_outlined)),
                  title: Text(
                    "Payment",
                  ),
                  trailing: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.chevron_right)),
                ),
                ListTile(
                  dense: true,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileScreen(),
                        ));
                  },
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                  leading: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.person_outline)),
                  title: Text(
                    "Profile",
                  ),
                  trailing: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.chevron_right)),
                ),
                ListTile(
                  dense: true,
                  onTap: () {},
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                  leading: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.attach_money_outlined)),
                  title: Text(
                    "Invite & Earn",
                  ),
                  trailing: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.chevron_right)),
                ),
                ListTile(
                  dense: true,
                  onTap: () {},
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                  leading: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.help_outline)),
                  title: Text(
                    "Help Cneter",
                  ),
                  trailing: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.chevron_right)),
                ),
                ListTile(
                  dense: true,
                  onTap: () {
                    navigateToNext(BlocProvider(
                        create: (BuildContext context) {
                          return ContactUsBloc(RealContactUsRepo());
                        },
                        child: ContactUsScreen()));
                  },
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                  leading: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.feedback_outlined)),
                  title: Text(
                    "Give us your feedback",
                  ),
                  trailing: IconTheme(
                      data: IconThemeData(color: AppStyles.COLOR_ICONS_LIGHT),
                      child: Icon(Icons.chevron_right)),
                ),
*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
