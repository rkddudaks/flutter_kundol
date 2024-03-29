import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/api/responses/settings_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_categories_response.dart';
import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
import 'package:flutter_kundol/blocs/featured_products/featured_products_bloc.dart';
import 'package:flutter_kundol/blocs/products_by_category/products_by_cat_bloc.dart';
import 'package:flutter_kundol/blocs/super_deal_products/super_deal_products_bloc.dart';
import 'package:flutter_kundol/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_kundol/blocs/wishlist_detail/wishlist_detail_bloc.dart';
import 'package:flutter_kundol/constants/app_config.dart';
import 'package:flutter_kundol/constants/app_data.dart';
// import 'package:flutter_kundol/models/category.dart';
import 'package:flutter_kundol/repos/products_repo.dart';
import 'package:flutter_kundol/tweaks/app_localization.dart';
import 'package:flutter_kundol/ui/DemoSettingsScreen.dart';
import 'package:flutter_kundol/ui/fragments/category_fragment.dart';
import 'package:flutter_kundol/ui/fav_fragment.dart';
import 'package:flutter_kundol/ui/fragments/category_fragment_2.dart';
import 'package:flutter_kundol/ui/fragments/category_fragment_3.dart';
import 'package:flutter_kundol/ui/fragments/category_fragment_4.dart';
import 'package:flutter_kundol/ui/fragments/category_fragment_5.dart';
import 'package:flutter_kundol/ui/fragments/category_fragment_6.dart';
import 'package:flutter_kundol/ui/fragments/home_fragment_1.dart';
import 'package:flutter_kundol/ui/fragments/home_fragment_2.dart';
import 'package:flutter_kundol/ui/fragments/home_fragment_5.dart';
import 'package:flutter_kundol/ui/fragments/home_fragment_7.dart';
import 'package:flutter_kundol/ui/fragments/home_fragment_9.dart';
import 'package:flutter_kundol/ui/me_fragment.dart';
import 'package:flutter_kundol/ui/news_fragment.dart';
import 'package:flutter_kundol/ui/shop_screen.dart';
import 'package:flutter_kundol/ui/widgets/bottom_navigation.dart';
import 'package:flutter_kundol/blocs/top_selling_products/top_selling_products_bloc.dart';

