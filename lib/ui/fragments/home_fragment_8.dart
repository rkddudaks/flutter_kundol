// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/api/api_provider.dart';
// import 'package:flutter_kundol/api/responses/settings_response.dart';
// import 'package:flutter_kundol/blocs/banners/banners_bloc.dart';
// import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
// import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
// import 'package:flutter_kundol/blocs/detail_screen/detail_screen_bloc.dart';
import 'package:flutter_kundol/blocs/products/products_bloc.dart';
// import 'package:flutter_kundol/blocs/products_by_category/products_by_cat_bloc.dart';
import 'package:flutter_kundol/blocs/products_search/products_search_bloc.dart';
// import 'package:flutter_kundol/blocs/wishlist/wishlist_bloc.dart';
// import 'package:flutter_kundol/constants/app_constants.dart';
// import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
// import 'package:flutter_kundol/models/banners/banner.dart';
// import 'package:flutter_kundol/repos/cart_repo.dart';
import 'package:flutter_kundol/repos/products_repo.dart';
import 'package:flutter_kundol/tweaks/app_localization.dart';
// import 'package:flutter_kundol/ui/cart_screen.dart';
// import 'package:flutter_kundol/ui/detail_screen.dart';
import 'package:flutter_kundol/ui/search_screen.dart';
// import 'package:flutter_kundol/ui/shop_screen.dart';
// import 'package:flutter_kundol/ui/widgets/app_bar.dart';
import 'package:flutter_kundol/ui/widgets/banner_slider.dart';
// import 'package:flutter_kundol/ui/widgets/category_widget.dart';
// import 'package:flutter_kundol/ui/widgets/category_widget_2.dart';
import 'package:flutter_kundol/ui/widgets/category_widget_4.dart';
import 'package:flutter_kundol/ui/widgets/home_app_bar.dart';
import 'package:flutter_kundol/ui/widgets/home_tags.dart';
import 'package:flutter_kundol/ui/widgets/hot_items_widget.dart';
import 'package:flutter_kundol/ui/widgets/products_widget.dart';
import 'package:flutter_kundol/ui/widgets/sale_banner_widget.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class HomeFragment8 extends StatefulWidget {
  final Function(Widget widget)? navigateToNext;
  final Function()? openDrawer;

  HomeFragment8([this.navigateToNext, this.openDrawer]);

  @override
  _HomeFragment8State createState() => _HomeFragment8State();
}

class _HomeFragment8State extends State<HomeFragment8> {
  final _scrollController = ScrollController();
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    getProduct(context);
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HomeAppBar(widget.navigateToNext, widget.openDrawer),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL,
                    vertical: AppStyles.SCREEN_MARGIN_VERTICAL),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget.navigateToNext!(BlocProvider(
                          create: (context) =>
                              ProductsSearchBloc(RealProductsRepo()),
                          child: SearchScreen(widget.navigateToNext),
                        ));
                      },
                      child: Container(
                        height: 56.0,
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: AppStyles.COLOR_SEARCH_BAR,
                          borderRadius: BorderRadius.all(
                              Radius.circular(AppStyles.CARD_RADIUS)),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/ic_search_new.svg",
                              color: Colors.grey[700],
                              height: 18,
                              width: 18,
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .translate('search_hint')!,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    BannerSlider(widget.navigateToNext),
                    HomeTags(),
                    SaleBannerWidget(
                        isTitleVisible: true,
                        navigateToNext: widget.navigateToNext),
                    HotItemsWidget(
                        isTitleVisible: true,
                        navigateToNext: widget.navigateToNext),
                    CategoryWidget4(widget.navigateToNext),
                    ProductsWidget(widget.navigateToNext, _disableLoadMore),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void getProduct(context) {
    BlocProvider.of<ProductsBloc>(context).add(GetProducts());
  }

  void _onScroll() {
    if (_isBottom && !isLoadingMore) {
      isLoadingMore = true;
      getProduct(context);
    }
  }

  _disableLoadMore() {
    isLoadingMore = false;
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
