import 'dart:async';
// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/api/responses/settings_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_cart_data.dart';
import 'package:flutter_kundol/api/wooResponses/woo_currencies_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_user.dart';
import 'package:flutter_kundol/blocs/auth/auth_bloc.dart';
import 'package:flutter_kundol/blocs/language/language_bloc.dart';
import 'package:flutter_kundol/blocs/currency/currency_bloc.dart';
import 'package:flutter_kundol/blocs/server_settings/server_settings_bloc.dart';
import 'package:flutter_kundol/constants/app_data.dart';
// import 'package:flutter_kundol/models/currency_date.dart';
import 'package:flutter_kundol/models/language_data.dart';
// import 'package:flutter_kundol/models/user.dart';
// import 'package:flutter_kundol/tweaks/shared_pref_service.dart';
import 'package:hive/hive.dart';
import 'dart:developer' as developer;

import '../../constants/app_constants.dart';
import '../main_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late ServerSettingsBloc serverSettingsBloc;

  @override
  void initState() {
    super.initState();

    checkIfUserLoggedIn();

    getCart();

    // ignore: close_sinks
    serverSettingsBloc = BlocProvider.of<ServerSettingsBloc>(context);
    serverSettingsBloc.add(GetServerSettings());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ServerSettingsBloc, ServerSettingsState>(
      listener: (context, state) {
        if (state is ServerSettingsLoaded) {
          AppData.settingsResponse = state.settingsResponse;
/*
          AppData.settingsResponse.setKeyValue(SettingsResponse.HOME_STYLE, AppData.settingsResponse.getKeyValue(SettingsResponse.HOME_STYLE).replaceAll(new RegExp(r'[^0-9]'),''));
          AppData.settingsResponse.setKeyValue(SettingsResponse.CATEGORY_STYLE, AppData.settingsResponse.getKeyValue(SettingsResponse.CATEGORY_STYLE).replaceAll(new RegExp(r'[^0-9]'),''));
          AppData.settingsResponse.setKeyValue(SettingsResponse.BANNER_STYLE, AppData.settingsResponse.getKeyValue(SettingsResponse.BANNER_STYLE).replaceAll(new RegExp(r'[^0-9]'),''));
          AppData.settingsResponse.setKeyValue(SettingsResponse.CARD_STYLE, AppData.settingsResponse.getKeyValue(SettingsResponse.CARD_STYLE).replaceAll(new RegExp(r'[^0-9]'),''));
*/

          WooCurrency currencyData = WooCurrency();

          currencyData.name = AppData.settingsResponse.currency!.name;
          currencyData.symbol = AppData.settingsResponse.currency!.name;
/*
          currencyData.title = AppData.settingsResponse.getKeyValue(SettingsResponse.CURRENCY_CODE).trim();
          currencyData.currencyId = int.parse(AppData.settingsResponse.getKeyValue(SettingsResponse.CURRENCY_ID).toString());
          currencyData.code = AppData.settingsResponse.getKeyValue(SettingsResponse.CURRENCY_SYMBOL).trim();
*/

          BlocProvider.of<CurrencyBloc>(context)
              .add(CurrencyLoadServer(currencyData));

          LanguageData languageData = LanguageData();

          languageData.languageName = "English";
          // AppData.settingsResponse.language!.nativeName;
          // languageData.id = int.parse(AppData.settingsResponse.language!.id!);
          languageData.id = 1;
          languageData.code = "en";
          // languageData.code =AppData.settingsResponse.language!.code;

/*
          languageData.languageName = AppData.settingsResponse.getKeyValue(SettingsResponse.LANGUAGE_CODE).toUpperCase().trim();
          languageData.id = int.parse(AppData.settingsResponse.getKeyValue(SettingsResponse.LANGUAGE_ID).toString());
          languageData.code = AppData.settingsResponse.getKeyValue(SettingsResponse.LANGUAGE_CODE).toLowerCase().trim();
*/

          BlocProvider.of<LanguageBloc>(context)
              .add(LanguageLoadServer(languageData));

          Future.microtask(() => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (BuildContext context) => MainScreen())));
        } else if (state is ServerSettingsError) {
          showSnackbar(context, state.error!);
        }
      },
      child: ScreenUi(),
    );
  }

  void showSnackbar(context, String error) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
          content: Text(error),
          duration: Duration(days: 1),
        ))
        .closed
        .then((reason) {
      if (reason == SnackBarClosedReason.swipe) showSnackbar(context, error);
    });
  }

  Future<void> checkIfUserLoggedIn() async {
    var box = await Hive.openBox<WooUser>(AppConstants.TBL_USER);
    if (box.values.isNotEmpty) {
      AppData.wooUser = box.values.toList().first;
      BlocProvider.of<AuthBloc>(context).add(PerformAutoLogin(AppData.wooUser));
    }
/*
    final sharedPrefService = await SharedPreferencesService.instance;
    int userId = sharedPrefService.userId;
    if (userId != null) {
      User user = User();
      user.id = userId;
      user.firstName = sharedPrefService.userFirstName;
      user.lastName = sharedPrefService.userLastName;
      user.email = sharedPrefService.userEmail;
      user.token = sharedPrefService.userToken;
      AppData.user = user;
      AppData.accessToken = user.token;
      BlocProvider.of<AuthBloc>(context).add(PerformAutoLogin(user));
    }
*/
  }

  void getCart() async {
    try {
      var box = await Hive.openBox<WooCartData>(AppConstants.TBL_CART);
      developer.log("Hivedata");
      developer.log(box.toString());
      AppData.cartItems = box.values.toList();
      // developer.log(AppData.cartItems[0]!.productType!.toString());
      developer.log(AppData.cartItems.toString());
    } catch (e) {}
  }
}

class ScreenUi extends StatelessWidget {
  const ScreenUi({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            "assets/images/splash.png",
            fit: BoxFit.cover,
          ),
          /*child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100.0,
                        height: 100.0,
                        child: Image.asset(
                          "assets/images/icon.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Text(
                        "Flutter Ecommerce",
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 25),
                        child: CircularProgressIndicator(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 50),
                        child: Text("By Themes Coder"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),*/
        ),
      ),
    );
  }
}
