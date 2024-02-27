// import 'dart:math';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/api/api_provider.dart';
// import 'package:flutter_kundol/api/responses/settings_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_product/woo_product.dart';
// import 'package:flutter_kundol/api/wooResponses/woo_product_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_variation.dart';
import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
// import 'package:flutter_kundol/blocs/detail_screen/detail_screen_bloc.dart';
import 'package:flutter_kundol/blocs/filters/filters_bloc.dart';
import 'package:flutter_kundol/blocs/products/products_bloc.dart';
import 'package:flutter_kundol/blocs/products_by_category/products_by_cat_bloc.dart';
// import 'package:flutter_kundol/blocs/wishlist/wishlist_bloc.dart';
// import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/category.dart';
import 'package:flutter_kundol/models/filters_data.dart';
// import 'package:flutter_kundol/models/products/product.dart';
// import 'package:flutter_kundol/repos/cart_repo.dart';
// import 'package:flutter_kundol/repos/products_repo.dart';
import 'package:flutter_kundol/ui/widgets/card_style_10.dart';
import 'package:flutter_kundol/ui/widgets/card_style_11.dart';
import 'package:flutter_kundol/ui/widgets/card_style_12.dart';
import 'package:flutter_kundol/ui/widgets/card_style_13.dart';
import 'package:flutter_kundol/ui/widgets/card_style_14.dart';
import 'package:flutter_kundol/ui/widgets/card_style_15.dart';
import 'package:flutter_kundol/ui/widgets/card_style_16.dart';
import 'package:flutter_kundol/ui/widgets/card_style_17.dart';
import 'package:flutter_kundol/ui/widgets/card_style_18.dart';
import 'package:flutter_kundol/ui/widgets/card_style_19.dart';
import 'package:flutter_kundol/ui/widgets/card_style_2.dart';
import 'package:flutter_kundol/ui/widgets/card_style_20.dart';
import 'package:flutter_kundol/ui/widgets/card_style_21.dart';
import 'package:flutter_kundol/ui/widgets/card_style_22.dart';
import 'package:flutter_kundol/ui/widgets/card_style_23.dart';
import 'package:flutter_kundol/ui/widgets/card_style_24.dart';
import 'package:flutter_kundol/ui/widgets/card_style_25.dart';
import 'package:flutter_kundol/ui/widgets/card_style_26.dart';
import 'package:flutter_kundol/ui/widgets/card_style_27.dart';
import 'package:flutter_kundol/ui/widgets/card_style_3.dart';
import 'package:flutter_kundol/ui/widgets/card_style_4.dart';
import 'package:flutter_kundol/ui/widgets/card_style_5.dart';
import 'package:flutter_kundol/ui/widgets/card_style_6.dart';
import 'package:flutter_kundol/ui/widgets/card_style_7.dart';
import 'package:flutter_kundol/ui/widgets/card_style_8.dart';
import 'package:flutter_kundol/ui/widgets/card_style_9.dart';
import 'package:flutter_kundol/ui/widgets/card_style_new_1.dart';
import 'package:flutter_kundol/ui/widgets/dialog_utils.dart';

import '../api/wooResponses/woo_categories_response.dart';
// import 'detail_screen.dart';

bool isProgressDialogShowing = false;

class ShopScreen extends StatefulWidget {
  final WooCategory category;
  final Function(Widget widget)? navigateToNext;

  const ShopScreen(this.category, this.navigateToNext);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();
  bool isLoadingMore = false;

  WooCategory? category;
  String? sortBy = "date";
  String? sortType = "desc";