import '../blocs/get_currencies/get_currency_bloc.dart';
import '../blocs/get_languages/get_language_bloc.dart';
import '../repos/get_currency_repo.dart';
import '../repos/get_language_repo.dart';
import 'fragments/home_fragment_3.dart';
import 'fragments/home_fragment_4.dart';
import 'fragments/home_fragment_6.dart';
import 'fragments/home_fragment_8.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WishlistBloc>(context).add(GetWishlistOnStart());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_selectedIndex].currentState!.maybePop();
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
          return false;
        } else {
          return isFirstRouteInCurrentTab;
        }
      },
      child: BlocListener<WishlistBloc, WishlistState>(
        listener: (BuildContext context, state) {
          if (state is WishlistLoaded) {
            setState(() {
              AppData.favProducts = state.products;
            });
          }
        },
        child: Scaffold(
          key: scaffoldKey,
          drawer: Drawer(
            child: Column(children: [
              Container(
                  padding: EdgeInsets.only(top: 56.0, left: 16, right: 16),
                  alignment: Alignment.centerLeft,
                  width: double.maxFinite,
                  child: Text(
                    AppLocalizations.of(context)!.translate('welcome_guest')!,
                  )),
              BlocBuilder<CategoriesBloc, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesLoaded) {
                    List<WooCategory> parentCategories =
                        getParentCategories(state.categoriesResponse.data!);
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: parentCategories.length,
                        itemBuilder: (context, i) {
                          List<WooCategory> childData = getChildCategories(
                              state.categoriesResponse.data!,
                              parentCategories[i].id);
                          return (childData.isNotEmpty)
                              ? ExpansionTile(
                                  title: new Text(
                                    parentCategories[i].name!,
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                  children: <Widget>[
                                    new Column(
                                      children:
                                          _buildExpandableContent(childData),
                                    ),
                                  ],
                                )
                              : ListTile(
                                  onTap: () => _navigateToNext(BlocProvider(
                                      create: (BuildContext context) {
                                        return ProductsByCatBloc(
                                            RealProductsRepo(),
                                            BlocProvider.of<CategoriesBloc>(
                                                context),
                                            parentCategories[i].id,
                                            "date",
                                            "desc",
                                            "");
                                      },
                                      child: ShopScreen(parentCategories[i],
                                          _navigateToNext))),
                                  title: new Text(
                                    parentCategories[i].name!,
                                    style: TextStyle(fontSize: 12.0),
                                  ));
                        },
                      ),
                    );
                  } else if (state is CategoriesError)
                    return Text(state.error!);
                  else
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                },
              ),
            ]),
          ),
          body: Stack(
            children: [
              _buildOffstageNavigator(0),
              _buildOffstageNavigator(1),
              _buildOffstageNavigator(2),
              _buildOffstageNavigator(3),
              _buildOffstageNavigator(4),
            ],
          ),
          bottomNavigationBar:
              MyBottomNavigation(_selectCurrentItem, _selectedIndex),
          floatingActionButton: AppConfig.IS_DEMO_ENABlED
              ? FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: () =>
                      _navigateToNext(MultiBlocProvider(providers: [
                    BlocProvider(
                      create: (BuildContext context) {
                        return GetLanguageBloc(RealGetLanguageRepo());
                      },
                    ),
                    BlocProvider(
                      create: (BuildContext context) {
                        return GetCurrenciesBloc(RealGetCurrencyRepo());
                      },
                    ),
                  ], child: DemoSettingsScreen())),
                  // {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => DemoSettingsScreen()));
                  // },
                  child: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                )
              : null,
        ),
      ),
    );
  }

  _buildExpandableContent(List<WooCategory> data) {
    List<Widget> columnContent = [];

    for (WooCategory category in data)
      columnContent.add(
        new ListTile(
          onTap: () => _navigateToNext(BlocProvider(
              create: (BuildContext context) {
                return ProductsByCatBloc(
                    RealProductsRepo(),
                    BlocProvider.of<CategoriesBloc>(context),
                    category.id,
                    "date",
                    "desc",
                    "");
              },
              child: ShopScreen(category, _navigateToNext))),
          title: new Text(
            category.name!,
            style: TextStyle(fontSize: 12.0),
          ),
        ),
      );

    return columnContent;
  }

  void _selectCurrentItem(int position) {
    if (position == 2)
      BlocProvider.of<WishlistProductsBloc>(context)
          .add(RefreshWishlistProducts());
    setState(() {
      _selectedIndex = position;
    });
  }

  Widget _buildOffstageNavigator(int index) {
    var routeBuilders = _homeScreenRouteBuilder(context, index);

    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name!]!(context),
          );
        },
      ),
    );
  }

  _navigateToNext(Widget widget) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ));
  }

  _openHomeDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  Map<String, WidgetBuilder> _homeScreenRouteBuilder(
      BuildContext context, int index) {
    return {
      '/': (context) {
        return [
          getDefaultHome(),
          getDefaultCategory(),
          FavFragment(_navigateToNext, _openHomeDrawer),
          NewsFragment(_navigateToNext, _openHomeDrawer),
          MeFragment(_navigateToNext),
        ].elementAt(index);
      },
    };
  }

  Widget getDefaultHome() {
    switch (int.parse(AppData.settingsResponse.homeStyle!)) {
      case 1:
        return HomeFragment1(_navigateToNext, _openHomeDrawer);
      case 2:
        return HomeFragment2(_navigateToNext, _openHomeDrawer);
      case 3:
        return BlocProvider(
            create: (BuildContext context) =>
                TopSellingProductsBloc(RealProductsRepo()),
            child: HomeFragment3(_navigateToNext, _openHomeDrawer));
      case 4:
        return BlocProvider(
            create: (BuildContext context) =>
                TopSellingProductsBloc(RealProductsRepo()),
            child: HomeFragment4(_navigateToNext, _openHomeDrawer));
      case 5:
        return MultiBlocProvider(providers: [
          BlocProvider(
              create: (context) => TopSellingProductsBloc(RealProductsRepo())),
          BlocProvider(
              create: (context) => SuperDealProductsBloc(RealProductsRepo())),
          BlocProvider(
              create: (context) => FeaturedProductsBloc(RealProductsRepo())),
        ], child: HomeFragment5(_navigateToNext, _openHomeDrawer));
      case 6:
        return HomeFragment6(_navigateToNext, _openHomeDrawer);
      case 7:
        return MultiBlocProvider(providers: [
          BlocProvider(
              create: (context) => TopSellingProductsBloc(RealProductsRepo())),
          BlocProvider(
              create: (context) => SuperDealProductsBloc(RealProductsRepo()))
        ], child: HomeFragment7(_navigateToNext, _openHomeDrawer));
      case 8:
        return HomeFragment8(_navigateToNext, _openHomeDrawer);
      case 9:
        return MultiBlocProvider(providers: [
          BlocProvider(
              create: (context) => TopSellingProductsBloc(RealProductsRepo())),
          BlocProvider(
              create: (context) => SuperDealProductsBloc(RealProductsRepo())),
          BlocProvider(
              create: (context) => FeaturedProductsBloc(RealProductsRepo())),
        ], child: HomeFragment9(_navigateToNext, _openHomeDrawer));
      default:
        return HomeFragment1(_navigateToNext, _openHomeDrawer);
    }
  }

  Widget getDefaultCategory() {
    switch (int.parse(AppData.settingsResponse.categoryStyle!)) {
      case 1:
        return CategoryFragment(_navigateToNext, _openHomeDrawer);
      case 2:
        return CategoryFragment2(_navigateToNext, _openHomeDrawer);
      case 3:
        return CategoryFragment3(_navigateToNext, _openHomeDrawer);
      case 4:
        return CategoryFragment4(_navigateToNext, _openHomeDrawer);
      case 5:
        return CategoryFragment5(_navigateToNext, _openHomeDrawer);
      case 6:
        return CategoryFragment6(_navigateToNext, _openHomeDrawer);
      default:
        return CategoryFragment(_navigateToNext, _openHomeDrawer);
    }
  }

  List<WooCategory> getParentCategories(List<WooCategory> data) {
    List<WooCategory> tempCategories = [];
    for (int i = 0; i < data.length; i++) {
      if (data[i].parent == 0) {
        tempCategories.add(data[i]);
      }
    }
    return tempCategories;
  }

  List<WooCategory> getChildCategories(List<WooCategory> data, int? id) {
    List<WooCategory> tempCategories = [];
    for (int i = 0; i < data.length; i++) {
      if (data[i].parent == id) {
        tempCategories.add(data[i]);
      }
    }
    return tempCategories;
  }
}
