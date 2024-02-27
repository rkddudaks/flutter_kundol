// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
// import 'package:flutter_kundol/blocs/products_by_category/products_by_cat_bloc.dart';
// import 'package:flutter_kundol/constants/app_styles.dart';
// import 'package:flutter_kundol/models/category.dart';
// import 'package:flutter_kundol/repos/products_repo.dart';
// import 'package:flutter_kundol/ui/widgets/app_bar.dart';
import 'package:flutter_kundol/ui/widgets/category_widget_style_3.dart';
import 'package:flutter_kundol/ui/widgets/home_app_bar.dart';

import '../../api/wooResponses/woo_categories_response.dart';
// import '../shop_screen.dart';

class CategoryFragment3 extends StatefulWidget {
  Function(Widget widget) navigateToNext;
  final Function() openDrawer;

  CategoryFragment3(this.navigateToNext, this.openDrawer);

  @override
  _CategoryFragment3State createState() => _CategoryFragment3State();
}

class _CategoryFragment3State extends State<CategoryFragment3> {
  @override
  void initState() {
    super.initState();
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
            child: BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
                if (state is CategoriesLoaded)
                  return CategoryWidgetStyle3(
                      state.categoriesResponse.data,
                      getParentCategories(state.categoriesResponse.data!),
                      widget.navigateToNext);
                else if (state is CategoriesError)
                  return Text(state.error!);
                else
                  return Center(
                    child: CircularProgressIndicator(),
                  );
              },
            ),
          )
        ],
      ),
    );
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

  List<WooCategory> getChildCategories(List<WooCategory> data, int id) {
    List<WooCategory> tempCategories = [];
    for (int i = 0; i < data.length; i++) {
      if (data[i].parent == id) {
        tempCategories.add(data[i]);
      }
    }
    return tempCategories;
  }
}
