import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/wooResponses/woo_categories_response.dart';
import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
import 'package:flutter_kundol/blocs/products_by_category/products_by_cat_bloc.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
// import 'package:flutter_kundol/models/category.dart';
import 'package:flutter_kundol/repos/products_repo.dart';

import '../child_categories_screen.dart';
import '../shop_screen.dart';

class CategoryWidgetStyle1 extends StatelessWidget {
  final List<WooCategory>? allCategories;
  final List<WooCategory> parentCategories;
  final Function(Widget widget) navigateToNext;

  const CategoryWidgetStyle1(
      this.allCategories, this.parentCategories, this.navigateToNext,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).scaffoldBackgroundColor
          : Colors.white,
      body: Container(
        child: ListView.separated(
          padding: EdgeInsets.symmetric(
              horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL,
              vertical: AppStyles.SCREEN_MARGIN_VERTICAL),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                List<WooCategory> childCategories = getChildCategories(
                    allCategories!, parentCategories[index].id);
                if (childCategories.isEmpty)
                  navigateToNext(BlocProvider(
                      create: (BuildContext context) {
                        return ProductsByCatBloc(
                            RealProductsRepo(),
                            BlocProvider.of<CategoriesBloc>(context),
                            parentCategories[index].id,
                            "date",
                            "desc",
                            "");
                      },
                      child:
                          ShopScreen(parentCategories[index], navigateToNext)));
                else
                  navigateToNext(ChildCategoriesScreen(
                      childCategories, allCategories, navigateToNext));
              },
              child: Row(children: [
                Container(
                    width: 60.0,
                    height: 60.0,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppStyles.CARD_RADIUS),
                      child: CachedNetworkImage(
                        imageUrl: parentCategories[index].image!.src!,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress)),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    )),
                SizedBox(
                  width: 20,
                ),
                Text(
                  parentCategories[index].name!,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ]),
            );
          },
          itemCount: parentCategories.length,
          separatorBuilder: (context, index) => SizedBox(
            height: AppStyles.GRID_SPACING,
          ),
        ),
      ),
    );
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
