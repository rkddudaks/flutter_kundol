import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/blocs/news/news_bloc.dart';
// import 'package:flutter_kundol/blocs/wishlist/wishlist_bloc.dart';
// import 'package:flutter_kundol/blocs/wishlist_detail/wishlist_detail_bloc.dart';
// import 'package:flutter_kundol/constants/app_constants.dart';
// import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
// import 'package:flutter_kundol/ui/widgets/app_bar.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_fav.dart';
// import 'package:flutter_kundol/ui/widgets/card_style_new_1.dart';
import 'package:flutter_kundol/ui/widgets/home_app_bar.dart';
import 'package:flutter_kundol/ui/widgets/news_banner_slider.dart';

class NewsFragment extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final Function() openDrawer;

  const NewsFragment(this.navigateToNext, this.openDrawer);

  @override
  _NewsFragmentState createState() => _NewsFragmentState();
}

class _NewsFragmentState extends State<NewsFragment> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsBloc>(context).add(GetNews());
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
            child: BlocConsumer<NewsBloc, NewsState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is NewsLoaded) {
                  return DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          NewsBannerSlider(widget.navigateToNext,
                              state.newsResponse.featureNews),
                          Expanded(
                            child: Column(
                              children: [
                                TabBar(
                                    isScrollable: true,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.0),
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    indicator: BubbleTabIndicator(
                                      indicatorHeight: 34.0,
                                      indicatorRadius: 12,
                                      indicatorColor:
                                          Theme.of(context).primaryColor,
                                      tabBarIndicatorSize:
                                          TabBarIndicatorSize.tab,
                                    ),
                                    labelStyle: TextStyle(),
                                    unselectedLabelColor:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? AppStyles.COLOR_GREY_DARK
                                            : AppStyles.COLOR_GREY_LIGHT,
                                    tabs: [
                                      Tab(text: "Newest"),
                                      Tab(text: "Categories")
                                    ]),
                                Expanded(
                                  child: TabBarView(children: [
                                    (state.newsResponse.latestNews!.isNotEmpty)
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: state.newsResponse
                                                .latestNews!.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                leading: Container(
                                                  width: 100,
                                                  height: 100,
                                                  child: CachedNetworkImage(
                                                    imageUrl: state
                                                        .newsResponse
                                                        .latestNews![index]
                                                        .slug!,
                                                    fit: BoxFit.cover,
                                                    progressIndicatorBuilder: (context,
                                                            url,
                                                            downloadProgress) =>
                                                        Center(
                                                            child: CircularProgressIndicator(
                                                                value: downloadProgress
                                                                    .progress)),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Container(
                                                            width: double
                                                                .maxFinite,
                                                            child: Image.asset(
                                                                "assets/images/placeholder.png",
                                                                fit: BoxFit
                                                                    .cover)),
                                                  ),
                                                ),
                                                title: Text(state
                                                    .newsResponse
                                                    .latestNews![index]
                                                    .title!
                                                    .rendered!),
                                                subtitle: Text(
                                                    state
                                                        .newsResponse
                                                        .latestNews![index]
                                                        .content!
                                                        .rendered!,
                                                    maxLines: 4,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              );
                                            },
                                          )
                                        : Container(
                                            child: Center(
                                              child: Text("Empty"),
                                            ),
                                          ),
                                    (state.newsResponse.newsCategories!
                                            .isNotEmpty)
                                        ? GridView.builder(
                                            shrinkWrap: true,
                                            itemCount: state.newsResponse
                                                .newsCategories!.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 100,
                                                    height: 100,
                                                    child: CachedNetworkImage(
                                                      imageUrl: state
                                                          .newsResponse
                                                          .newsCategories![
                                                              index]
                                                          .slug!,
                                                      fit: BoxFit.cover,
                                                      progressIndicatorBuilder: (context,
                                                              url,
                                                              downloadProgress) =>
                                                          Center(
                                                              child: CircularProgressIndicator(
                                                                  value: downloadProgress
                                                                      .progress)),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Container(
                                                              width: double
                                                                  .maxFinite,
                                                              child: Image.asset(
                                                                  "assets/images/placeholder.png",
                                                                  fit: BoxFit
                                                                      .cover)),
                                                    ),
                                                  ),
                                                  Text(state
                                                      .newsResponse
                                                      .newsCategories![index]
                                                      .name!),
                                                  Text(state
                                                          .newsResponse
                                                          .newsCategories![
                                                              index]
                                                          .count
                                                          .toString() +
                                                      " Posts")
                                                ],
                                              );
                                            },
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    childAspectRatio: 1.2),
                                          )
                                        : Container(
                                            child: Center(
                                              child: Text("Empty"),
                                            ),
                                          ),
                                  ]),
                                ),
                              ],
                            ),
                          )
                        ],
                      ));
                } else if (state is NewsError) {
                  return Center(child: Text("Error occurred"));
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
