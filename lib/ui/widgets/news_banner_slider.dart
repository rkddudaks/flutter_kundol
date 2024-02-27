import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/api/api_provider.dart';
// import 'package:flutter_kundol/api/responses/settings_response.dart';
// import 'package:flutter_kundol/api/wooResponses/woo_banner_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_news_response.dart';
import 'package:flutter_kundol/blocs/banners/banners_bloc.dart';
// import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
// import 'package:flutter_kundol/blocs/detail_screen/detail_screen_bloc.dart';
// import 'package:flutter_kundol/blocs/products_by_category/products_by_cat_bloc.dart';
// import 'package:flutter_kundol/constants/app_constants.dart';
// import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
// import 'package:flutter_kundol/models/banners/banner.dart';
// import 'package:flutter_kundol/models/category.dart';
// import 'package:flutter_kundol/models/products/product.dart';
// import 'package:flutter_kundol/repos/cart_repo.dart';
// import 'package:flutter_kundol/repos/products_repo.dart';

// import '../../api/wooResponses/woo_categories_response.dart';
// import '../detail_screen.dart';
// import '../shop_screen.dart';

class NewsBannerSlider extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final List<WooNewsData>? featureNews;

  NewsBannerSlider(this.navigateToNext, this.featureNews);

  @override
  _NewsBannerSliderState createState() => _NewsBannerSliderState();
}

class _NewsBannerSliderState extends State<NewsBannerSlider> {
  int _currentIndex = 0;

  BannersBloc? bannersBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.featureNews!.isNotEmpty)
      return ClipRRect(
        borderRadius: BorderRadius.circular(AppStyles.CARD_RADIUS),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            AspectRatio(
              aspectRatio: 1.4 / 1,
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  initialPage: 0,
                  height: 260,
                  autoPlayInterval: Duration(seconds: 5),
                  enlargeCenterPage: false,
                  autoPlayAnimationDuration: Duration(milliseconds: 500),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: false,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.maxFinite,
                        child: CachedNetworkImage(
                          imageUrl: widget.featureNews![index].slug!,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress)),
                          errorWidget: (context, url, error) => Container(
                              width: double.maxFinite,
                              child: Image.asset(
                                  "assets/images/placeholder.png",
                                  fit: BoxFit.cover)),
                        ),
                      ));
                },
                itemCount: widget.featureNews!.length,
              ),
            ),
            Container(
              height: 50.0,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: EdgeInsets.symmetric(vertical: 12, horizontal: 2.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? Colors.white54
                          : Colors.transparent,
                    ),
                  );
                },
                itemCount: widget.featureNews!.length,
              ),
            ),
          ],
        ),
      );
    else
      return Text("Empty");
  }
}
