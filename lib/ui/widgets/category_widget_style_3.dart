import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
import 'package:flutter_kundol/blocs/products_by_category/products_by_cat_bloc.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
// import 'package:flutter_kundol/models/category.dart';
import 'package:flutter_kundol/repos/products_repo.dart';

import '../../api/wooResponses/woo_categories_response.dart';
import '../child_categories_screen.dart';
import '../shop_screen.dart';

class CategoryWidgetStyle3 extends StatelessWidget {
  final List<WooCategory>? allCategories;
  final List<WooCategory> parentCategories;
  final Function(Widget widget) navigateToNext;

  const CategoryWidgetStyle3(
      this.allCategories, this.parentCategories, this.navigateToNext,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppStyles.GRID_SPACING),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: parentCategories.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppStyles.GRID_SPACING,
            childAspectRatio: 1,
            mainAxisSpacing: AppStyles.GRID_SPACING),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
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
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppStyles.CARD_RADIUS),
                  child: CachedNetworkImage(
                    imageUrl: parentCategories[index].image!.src!,
                    fit: BoxFit.cover,
                    height: double.maxFinite,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress)),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppStyles.CARD_RADIUS),
                  child: Container(
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
                Text(
                  parentCategories[index].name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff444444)),
                ),
              ],
            ),
          );
        },
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
