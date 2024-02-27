// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
import 'package:flutter_kundol/blocs/products_by_category/products_by_cat_bloc.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
// import 'package:flutter_kundol/models/category.dart';
import 'package:flutter_kundol/repos/products_repo.dart';
import 'package:flutter_kundol/tweaks/app_localization.dart';

import '../../api/wooResponses/woo_categories_response.dart';
import '../shop_screen.dart';

class SaleBannerWidget extends StatelessWidget {
  final Function(Widget widget)? navigateToNext;
  final bool? isTitleVisible;

  const SaleBannerWidget({Key? key, this.isTitleVisible, this.navigateToNext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          if (isTitleVisible!)
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                  AppLocalizations.of(context)!
                      .translate('year_end_sale')!
                      .toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium),
            ),
          BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoaded) {
                List<WooCategory>? categories = state.categoriesResponse.data;
                return GestureDetector(
                  onTap: () {
                    WooCategory category = categories![0];

                    if (category != null) {
                      navigateToNext!(BlocProvider(
                          create: (BuildContext context) {
                            return ProductsByCatBloc(
                                RealProductsRepo(),
                                BlocProvider.of<CategoriesBloc>(context),
                                category.id,
                                "date",
                                "desc",
                                "");
                          },
                          child: ShopScreen(category, navigateToNext)));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Can't find Category")));
                    }
                  },
                  child: AspectRatio(
                    aspectRatio: 3.0,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppStyles.CARD_RADIUS),
                      child: Image.asset(
                        "assets/images/sale_banner.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
