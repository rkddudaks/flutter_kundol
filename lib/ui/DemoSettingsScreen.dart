import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/api/responses/settings_response.dart';
import 'package:flutter_kundol/constants/app_data.dart';

import '../blocs/currency/currency_bloc.dart';
import '../blocs/get_currencies/get_currency_bloc.dart';
import '../blocs/get_languages/get_language_bloc.dart';
import '../blocs/language/language_bloc.dart';
import '../blocs/theme/theme_bloc.dart';
import '../main.dart';
// import '../repos/get_language_repo.dart';
import '../tweaks/app_localization.dart';
// import 'language_screen.dart';

class DemoSettingsScreen extends StatefulWidget {
  const DemoSettingsScreen({Key? key}) : super(key: key);

  @override
  _DemoSettingsScreenState createState() => _DemoSettingsScreenState();
}

class _DemoSettingsScreenState extends State<DemoSettingsScreen> {
  late GetLanguageBloc languageBloc;
  late GetCurrenciesBloc currencyBloc;
  @override
  void initState() {
    super.initState();
    languageBloc = BlocProvider.of<GetLanguageBloc>(context);
    languageBloc.add(GetLanguages());
    currencyBloc = BlocProvider.of<GetCurrenciesBloc>(context);
    currencyBloc.add(GetCurrencies());
  }

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
        title: Text("Settings", style: Theme.of(context).textTheme.titleLarge),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.black26,
              child: Center(
                child: Text(
                  "Change App Theme",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              height: 0,
            ),
//               GridView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount:5,
//                   mainAxisExtent: 75,
//                   childAspectRatio: 0.1
//                    ),
//                    itemCount: AppData.colors.length,
//                  itemBuilder: (BuildContext context, index){
//                   return Card(
//                       shape: RoundedRectangleBorder(
//                         side: BorderSide(
//                             color: (AppData.settingsResponse.bannerStyle ==
//                                 (index + 1).toString())
//                                 ? Theme.of(context).accentColor
//                                 : Colors.transparent,
// /*
//                             color: (AppData.settingsResponse.getKeyValue(
//                                         SettingsResponse.CATEGORY_STYLE) ==
//                                     (index + 1).toString())
//                                 ? Theme.of(context).accentColor
//                                 : Colors.transparent,
// */
//                             width: 1),
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       child: Padding(
//                           padding: EdgeInsets.all(4.0),
//                           child: Center(
//                               child: Text(
//                             "Style " + (index + 1).toString(),
//                             textAlign: TextAlign.center,
//                             style: TextStyle(fontSize: 12),
//                           ))),
//                     );
//                  }
//                  ),
            SizedBox(
              height: 10,
            ),
            GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: AppData.colors.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisExtent: 75,
                    childAspectRatio: 0.1),
                itemBuilder: (BuildContext context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        // ignore: unnecessary_statements
                        AppData.settingsResponse.bannerStyle =
                            (index + 1).toString();
                        BlocProvider.of<ThemeBloc>(context).add(
                          ThemeColorChanged(index),
                        );
                      });
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: (AppData.settingsResponse.bannerStyle ==
                                    (index + 1).toString())
                                ? Theme.of(context).colorScheme.secondary
                                : Colors.transparent,
                            width: 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          color: AppData.colors[index],
                        ),
                      ),
                    ),
                  );
                }),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.black26,
              child: Center(
                child: Text(
                  "Change Color Mode",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) => SwitchListTile(
                activeColor: Theme.of(context).primaryColor,
                contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                title: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(
                      AppLocalizations.of(context)!.translate('dark_mode')!,
                      style: TextStyle(fontSize: 16),
                    )),
                value: state.themeData.brightness == Brightness.dark
                    ? true
                    : false,
                onChanged: (value) {
                  BlocProvider.of<ThemeBloc>(context)
                      .add(ThemeModeChanged(value));
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.black26,
              child: Center(
                child: Text(
                  "Multi Language",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),

            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder(
                bloc: languageBloc,
                builder: (BuildContext context, state1) {
                  if (state1 is GetLanguageLoaded) {
                    return BlocBuilder<LanguageBloc, LanguageState>(
                      builder: (context, state) => Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Container(
                            width: double.maxFinite,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Theme.of(context).cardColor
                                    : Colors.white,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<LanguageBloc>(context).add(
                                        LanguageSelected(state1
                                            .languageResponse.data![index]));
                                    RestartWidget.restartApp(context);
                                  },
                                  child: state1.languageResponse.data![index]
                                              .code
                                              ?.toLowerCase()
                                              .trim() ==
                                          state.languageData.code
                                              ?.toLowerCase()
                                              .trim()
                                      ? Container(
                                          padding: const EdgeInsets.all(10),
                                          color: Theme.of(context).primaryColor,
                                          child: Text(
                                            "${state1.languageResponse.data![index].languageName} (${state1.languageResponse.data![index].code})",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        )
                                      : Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                              "${state1.languageResponse.data![index].languageName} (${state1.languageResponse.data![index].code})"),
                                        ),
                                );
                              },
                              itemCount: state1.languageResponse.data?.length,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (state1 is GetLanguageError) {
                    return Text(state1.error);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? Theme.of(context).primaryColorLight
                                : Theme.of(context).primaryColor,
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.black26,
              child: Center(
                child: Text(
                  "Multi Currency",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder(
                bloc: currencyBloc,
                builder: (BuildContext context, dynamic state1) {
                  if (state1 is GetCurrencyLoaded)
                    return BlocBuilder<CurrencyBloc, CurrencyState>(
                      // builder: (context, state) => ListView.builder(
                      //   physics: NeverScrollableScrollPhysics(),
                      //   shrinkWrap: true,
                      //   itemBuilder: (context, index) {
                      //     return ListTile(
                      //       onTap: () {
                      //         BlocProvider.of<CurrencyBloc>(context).add(
                      //             CurrencySelected(state1
                      //                 .currenciesResponse.data[index]));
                      //         RestartWidget.restartApp(context);
                      //       },
                      //       title:
                      //       Text(state1.currenciesResponse.data[index].title),
                      //       subtitle: Text(state1.currenciesResponse.data[index].code),
                      //       trailing: Icon((state1.currenciesResponse.data[index].currencyId == state.currency.currencyId)
                      //           ? Icons.radio_button_on
                      //           : Icons.radio_button_off),
                      //     );
                      //   },
                      //   itemCount: state1.currenciesResponse.data.length,
                      // ),
                      builder: (context, state) => Container(
                        margin: EdgeInsets.all(15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            width: double.maxFinite,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Theme.of(context).cardColor
                                    : Colors.white,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<CurrencyBloc>(context).add(
                                        CurrencySelected(state1
                                            .currenciesResponse.data![index]));
                                    RestartWidget.restartApp(context);
                                  },
                                  child: state1.currenciesResponse.data![index]
                                              .symbol ==
                                          state.currency.symbol
                                      ? Container(
                                          padding: EdgeInsets.all(10),
                                          color: Theme.of(context).primaryColor,
                                          child: Text(
                                            state1.currenciesResponse
                                                .data![index].name!,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )
                                      : Container(
                                          padding: EdgeInsets.all(10),
                                          child: Text(state1.currenciesResponse
                                              .data![index].name!),
                                        ),
                                );
                              },
                              itemCount: state1.currenciesResponse.data!.length,
                            ),
                          ),
                        ),
                      ),
                    );
                  else if (state1 is GetLanguageError)
                    return Text(state1.error);
                  else
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.black26,
              child: Center(
                child: Text(
                  "Home Page Style",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisExtent: 300,
                  childAspectRatio: 0.5),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      AppData.settingsResponse.homeStyle =
                          (index + 1).toString();
/*
                      AppData.settingsResponse.setKeyValue(
                          SettingsResponse.HOME_STYLE,
                          (index + 1).toString());
*/
                    });
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: (AppData.settingsResponse.homeStyle ==
                                  (index + 1).toString())
                              ? Theme.of(context).colorScheme.secondary
                              : Colors.transparent,
/*
                          color: (AppData.settingsResponse.getKeyValue(
                                      SettingsResponse.HOME_STYLE) ==
                                  (index + 1).toString())
                              ? Theme.of(context).accentColor
                              : Colors.transparent,
*/
                          width: 1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Image.asset(
                        AppData.itemss[index],
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.black26,
              child: Center(
                child: Text(
                  "Category Page Style",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisExtent: 300,
                  childAspectRatio: 0.5),
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      AppData.settingsResponse.categoryStyle =
                          (index + 1).toString();
/*
                      AppData.settingsResponse.setKeyValue(
                          SettingsResponse.CATEGORY_STYLE,
                          (index + 1).toString());
*/
                    });
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: (AppData.settingsResponse.categoryStyle ==
                                  (index + 1).toString())
                              ? Theme.of(context).colorScheme.secondary
                              : Colors.transparent,
/*
                          color: (AppData.settingsResponse.getKeyValue(
                                      SettingsResponse.CATEGORY_STYLE) ==
                                  (index + 1).toString())
                              ? Theme.of(context).accentColor
                              : Colors.transparent,
*/
                          width: 1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Image.asset(
                        AppData.category[index],
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.black26,
              child: Center(
                child: Text(
                  "Banner Style",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1),
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      AppData.settingsResponse.bannerStyle =
                          (index + 1).toString();
/*
                      AppData.settingsResponse.setKeyValue(
                          SettingsResponse.BANNER_STYLE,
                          (index + 1).toString());
*/
                    });
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: (AppData.settingsResponse.bannerStyle ==
                                  (index + 1).toString())
                              ? Theme.of(context).colorScheme.secondary
                              : Colors.transparent,
/*
                          color: (AppData.settingsResponse.getKeyValue(
                              SettingsResponse.BANNER_STYLE) ==
                              (index + 1).toString())
                              ? Theme.of(context).accentColor
                              : Colors.transparent,
*/
                          width: 1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Center(
                            child: Text(
                          "Style " + (index + 1).toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ))),
                  ),
                );
              },
            ),

            SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.black26,
              child: Center(
                child: Text(
                  "Product Card Style",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisExtent: 200,
                  childAspectRatio: 0.5),
              itemCount: 27,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      AppData.settingsResponse.cardStyle =
                          (index + 1).toString();
/*
                      AppData.settingsResponse.setKeyValue(
                          SettingsResponse.CARD_STYLE,
                          (index + 1).toString());
*/
                    });
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: (AppData.settingsResponse.cardStyle ==
                                  (index + 1).toString())
                              ? Theme.of(context).colorScheme.secondary
                              : Colors.transparent,
/*
                          color: (AppData.settingsResponse.getKeyValue(
                                      SettingsResponse.CARD_STYLE) ==
                                  (index + 1).toString())
                              ? Theme.of(context).accentColor
                              : Colors.transparent,
*/
                          width: 1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Image.asset(
                        AppData.card[index],
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
