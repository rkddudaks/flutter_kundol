// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/api/api_provider.dart';
// import 'package:flutter_kundol/api/responses/settings_response.dart';
// import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
// import 'package:flutter_kundol/blocs/products_by_category/products_by_cat_bloc.dart';
import 'package:flutter_kundol/constants/app_data.dart';
// import 'package:flutter_kundol/constants/app_styles.dart';
// import 'package:flutter_kundol/models/category.dart';
// import 'package:flutter_kundol/repos/products_repo.dart';
// import 'package:flutter_kundol/ui/shop_screen.dart';
import 'package:flutter_kundol/ui/widgets/category_widget_style_1.dart';
import 'package:flutter_kundol/ui/widgets/category_widget_style_2.dart';
import 'package:flutter_kundol/ui/widgets/category_widget_style_3.dart';
import 'package:flutter_kundol/ui/widgets/category_widget_style_4.dart';
import 'package:flutter_kundol/ui/widgets/category_widget_style_5.dart';

import '../api/wooResponses/woo_categories_response.dart';

class ChildCategoriesScreen extends StatefulWidget {
  final List<WooCategory> categories;
  final List<WooCategory>? allCategories;
  final Function(Widget widget) navigateToNext;
  const ChildCategoriesScreen(
      this.categories, this.allCategories, this.navigateToNext,
      {Key? key})
      : super(key: key);

  @override
  _ChildCategoriesScreenState createState() => _ChildCategoriesScreenState();
}

class _ChildCategoriesScreenState extends State<ChildCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).scaffoldBackgroundColor
          : Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).cardColor,
        title:
            Text("Categories", style: Theme.of(context).textTheme.titleLarge),
        elevation: 0.0,
      ),
      body: getDefaultCategory(),
    );
  }

  Widget getDefaultCategory() {
    switch (int.parse(AppData.settingsResponse.categoryStyle!)) {
      case 1:
        return CategoryWidgetStyle1(
            widget.allCategories, widget.categories, widget.navigateToNext);
      case 2:
        return CategoryWidgetStyle2(
            widget.allCategories, widget.categories, widget.navigateToNext);
      case 3:
        return CategoryWidgetStyle3(
            widget.allCategories, widget.categories, widget.navigateToNext);
      case 4:
        return CategoryWidgetStyle4(
            widget.allCategories, widget.categories, widget.navigateToNext);
      case 5:
        return CategoryWidgetStyle5(
            widget.allCategories, widget.categories, widget.navigateToNext);
      case 6:
        return CategoryWidgetStyle1(
            widget.allCategories, widget.categories, widget.navigateToNext);
      default:
        return CategoryWidgetStyle1(
            widget.allCategories, widget.categories, widget.navigateToNext);
    }
  }
}
