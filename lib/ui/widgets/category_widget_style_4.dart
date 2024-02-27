import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
import 'package:flutter_kundol/blocs/products_by_category/products_by_cat_bloc.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
// import 'package:flutter_kundol/models/category.dart';
import 'package:flutter_kundol/repos/products_repo.dart';

import '../../api/wooResponses/woo_categories_response.dart';
import '../child_categories_screen.dart';
import '../shop_screen.dart';

class CategoryWidgetStyle4 extends StatelessWidget {
  final List<WooCategory>? allCategories;
  final List<WooCategory> parentCategories;
  final Function(Widget widget) navigateToNext;

  const CategoryWidgetStyle4(
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
          return ClipRRect(
            borderRadius: BorderRadius.circular(AppStyles.CARD_RADIUS),
            child: Container(
              child: GestureDetector(
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
                        child: ShopScreen(
                            parentCategories[index], navigateToNext)));
                  else
                    navigateToNext(ChildCategoriesScreen(
                        childCategories, allCategories, navigateToNext));
                },
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: ApiProvider.imgMediumUrlString +
                          parentCategories[index].image!.src!,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress)),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.maxFinite,
                        height: 32,
                        child: Center(
                          child: Text(
                            parentCategories[index].name!,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppStyles.CARD_RADIUS),
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Theme.of(context).cardColor
                              : Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
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
