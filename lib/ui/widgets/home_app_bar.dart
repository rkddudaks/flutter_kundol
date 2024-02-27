// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
import 'package:flutter_kundol/blocs/detail_screen/detail_screen_bloc.dart';
// import 'package:flutter_kundol/blocs/products_search/products_search_bloc.dart';
import 'package:flutter_kundol/constants/app_data.dart';
// import 'package:flutter_kundol/constants/app_styles.dart';
// import 'package:flutter_kundol/repos/cart_repo.dart';
// import 'package:flutter_kundol/repos/products_repo.dart';
// import 'package:flutter_kundol/tweaks/app_localization.dart';
import 'package:flutter_svg/svg.dart';

import '../cart_screen.dart';
import '../login_screen.dart';
// import '../search_screen.dart';
import 'app_bar.dart';

class HomeAppBar extends StatefulWidget {
  final Function(Widget widget)? navigateToNext;
  final Function()? openDrawer;

  const HomeAppBar(
    this.navigateToNext,
    this.openDrawer, {
    Key? key,
  }) : super(key: key);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return MyAppBar(
      leadingWidget: Padding(
        padding: EdgeInsets.all(15),
        child: GestureDetector(
          onTap: () => widget.openDrawer!(),
          child: Container(
              width: 30,
              height: 30,
              // decoration: BoxDecoration(
              //     color: Color(0x1A0478ED),
              //     borderRadius: BorderRadius.all(Radius.circular(6))),
              child: SvgPicture.asset("assets/icons/ic_menu_new.svg",
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  fit: BoxFit.none)),
        ),
      ),
      centerWidget: Center(
        child: Image.asset("assets/images/namal_header.png", height: 28),
        /*child: Text(
            AppLocalizations.of(context)!.translate('app_name')!,
            style: TextStyle(
                fontSize: 16.0,
                fontFamily: "MontserratSemiBold",fontWeight: FontWeight.bold),
          ),*/
      ),
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
/*
            GestureDetector(
              onTap: () => navigateToNext(BlocProvider(
                create: (context) => ProductsSearchBloc(RealProductsRepo()),
                child: SearchScreen(navigateToNext),
              )),
              child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: SvgPicture.asset("assets/icons/ic_search.svg",
                      fit: BoxFit.none,
                      color: Theme.of(context).brightness == Brightness.dark ? AppStyles.COLOR_ICONS_DARK : AppStyles.COLOR_ICONS_LIGHT,
                  )),
            ),
*/
            GestureDetector(
              onTap: () => widget.navigateToNext!(
                  (AppData.wooUser != null) ? CartScreen() : SignIn()
/*
                (AppData.user != null)
                    ? BlocProvider(
                    create: (context) =>
                        CartBloc(RealCartRepo()),
                    child: CartScreen())
                    : SignIn(),
*/
                  ),
              child: Stack(
                children: [
                  Padding(
                      padding: EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        "assets/icons/ic_cart.svg",
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        fit: BoxFit.none,
                        // color: Theme.of(context).brightness == Brightness.dark ? AppStyles.COLOR_ICONS_DARK : AppStyles.COLOR_ICONS_LIGHT,
                      )),
                  new Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                      alignment: Alignment.center,
                      child: BlocBuilder(
                          bloc: BlocProvider.of<DetailScreenBloc>(context),
                          builder: (context1, dynamic state1) {
                            return BlocBuilder(
                              bloc: BlocProvider.of<CartBloc>(context),
                              builder: (context, dynamic state) {
                                return Text(
                                  AppData.cartItems.length.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                );
                              },
                            );
                          }),
                    ),
                  )
                ],
              ),
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
    );
  }
}
