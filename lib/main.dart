import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/wooResponses/woo_cart_data.dart';
import 'package:flutter_kundol/api/wooResponses/woo_currencies_response.dart';
// import 'package:flutter_kundol/api/wooResponses/woo_currencies_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_product/woo_product.dart';
import 'package:flutter_kundol/api/wooResponses/woo_product/woo_product_attributes.dart';
import 'package:flutter_kundol/api/wooResponses/woo_product/woo_product_categories.dart';
import 'package:flutter_kundol/api/wooResponses/woo_product/woo_product_dimensions.dart';
import 'package:flutter_kundol/api/wooResponses/woo_product/woo_product_images.dart';
import 'package:flutter_kundol/api/wooResponses/woo_user.dart';
import 'package:flutter_kundol/api/wooResponses/woo_user_billing.dart';
import 'package:flutter_kundol/api/wooResponses/woo_user_shipping.dart';
import 'package:flutter_kundol/api/wooResponses/woo_variations/woo_variation_image.dart';
import 'package:flutter_kundol/api/wooResponses/woo_variations/woo_variations_attributes.dart';
import 'package:flutter_kundol/api/wooResponses/woo_variations/woo_variations_response.dart';
import 'package:flutter_kundol/blocs/auth/auth_bloc.dart';
import 'package:flutter_kundol/blocs/banners/banners_bloc.dart';
import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
import 'package:flutter_kundol/blocs/currency/currency_bloc.dart';
import 'package:flutter_kundol/blocs/detail_screen/detail_screen_bloc.dart';
import 'package:flutter_kundol/blocs/filters/filters_bloc.dart';
import 'package:flutter_kundol/blocs/news/news_bloc.dart';
import 'package:flutter_kundol/blocs/products/products_bloc.dart';
import 'package:flutter_kundol/blocs/shipping_method/shipping_methods_bloc.dart';
import 'package:flutter_kundol/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_kundol/blocs/wishlist_detail/wishlist_detail_bloc.dart';
// import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/language_data.dart';
import 'package:flutter_kundol/repos/auth_repo.dart';
import 'package:flutter_kundol/repos/banners_repo.dart';
import 'package:flutter_kundol/repos/cart_repo.dart';
import 'package:flutter_kundol/repos/categories_repo.dart';
import 'package:flutter_kundol/repos/filters_repo.dart';
import 'package:flutter_kundol/repos/news_repo.dart';
import 'package:flutter_kundol/repos/payment_methods_repo.dart';
import 'package:flutter_kundol/blocs/payment_methods/payment_methods_bloc.dart';
import 'package:flutter_kundol/repos/products_repo.dart';
import 'package:flutter_kundol/repos/profile_repo.dart';
import 'package:flutter_kundol/repos/settings_repo.dart';
import 'package:flutter_kundol/blocs/theme/theme_bloc.dart';
import 'package:flutter_kundol/repos/shipping_methods_repo.dart';
import 'package:flutter_kundol/repos/wishlist_repo.dart';
import 'package:flutter_kundol/ui/screens/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:hive/hive.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'blocs/profile/update_profile_bloc.dart';
import 'blocs/server_settings/server_settings_bloc.dart';
import 'constants/app_data.dart';
// import 'models/currency_date.dart';
import 'tweaks/app_localization.dart';
import 'blocs/language/language_bloc.dart';
// import 'package:hive/hive.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:developer' as developer;

// test commit
void main() async {
  await Hive.initFlutter();
  //debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Directory directory = await getApplicationDocumentsDirectory();
  Hive
    ..init(directory.path)
    ..registerAdapter(WooCartDataAdapter())
    ..registerAdapter(WooProductAdapter())
    ..registerAdapter(WooProductAttributesAdapter())
    ..registerAdapter(WooProductCategoriesAdapter())
    ..registerAdapter(WooProductDimensionsAdapter())
    ..registerAdapter(WooProductImagesAdapter())
    ..registerAdapter(WooVariationsResponseAdapter())
    ..registerAdapter(WooVariationImageAdapter())
    ..registerAdapter(WooVariationsAttributesAdapter())
    ..registerAdapter(WooUserAdapter())
    ..registerAdapter(WooUserBillingAdapter())
    ..registerAdapter(WooUserShippingAdapter());

  //Remove this method to stop OneSignal Debugging
  // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  // OneSignal.shared.setAppId("18561adc-8032-4530-bd19-bbd79a3a0e78");

  //The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  // OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
  //   developer.log("Accepted permission: $accepted");
  // });

  runApp(RestartWidget(
    child: MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          LanguageData languageData = LanguageData();
          languageData.languageName = "English";
          languageData.id = 1;
          languageData.code = "en";

          return LanguageBloc(languageData)..add(LanguageLoadStarted());
        }),
        BlocProvider(
          create: (context) {
            WooCurrency currencyData = WooCurrency();

            currencyData.name = "USD";
            //currencyData.currencyId = 1;
            currencyData.symbol = "USD";

            return CurrencyBloc(currencyData)..add(CurrencyLoadStarted());
          },
        ),
        BlocProvider(create: (context) => ThemeBloc()..add(ThemeLoadStarted())),
        BlocProvider(create: (context) => BannersBloc(RealBannersRepo())),
        BlocProvider(create: (context) => CategoriesBloc(RealCategoriesRepo())),
        BlocProvider(create: (context) => ProductsBloc(RealProductsRepo())),
        BlocProvider(create: (context) => AuthBloc(RealAuthRepo())),
        BlocProvider(create: (context) => CartBloc(RealCartRepo())),
        BlocProvider(
            create: (context) =>
                DetailScreenBloc(RealCartRepo(), RealProductsRepo())),
        BlocProvider(
          create: (context) => WishlistProductsBloc(RealWishlistRepo()),
        ),
        BlocProvider(
          create: (context) => WishlistBloc(RealWishlistRepo(),
              BlocProvider.of<WishlistProductsBloc>(context)),
        ),
        BlocProvider(
          create: (context) => FiltersBloc(RealFiltersRepo()),
        ),
        BlocProvider(create: (context) => ProfileBloc(RealProfileRepo())),
        BlocProvider(
            create: (context) => PaymentMethodsBloc(RealPaymentMethodsRepo())),
        BlocProvider(
            create: (context) =>
                ShippingMethodsBloc(RealShippingMethodsRepo())),
        BlocProvider(create: (context) => NewsBloc(RealNewsRepo())),
      ],
      child: MyApp(),
    ),
  ));
}

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget? child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child!,
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyBloc, CurrencyState>(
      builder: (context, currencyState) {
        AppData.currency = currencyState.currency;
        return BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, languageState) {
            AppData.language = languageState.languageData;
            return BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, themeState) {
                return MaterialApp(
                  locale: Locale(languageState.languageData.code!),
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    AppLocalizations.delegate,
                  ],
                  theme: themeState.themeData,
                  supportedLocales: AppData.languages,
                  home: AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      systemNavigationBarColor: Colors.black,
                      statusBarIconBrightness: Brightness.dark,
                      systemNavigationBarIconBrightness: Brightness.dark,
                    ),
                    child: BlocProvider(
                      create: (context) =>
                          ServerSettingsBloc(RealServerSettingsRepo()),
                      child: SplashScreen(),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
