import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
import 'package:flutter_kundol/blocs/products_by_category/products_by_cat_bloc.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/repos/products_repo.dart';
import 'package:flutter_kundol/tweaks/app_localization.dart';
import 'package:flutter_kundol/ui/shop_screen.dart';

class CategoryWidget4 extends StatefulWidget {
  final Function(Widget widget)? navigateToNext;

  const CategoryWidget4(this.navigateToNext, {Key? key}) : super(key: key);

  @override
  _CategoryWidget4State createState() => _CategoryWidget4State();
}

class _CategoryWidget4State extends State<CategoryWidget4> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoriesBloc>(context).add(GetCategories());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
                AppLocalizations.of(context)!
                    .translate('shop_by_category')!
                    .toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w300,
                    )),
          ),
          BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoaded) {
                return GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.categoriesResponse.data!.length <= 6
                      ? state.categoriesResponse.data!.length
                      : 6,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppStyles.GRID_SPACING,
                      childAspectRatio: 1,
                      mainAxisSpacing: AppStyles.GRID_SPACING),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        widget.navigateToNext!(BlocProvider(
                            create: (BuildContext context) {
                              return ProductsByCatBloc(
                                  RealProductsRepo(),
                                  BlocProvider.of<CategoriesBloc>(context),
                                  state.categoriesResponse.data![index].id,
                                  "date",
                                  "desc",
                                  "");
                            },
                            child: ShopScreen(
                                state.categoriesResponse.data![index],
                                widget.navigateToNext)));
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(AppStyles.CARD_RADIUS),
                            child: Stack(
                              children: [
                                Center(
                                  child: CachedNetworkImage(
                                    imageUrl: state.categoriesResponse
                                        .data![index].image!.src!,
                                    fit: BoxFit.cover,
                                    height: double.maxFinite,
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        Center(
                                            child: CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress)),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                                // Container(color: Color(0x66000000)),
                                Container(
                                    color: Color(0xFFFFFFFF).withOpacity(0.5)),
                              ],
                            ),
                          ),
                          Text(
                            state.categoriesResponse.data![index].name!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            // style: TextStyle(
                            //     fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w300),
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Color(0xff444444),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (state is CategoriesError)
                return Text(state.error!);
              else
                return Center(
                  child: CircularProgressIndicator(),
                );
            },
          ),
        ],
      ),
    );
  }
}