  @override
  void initState() {
    super.initState();
    category = widget.category;
    _scrollController.addListener(_onScroll);
    getProduct(context);
    BlocProvider.of<FiltersBloc>(context).add(GetFilters());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).scaffoldBackgroundColor
          : Colors.white,
      key: _scaffoldKey,
      endDrawer: FilterDrawer(),
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(),
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).cardColor,
        title: Text("Shop", style: Theme.of(context).textTheme.titleLarge),
        elevation: 0.0,
        actions: <Widget>[
          new Container(),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Theme.of(context).cardColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 100),
                  child: BlocBuilder<CategoriesBloc, CategoriesState>(
                    builder: (context, state) {
                      if (state is CategoriesLoaded) {
                        return DropdownButtonHideUnderline(
                            child: DropdownButton<WooCategory>(
                          isExpanded: true,
                          value: category,
                          items: state.categoriesResponse.data!
                              .map<DropdownMenuItem<WooCategory>>(
                                  (WooCategory value) {
                            return DropdownMenuItem<WooCategory>(
                                value: value,
                                child: Text(
                                  value.name!,
                                  overflow: TextOverflow.ellipsis,
                                  // maxLines: 1,
                                ));
                          }).toList(),
                          onChanged: (WooCategory? value) {
                            setState(() {
                              category = value;
                            });
                            isProgressDialogShowing = true;
                            DialogUtils.showLoaderDialog(context);
                            BlocProvider.of<ProductsByCatBloc>(context)
                                .add(CategoryChanged(value!.id));
                          },
                        ));
                      }
                      return Container();
                    },
                  ),
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: 80),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: sortBy,
                      items: <String>[
                        'date',
                        'id',
                        'title',
                        'price',
                        'popularity',
                        'rating'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(
                            value,
                            overflow: TextOverflow.ellipsis,
                            // maxLines: 2,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          sortBy = value;
                        });
                        isProgressDialogShowing = true;
                        DialogUtils.showLoaderDialog(context);
                        BlocProvider.of<ProductsByCatBloc>(context)
                            .add(SortByChanged(value));
                      },
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: 100),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: sortType,
                      items: <String>['asc', 'desc'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(
                            value,
                            overflow: TextOverflow.ellipsis,
                            // maxLines: 1,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          sortType = value;
                        });
                        isProgressDialogShowing = true;
                        DialogUtils.showLoaderDialog(context);
                        BlocProvider.of<ProductsByCatBloc>(context)
                            .add(SortTypeChanged(value));
                      },
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _scaffoldKey.currentState!.openEndDrawer();
                  },
                  child: Container(
                    padding: EdgeInsets.all(6.0),
                    child: Row(
                      children: [
                        Text("Filter"),
                        Icon(
                          Icons.filter_alt_outlined,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                    BlocConsumer<ProductsByCatBloc, ProductsByCatState>(
                      listener: (context, state) {
                        if (state.status == ProductsStatus.success &&
                            isProgressDialogShowing) {
                          isProgressDialogShowing = false;
                          Navigator.pop(context);
                        }
                      },
                      builder: (context, state) {
                        switch (state.status) {
                          case ProductsStatus.success:
                            isLoadingMore = false;
                            if (state.products!.isEmpty)
                              return Center(child: Text("Empty"));
                            else
                              return Column(
                                children: [
                                  GridView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: AppStyles.GRID_SPACING,
                                      mainAxisSpacing: AppStyles.GRID_SPACING,
                                      childAspectRatio: 0.75,
                                    ),
                                    itemCount: state.products!.length,
                                    itemBuilder: (context, index) {
                                      return getDefaultCard(
                                          state.products![index], index);
                                    },
                                  ),
                                  if (!state.hasReachedMax! &&
                                      state.products!.isNotEmpty &&
                                      state.products!.length % 10 == 0)
                                    Center(
                                      child: Container(
                                          margin: EdgeInsets.all(16.0),
                                          width: 24.0,
                                          height: 24.0,
                                          child: CircularProgressIndicator()),
                                    ),
                                ],
                              );
                          // break;
                          case ProductsStatus.failure:
                            return Text("Error");
                          default:
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
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

  void _onScroll() {
    if (_isBottom && !isLoadingMore) {
      isLoadingMore = true;
      getProduct(context);
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void getProduct(context) {
    BlocProvider.of<ProductsByCatBloc>(context)
        .add(GetProductsByCat(widget.category.id, sortBy));
  }

  int? getCategoryId(String value, List<Category> data) {
    for (int i = 0; i < data.length; i++) {
      if (value == data[i].name) return data[i].id;
    }
    return 0;
  }

  Category? getCategory(String value, List<Category> data) {
    for (int i = 0; i < data.length; i++) {
      if (value == data[i].name) return data[i];
    }
    return null;
  }

  Widget getDefaultCard(WooProduct product, int index) {
    //return CardStyleNew1(widget.navigateToNext, product, getCardBackground(index));
    switch (int.parse(AppData.settingsResponse.cardStyle!)) {
      case 1:
        return CardStyleNew1(
            widget.navigateToNext, product, getCardBackground(index));
      case 2:
        return CardStyle2(
            widget.navigateToNext, product, getCardBackground(index));
      case 3:
        return CardStyle3(
            widget.navigateToNext, product, getCardBackground(index));
      case 4:
        return CardStyle4(
            widget.navigateToNext, product, getCardBackground(index));
      case 5:
        return CardStyle5(
            widget.navigateToNext, product, getCardBackground(index));
      case 6:
        return CardStyle6(
            widget.navigateToNext, product, getCardBackground(index));
      case 7:
        return CardStyle7(
            widget.navigateToNext, product, getCardBackground(index));
      case 8:
        return CardStyle8(
            widget.navigateToNext, product, getCardBackground(index));
      case 9:
        return CardStyle9(
            widget.navigateToNext, product, getCardBackground(index));
      case 10:
        return CardStyle10(
            widget.navigateToNext, product, getCardBackground(index));
      case 11:
        return CardStyle11(
            widget.navigateToNext, product, getCardBackground(index));
      case 12:
        return CardStyle12(
            widget.navigateToNext, product, getCardBackground(index));
      case 13:
        return CardStyle13(
            widget.navigateToNext, product, getCardBackground(index));
      case 14:
        return CardStyle14(
            widget.navigateToNext, product, getCardBackground(index));
      case 15:
        return CardStyle15(
            widget.navigateToNext, product, getCardBackground(index));
      case 16:
        return CardStyle16(
            widget.navigateToNext, product, getCardBackground(index));
      case 17:
        return CardStyle17(
            widget.navigateToNext, product, getCardBackground(index));
      case 18:
        return CardStyle18(
            widget.navigateToNext, product, getCardBackground(index));
      case 19:
        return CardStyle19(
            widget.navigateToNext, product, getCardBackground(index));
      case 20:
        return CardStyle20(
            widget.navigateToNext, product, getCardBackground(index));
      case 21:
        return CardStyle21(
            widget.navigateToNext, product, getCardBackground(index));
      case 22:
        return CardStyle22(
            widget.navigateToNext, product, getCardBackground(index));
      case 23:
        return CardStyle23(
            widget.navigateToNext, product, getCardBackground(index));
      case 24:
        return CardStyle24(
            widget.navigateToNext, product, getCardBackground(index));
      case 25:
        return CardStyle25(
            widget.navigateToNext, product, getCardBackground(index));
      case 26:
        return CardStyle26(
            widget.navigateToNext, product, getCardBackground(index));
      case 27:
        return CardStyle27(
            widget.navigateToNext, product, getCardBackground(index));
      default:
        return CardStyleNew1(
            widget.navigateToNext, product, getCardBackground(index));
    }
  }
}

int cardColorindex = 0;

Color getCardBackground(int index) {
  Color tempColor = AppStyles.cardColors[cardColorindex];
  cardColorindex++;
  if (cardColorindex == 4) cardColorindex = 0;
  return tempColor;
}

typedef void ChoiceChipsCallback(List<WooVariation> variations);

class ChoiceChips extends StatefulWidget {
  final List<WooVariation>? chipName;
  final ChoiceChipsCallback? choiceChipsCallback;
  Variations? selectedVariation;

  ChoiceChips(
      {Key? key,
      this.chipName,
      this.choiceChipsCallback,
      this.selectedVariation})
      : super(key: key);

  @override
  _ChoiceChipsState createState() => _ChoiceChipsState();
}

class _ChoiceChipsState extends State<ChoiceChips> {
  List<bool> selections = [];
  List<WooVariation> selectedVariations = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.chipName!.length; i++) {
      selections.add(false);
    }
  }

  _buildChoiceList() {
    List<Widget> choices = [];
    widget.chipName!.asMap().forEach((index, item) {
      choices.add(Container(
        child: ChoiceChip(
          backgroundColor: Colors.transparent,
          label: Text(item.name!),
          labelStyle: TextStyle(
              color: selections[index]
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).brightness == Brightness.dark
                      ? AppStyles.COLOR_GREY_DARK
                      : AppStyles.COLOR_GREY_LIGHT),
          // shape: RoundedRectangleBorder(
          //   side: BorderSide(
          //       color: selections[index]
          //           ? Colors.transparent
          //           : Theme.of(context).brightness == Brightness.dark
          //               ? AppStyles.COLOR_GREY_DARK
          //               : AppStyles.COLOR_GREY_LIGHT,
          //       width: 1),
          //   borderRadius: BorderRadius.circular(5),
          // ),
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: selections[index]
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
                width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          selectedColor: Colors.transparent,
          selected: selections[index],
          onSelected: (selected) {
            setState(() {
              selections[index] = !selections[index];
              selectedVariations = [];
              for (int i = 0; i < selections.length; i++) {
                if (selections[i])
                  selectedVariations.add(widget.chipName![i]);
                else
                  selectedVariations.remove(widget.chipName![i]);
              }
              widget.choiceChipsCallback!(selectedVariations);
            });
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

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({Key? key}) : super(key: key);

  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  RangeValues values = RangeValues(1, 100);
  RangeLabels labels = RangeLabels('\$1', "\$100");
  List<FiltersData> selectedFilters = [];
  String? selectedIds;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 24,
          ),
          Container(
              height: 56,
              width: double.maxFinite,
              child: Row(children: [
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16.0), child: Text("Filters")),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.cancel_outlined))
              ])),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.all(0),
                        child: Text("Product Price")),
                    Padding(
                      padding: EdgeInsets.only(left: 0, right: 0),
                      child: Row(
                        children: [
                          Text(
                            "\$" + values.start.toStringAsFixed(2),
                            style: TextStyle(fontSize: 12),
                          ),
                          Expanded(child: Container()),
                          Text(
                            "\$" + values.end.toStringAsFixed(2),
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    RangeSlider(
                        activeColor: Theme.of(context).primaryColor,
                        min: 1,
                        max: 100,
                        values: values,
                        labels: labels,
                        onChanged: (value) {
                          setState(() {
                            values = value;
                            labels = RangeLabels(
                                "${value.start.toInt().toString()}\$",
                                "${value.end.toInt().toString()}\$");
                          });
                        }),
                    BlocBuilder<FiltersBloc, FiltersState>(
                      builder: (context, state) {
                        if (state is FiltersLoaded) {
                          return Center(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.filtersResponse.length,
                              itemBuilder: (context, index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  Text(state.filtersResponse[index].name!),
                                  SizedBox(
                                    height: 12.0,
                                  ),
                                  ChoiceChips(
                                    selectedVariation: null,
                                    chipName:
                                        state.filtersResponse[index].variations,
                                    choiceChipsCallback: (variation) {
                                      if (variation.isNotEmpty) {
                                        Navigator.pop(context);
                                        isProgressDialogShowing = true;
                                        DialogUtils.showLoaderDialog(context);
                                        BlocProvider.of<ProductsByCatBloc>(
                                                context)
                                            .add(FiltersChanged(
                                                state.filtersResponse[index]
                                                    .slug,
                                                variation.first.id.toString()));
                                      }

/*
                                      FiltersData data = FiltersData();
                                      data.attributeId = state.filtersResponse[index].id;
                                      data.variations = variation;
                                      if (selectedFilters.isEmpty)
                                        selectedFilters.add(data);
                                      else {
                                        for (int i = 0;
                                            i < selectedFilters.length;
                                            i++) {
                                          if (selectedFilters[i].attributeId ==
                                              state.filtersResponse[index]
                                                  .id)
                                            selectedFilters.removeAt(i);
                                        }
                                        selectedFilters.add(data);
                                      }

                                      selectedIds = "";

                                      for (int i = 0;
                                          i < selectedFilters.length;
                                          i++) {
                                        for (int j = 0;
                                            j <
                                                selectedFilters[i]
                                                    .variations
                                                    .length;
                                            j++) {
                                          selectedIds += selectedFilters[i]
                                                  .variations[j]
                                                  .id
                                                  .toString() +
                                              ",";
                                        }
                                      }
*/
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2, // 60% of space => (6/(6 + 4))
                  child: Container(
                      height: 35,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xffCDD2D3)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ))),
                          onPressed: () {
                            Navigator.pop(context);
                            isProgressDialogShowing = true;
                            DialogUtils.showLoaderDialog(context);
                            BlocProvider.of<ProductsByCatBloc>(context)
                                .add(FiltersChanged("", ""));
                          },
                          child: Text("Reset"))),
                ),
/*
                SizedBox(
                  width: 12.0,
                ),
                Expanded(
                    flex: 4, // 40% of space
                    child: Container(
                        height: 35,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ))),
                            onPressed: () {
                              Navigator.pop(context);
                              print("selectionIDS:  " + selectedIds);
                              BlocProvider.of<ProductsByCatBloc>(context)
                                  .add(FiltersChanged(selectedIds));
                            },
                            child: Text("Apply")))),
*/
              ],
            ),
          )
        ],
      ),
    );
  }
}
