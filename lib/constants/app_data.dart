import 'package:flutter/material.dart';
// import 'package:flutter_kundol/api/responses/settings_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_cart_data.dart';
import 'package:flutter_kundol/api/wooResponses/woo_currencies_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_product/woo_product.dart';
import 'package:flutter_kundol/api/wooResponses/woo_user.dart';
// import 'package:flutter_kundol/models/currency_date.dart';
import 'package:flutter_kundol/models/get_wishlist_on_start_data.dart';
import 'package:flutter_kundol/models/language_data.dart';
import 'package:flutter_kundol/models/user.dart';

import '../api/wooResponses/woo_settings_response.dart';

class AppData {
  static const List<Locale> languages = [Locale('en'), Locale('ar')];
  static List<LanguageData> languagesData = [
    LanguageData.fromData(1, "English", "en"),
    LanguageData.fromData(2, "Arabic", "ar")
  ];
  // static const List<Color> colors = [
  //   Colors.green,
  //   Colors.blue,
  //   Colors.brown,
  //   Colors.white
  // ];

  static const List<Color> colors = [
    Colors.green,
    Colors.blue,
    Colors.brown,
    Colors.blueGrey,
    Colors.blueAccent,
    Colors.cyan,
    Colors.teal,
    Colors.deepPurple,
    Colors.orangeAccent,
    Colors.lime,
    Colors.pink,
    Colors.grey,
    Colors.indigoAccent,
    Colors.black,
    Colors.greenAccent
  ];

  static const List itemss = [
    "assets/images/1.png",
    "assets/images/2.png",
    "assets/images/3.png",
    "assets/images/4.png",
    "assets/images/5.png",
    "assets/images/6.png",
    "assets/images/7.png",
    "assets/images/8.png",
    "assets/images/9.png",
  ];

  static const List category = [
    "assets/images/category1.png",
    "assets/images/category2.png",
    "assets/images/category3.png",
    "assets/images/category4.png",
    "assets/images/category5.png",
    "assets/images/category6.png",
  ];

  static const List card = [
    "assets/images/cardstyle1.png",
    "assets/images/cardstyle2.png",
    "assets/images/cardstyle3.png",
    "assets/images/cardstyle4.png",
    "assets/images/cardstyle5.png",
    "assets/images/cardstyle6.png",
    "assets/images/cardstyle7.png",
    "assets/images/cardstyle8.png",
    "assets/images/cardstyle9.png",
    "assets/images/cardstyle10.png",
    "assets/images/cardstyle11.png",
    "assets/images/cardstyle12.png",
    "assets/images/cardstyle13.png",
    "assets/images/cardstyle14.png",
    "assets/images/cardstyle15.png",
    "assets/images/cardstyle16.png",
    "assets/images/cardstyle17.png",
    "assets/images/cardstyle18.png",
    "assets/images/cardstyle19.png",
    "assets/images/cardstyle20.png",
    "assets/images/cardstyle21.png",
    "assets/images/cardstyle22.png",
    "assets/images/cardstyle23.png",
    "assets/images/cardstyle24.png",
    "assets/images/cardstyle25.png",
    "assets/images/cardstyle26.png",
    "assets/images/cardstyle27.png",
    "assets/images/cardstyle28.png",
  ];

  static const int defaultColor = 0;
  static const bool isDefaultDark = false;

  static late WooCurrency currency;
  static late LanguageData language;
  static late WooSettingsResponse settingsResponse;
  static User? user;
  static WooUser? wooUser;
  static String? accessToken;
  static String? sessionId;
  static List<GetWishlistOnStartData> wishlistData = [];
  static List<WooCartData?> cartItems = [];
  static List<WooProduct?> favProducts = [];
}
