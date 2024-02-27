import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_kundol/api/responses/add_address_response.dart';
import 'package:flutter_kundol/api/responses/add_review_response.dart';
// import 'package:flutter_kundol/api/responses/banners_response.dart';
import 'package:flutter_kundol/api/responses/cart_response.dart';
// import 'package:flutter_kundol/api/responses/categories_response.dart';
import 'package:flutter_kundol/api/responses/contact_us_response.dart';
import 'package:flutter_kundol/api/responses/countries_response.dart';
import 'package:flutter_kundol/api/responses/currencies_response.dart';
import 'package:flutter_kundol/api/responses/delete_address_response.dart';
import 'package:flutter_kundol/api/responses/delete_cart_response.dart';
import 'package:flutter_kundol/api/responses/filters_response.dart';
import 'package:flutter_kundol/api/responses/forgot_password_response.dart';
import 'package:flutter_kundol/api/responses/get_address_response.dart';
import 'package:flutter_kundol/api/responses/get_page_response.dart';
import 'package:flutter_kundol/api/responses/get_wishlist_on_start_response.dart';
import 'package:flutter_kundol/api/responses/languages_response.dart';
import 'package:flutter_kundol/api/responses/login_response.dart';
import 'package:flutter_kundol/api/responses/logout_response.dart';
import 'package:flutter_kundol/api/responses/order_place_response.dart';
import 'package:flutter_kundol/api/responses/orders_response.dart';
import 'package:flutter_kundol/api/responses/payment_method_response.dart';
import 'package:flutter_kundol/api/responses/product_detail_response.dart';
import 'package:flutter_kundol/api/responses/products_response.dart';
import 'package:flutter_kundol/api/responses/quantity_response.dart';
import 'package:flutter_kundol/api/responses/redeem_response.dart';
// import 'package:flutter_kundol/api/responses/register_response.dart';
import 'package:flutter_kundol/api/responses/reviews_response.dart';
import 'package:flutter_kundol/api/responses/reward_point_response.dart';
// import 'package:flutter_kundol/api/responses/settings_response.dart';
import 'package:flutter_kundol/api/responses/update_profile_response.dart';
import 'package:flutter_kundol/api/responses/wishlist_detail_response.dart';
import 'package:flutter_kundol/api/responses/woo_countries_response.dart';
import 'package:flutter_kundol/api/wooResponses/WooPaymentMethod.dart';
import 'package:flutter_kundol/api/wooResponses/woo_banner_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_categories_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_checkout_params.dart';
import 'package:flutter_kundol/api/wooResponses/woo_coupon.dart';
import 'package:flutter_kundol/api/wooResponses/woo_currencies_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_fb_login_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_filter.dart';
import 'package:flutter_kundol/api/wooResponses/woo_location.dart';
import 'package:flutter_kundol/api/wooResponses/woo_login_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_news_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_order.dart';
import 'package:flutter_kundol/api/wooResponses/woo_order_detail.dart';
import 'package:flutter_kundol/api/wooResponses/woo_product_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_register_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_reviews_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_reward_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_settings_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_shipping_method.dart';
import 'package:flutter_kundol/api/wooResponses/woo_user.dart';
import 'package:flutter_kundol/api/wooResponses/woo_variation.dart';
import 'package:flutter_kundol/api/wooResponses/woo_variations/woo_variations_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_zone.dart';
// import 'package:flutter_kundol/blocs/address/address_bloc.dart';
import 'package:flutter_kundol/constants/app_config.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/models/add_to_cart/add_to_cart.dart';
import 'package:flutter_kundol/models/address_data.dart';
import 'package:flutter_kundol/models/coupon_response.dart';
// import 'package:flutter_kundol/models/language_data.dart';
// import 'package:flutter_kundol/models/wishlistDetailData.dart';

import 'logging_interceptor.dart';
import 'woocommerce/woocommerce_api.dart';
import 'dart:developer' as developer;

class ApiProvider {
  final String _baseUrl = AppConfig.ECOMMERCE_URL + "/api/client/";
  final String _wpBaseUrl = AppConfig.WOO_ECOMMERCE_URL + "/wp-json/wp/";

  static final String imgThumbnailUrlString =
      AppConfig.ECOMMERCE_URL + "/gallary/thumbnail";
  static final String imgMediumUrlString =
      AppConfig.ECOMMERCE_URL + "/gallary/medium";
  static final String imgLargeUrlString =
      AppConfig.ECOMMERCE_URL + "/gallary/large";

  late Dio _dio;
  late WooCommerceAPI wooCommerceAPI;

  ApiProvider() {
    BaseOptions options = BaseOptions(
        receiveTimeout: 30000,
        connectTimeout: 30000,
        validateStatus: (status) => true,
        followRedirects: false);
    _dio = Dio(options);
    _dio.options.headers.addAll({
      'clientid': AppConfig.CONSUMER_KEY,
      'clientsecret': AppConfig.CONSUMER_SECRET,
      'content-type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'authorization': AppData.accessToken == null
          ? ""
          : 'Bearer ' + AppData.accessToken.toString(),
    });
    // developer.log("ApiProvider: " + _dio.options.headers.toString());
    _dio.interceptors.add(LoggingInterceptor());

    wooCommerceAPI = WooCommerceAPI(
        url: AppConfig.WOO_ECOMMERCE_URL,
        consumerKey: AppConfig.WOO_CONSUMER_KEY,
        consumerSecret: AppConfig.WOO_CONSUMER_SECRET);
  }

  Future<WooSettingsResponse> getWooSettings() async {
    try {
      Response response = await _dio.get(AppConfig.WOO_ECOMMERCE_URL +
          "/wp-json/api/tc_settings/app_all_settings");
      return WooSettingsResponse.fromJson(response.data);
    } catch (error) {
      return WooSettingsResponse.withError(_handleError(error));
    }
  }

  Future<WooBannerResponse> getWooBanners() async {
    try {
      Response response = await _dio.get(AppConfig.WOO_ECOMMERCE_URL +
          "/wp-json/api/tc_settings/app_all_banners?status=publish");
      return WooBannerResponse.fromJson(response.data);
    } catch (error) {
      return WooBannerResponse.withError(_handleError(error));
    }
  }

  Future<WooCategoriesResponse> getWooCategories() async {
    try {
      var response = await wooCommerceAPI.getAsync(
          "products/categories?per_page=100&hide_empty=true&lang=${AppData.language.code}&currency=${AppData.currency.name}");
      return WooCategoriesResponse.fromJson(response);
    } catch (error) {
      return WooCategoriesResponse.withError(_handleError(error));
    }
  }

  Future<WooProductsResponse> getWooProducts(int? pageNo) async {
    try {
      var response = await wooCommerceAPI.getAsync(
          "products?per_page=10&status=publish&page=$pageNo&lang=${AppData.language.code}&currency=${AppData.currency.name}");
      return WooProductsResponse.fromJson(response);
    } catch (error) {
      return WooProductsResponse.withError(_handleError(error));
    }
  }

  Future<WooProductsResponse> getWooGroupedProducts(
      List<int?> productIds) async {
    try {
      var response = await wooCommerceAPI.getAsync(
          "products?per_page=${productIds.length}&status=publish&include=${productIds.join(",")}&lang=${AppData.language.code}&currency=${AppData.currency.name}");
      return WooProductsResponse.fromJson(response);
    } catch (error) {
      return WooProductsResponse.withError(_handleError(error));
    }
  }

  Future<WooProductsResponse> getWooTopSellingProducts(int? pageNo) async {
    try {
      var response = await wooCommerceAPI.getAsync(
          "products?per_page=10&orderby=date&status=publish&page=$pageNo&lang=${AppData.language.code}&currency=${AppData.currency.name}");
      return WooProductsResponse.fromJson(response);
    } catch (error) {
      return WooProductsResponse.withError(_handleError(error));
    }
  }

  Future<WooProductsResponse> getWooDealsProducts(int? pageNo) async {
    try {
      var response = await wooCommerceAPI.getAsync(
          "products?per_page=10&on_sale=true&status=publish&page=$pageNo&lang=${AppData.language.code}&currency=${AppData.currency.name}");
      return WooProductsResponse.fromJson(response);
    } catch (error) {
      return WooProductsResponse.withError(_handleError(error));
    }
  }

  Future<WooProductsResponse> getWooFeaturedProducts(int? pageNo) async {
    try {
      var response = await wooCommerceAPI.getAsync(
          "products?per_page=10&featured=true&status=publish&page=$pageNo&lang=${AppData.language.code}&currency=${AppData.currency.name}");
      return WooProductsResponse.fromJson(response);
    } catch (error) {
      return WooProductsResponse.withError(_handleError(error));
    }
  }

  Future<List<WooCoupon>> getWooCoupon(String code) async {
    try {
      List<WooCoupon> _data = [];
      var response = await wooCommerceAPI.getAsync(
          "coupons?code=$code&status=publish&lang=${AppData.language.code}&currency=${AppData.currency.name}");
      if (response != null) {
        response.forEach((v) {
          _data.add(new WooCoupon.fromJson(v));
        });
      }
      return _data;
    } catch (error) {
      return [];
    }
  }

  Future<ProductDetailResponse> getProductById(int productId) async {
    try {
      Response response = await _dio.get(_baseUrl +
          "products/" +
          productId.toString() +
          "?getCategory=1&getDetail=1&language_id=${AppData.language.id}&currency=1&stock=1");
      return ProductDetailResponse.fromJson(response.data);
    } catch (error) {
      return ProductDetailResponse.withError(_handleError(error));
    }
  }

  Future<WooProductsResponse> getWooSearchProducts(
      String? keyword, int? pageNo) async {
    try {
      var response = await wooCommerceAPI.getAsync(
          "products?per_page=10&status=publish&page=$pageNo&search=$keyword&lang=${AppData.language.code}&currency=${AppData.currency.name}");
      return WooProductsResponse.fromJson(response);
    } catch (error) {
      return WooProductsResponse.withError(_handleError(error));
    }
  }

  Future<ProductsResponse> getSearchProducts(String keyword, int pageNo) async {
    try {
      Response response = await _dio.get(_baseUrl +
          "products?limit=100&getCategory=1&getDetail=1&language_id=${AppData.language.id}&currency=1&&stock=1&page=" +
          pageNo.toString() +
          "&searchParameter=" +
          keyword);
      return ProductsResponse.fromJson(response.data);
    } catch (error) {
      return ProductsResponse.withError(_handleError(error));
    }
  }

  Future<WooProductsResponse> getWooProductsByCat(
      int? pageNo,
      int? categoryId,
      String? sortBy,
      String? sortType,
      String filters,
      String? attributeSlug,
      String? variationId) async {
    try {
      var response = await wooCommerceAPI.getAsync(
          "products?per_page=10&order=$sortType&status=publish&orderby=$sortBy&page=$pageNo&category=$categoryId&attribute=$attributeSlug&attribute_term=$variationId&lang=${AppData.language.code}&currency=${AppData.currency.name}");
      return WooProductsResponse.fromJson(response);
    } catch (error) {
      return WooProductsResponse.withError(_handleError(error));
    }
  }

  Future<List<WooVariationsResponse>> getWooProductsVariations(
      int? productId) async {
    try {
      List<WooVariationsResponse> _data = [];
      var response = await wooCommerceAPI.getAsync(
          "products/$productId/variations?status=publish&lang=${AppData.language.code}&currency=${AppData.currency.name}");
      if (response != null) {
        response.forEach((v) {
          _data.add(new WooVariationsResponse.fromJson(v));
        });
      }
      return _data;
    } catch (error) {
      return [];
    }
  }

  Future<WooUser> loginUser(String? username, String? password) async {
    try {
      Response response = await _dio.post(
          AppConfig.WOO_ECOMMERCE_URL + "/wp-json/api/tc_user/generate_cookie",
          data: jsonEncode({"username": username, "password": password}));
      WooLoginResponse loginResponse = WooLoginResponse.fromJson(response.data);
      if (loginResponse.user != null) {
        return getWooUserInfo(loginResponse.user!.id, loginResponse.cookie);
      } else {
        return WooUser.withError("Error");
      }
    } catch (error) {
      return WooUser.withError(_handleError(error));
    }
  }

  Future<WooUser> getWooUserInfo(int? uId, String? cookie) async {
    try {
      var response = await wooCommerceAPI.getAsync(
          "customers/$uId?lang=${AppData.language.code}&currency=${AppData.currency.name}");
      return WooUser.fromJson(response, cookie);
    } catch (error) {
      return WooUser.withError(_handleError(error));
    }
  }

  Future<WooUser> loginWithFacebook(String accessToken) async {
    try {
      Response response = await _dio.post(
          AppConfig.WOO_ECOMMERCE_URL + "/wp-json/api/tc_user/fb_connect",
          data: jsonEncode({"access_token": accessToken}));
      WooFbLoginResponse loginResponse =
          WooFbLoginResponse.fromJson(response.data);
      return getWooUserInfo(loginResponse.id, loginResponse.cookie);
    } catch (error) {
      return WooUser.withError(_handleError(error));
    }
  }

  Future<LoginResponse> loginWithGoogle(String accessToken) async {
    try {
      Response response = await _dio.get(_baseUrl +
          "customer_login/google/callback?code=" +
          accessToken +
          "&scope=public_profile&authuser=email&prompt=prompt&fromApp=1");
      return LoginResponse.fromJson(response.data);
    } catch (error) {
      return LoginResponse.withError(_handleError(error));
    }
  }

  Future<WooUser> registerUser(String firstName, String lastName,
      String userName, String email, String password) async {
    try {
      Response response = await _dio.post(
          AppConfig.WOO_ECOMMERCE_URL + "/wp-json/api/tc_user/register",
          data: jsonEncode({
            "first_name": firstName,
            "last_name": lastName,
            "username": userName,
            "email": email,
            "password": password,
            "wpgdprc": "1",
            "register": "Register"
          }));
      WooRegisterResponse wooRegisterResponse =
          WooRegisterResponse.fromJson(response.data);
      return loginUser(
          wooRegisterResponse.userLogin, wooRegisterResponse.userPass);
    } catch (error) {
      return WooUser.withError(_handleError(error));
    }
  }

  Future<LogoutResponse> doLogout() async {
    try {
      Response response = await _dio.post(_baseUrl + "customer_logout");
      return LogoutResponse.fromJson(response.data);
    } catch (error) {
      return LogoutResponse.withError(_handleError(error));
    }
  }

  Future<AddToCartResponse> addToCart(
      int productId, int qty, int combinationId) async {
    try {
      Response response = await _dio.post(_baseUrl +
          "cart" +
          ((AppData.user == null) ? "/guest/store" : "") +
          "?currency=1&language_id=${AppData.language.id}&product_id=" +
          productId.toString() +
          "&qty=" +
          qty.toString() +
          "&product_combination_id=" +
          combinationId.toString() +
          (AppData.sessionId == null
              ? ""
              : "&session_id=" + AppData.sessionId!));
      return AddToCartResponse.fromJson(response.data);
    } catch (error) {
      return AddToCartResponse.withError(_handleError(error));
    }
  }

  Future<CouponResponse> applyCoupon(String coupon) async {
    try {
      Response response = await _dio.post(_baseUrl +
          "coupon?coupon_code=" +
          coupon +
          "&currency=1&language_id=${AppData.language.id}&status=publish");
      return CouponResponse.fromJson(response.data);
    } catch (error) {
      return CouponResponse.withError(_handleError(error));
    }
  }

  Future<QuantityResponse> getQuantity(
      int productId, String productType, int combinationId) async {
    try {
      Response response = await _dio.get(_baseUrl +
          "available_qty?product_id=" +
          productId.toString() +
          "&product_type=$productType" +
          "&status=publish&product_combination_id=$combinationId&currency=1&language_id=${AppData.language.id}");
      return QuantityResponse.fromJson(response.data);
    } catch (error) {
      return QuantityResponse.withError(_handleError(error));
    }
  }

  Future<CartResponse> getCart() async {
    try {
      Response response = await _dio.get(_baseUrl +
          "cart" +
          ((AppData.user == null)
              ? "/guest/get?session_id=" + AppData.sessionId! + "&"
              : "?") +
          "currency=1&language_id=${AppData.language.id}");
      return CartResponse.fromJson(response.data);
    } catch (error) {
      return CartResponse.withError(_handleError(error));
    }
  }

  Future<DeleteCartResponse> deleteCartItem(
      int productId, int combinationId) async {
    try {
      Response response = await _dio.delete(_baseUrl +
          "cart" +
          ((AppData.user == null)
              ? "/guest/delete?session_id=" + AppData.sessionId! + "&"
              : "/delete?") +
          "product_id=" +
          productId.toString() +
          "&product_combination_id=" +
          combinationId.toString() +
          "&currency=1&language_id=${AppData.language.id}");
      return DeleteCartResponse.fromJson(response.data);
    } catch (error) {
      return DeleteCartResponse.withError(_handleError(error));
    }
  }

  Future<GetAddressResponse> getCustomerAddress() async {
    try {
      Response response = await _dio.get(_baseUrl +
          "customer_address_book?currency=1&language_id=${AppData.language.id}");
      return GetAddressResponse.fromJson(response.data);
    } catch (error) {
      return GetAddressResponse.withError(_handleError(error));
    }
  }

  Future<DeleteAddressResponse> deleteCustomerAddress(int addressId) async {
    try {
      Response response = await _dio.delete(_baseUrl +
          "customer_address_book/" +
          addressId.toString() +
          "?currency=1&language_id=${AppData.language.id}");
      return DeleteAddressResponse.fromJson(response.data);
    } catch (error) {
      return DeleteAddressResponse.withError(_handleError(error));
    }
  }

  Future<WooNewsResponse> getWooNews() async {
    try {
      WooNewsResponse endResponse = WooNewsResponse();
      List<WooNewsData> _featuredNews = [];
      List<WooNewsData> _latestNews = [];
      List<WooNewsCategory> _newsCategories = [];
      var featuredNewsResponse = await _dio.get(_wpBaseUrl +
          "v2/posts?consumer_key=${AppConfig.WOO_CONSUMER_KEY}&consumer_secret=${AppConfig.WOO_CONSUMER_SECRET}&page=1&per_page=100&sticky=true&_embed=true");
      var latestNewsResponse = await _dio.get(_wpBaseUrl +
          "v2/posts?consumer_key=${AppConfig.WOO_CONSUMER_KEY}&consumer_secret=${AppConfig.WOO_CONSUMER_SECRET}&page=1&per_page=100");
      var newsCategoriesResponse = await _dio.get(_wpBaseUrl +
          "v2/categories?consumer_key=${AppConfig.WOO_CONSUMER_KEY}&consumer_secret=${AppConfig.WOO_CONSUMER_SECRET}&page=1&per_page=100");
      featuredNewsResponse.data.forEach((v) {
        _featuredNews.add(new WooNewsData.fromJson(v));
      });
      latestNewsResponse.data.forEach((v) {
        _latestNews.add(new WooNewsData.fromJson(v));
      });
      newsCategoriesResponse.data.forEach((v) {
        _newsCategories.add(new WooNewsCategory.fromJson(v));
      });
      endResponse.featureNews = _featuredNews;
      endResponse.latestNews = _latestNews;
      endResponse.newsCategories = _newsCategories;
      return endResponse;
    } catch (error) {
      return WooNewsResponse.withError("Error");
    }
  }

  Future<WooRewardResponse> getWooRewards() async {
    try {
      Response response = await _dio.post(
          AppConfig.WOO_ECOMMERCE_URL + "/wp-json/api/tc_user/tc_reward_points",
          data: jsonEncode({
            "user_id": AppData.wooUser!.id.toString(),
          }));
      return WooRewardResponse.fromJson(response.data);
    } catch (error) {
      return WooRewardResponse.withError(_handleError(error));
    }
  }

  Future<AddAddressResponse> addCustomerAddress(
      String firstName,
      String lastName,
      String gender,
      String company,
      String streetAddress,
      String suburb,
      String postCode,
      String dob,
      String city,
      int countryId,
      int state_id,
      String lat,
      String lng,
      String phone) async {
    try {
      Response response = await _dio.post(_baseUrl + "customer_address_book",
          data: jsonEncode({
            "first_name": firstName,
            "last_name": lastName,
            "gender": gender,
            "company": company,
            "street_address": streetAddress,
            "suburb": suburb,
            "postcode": postCode,
            "dob": dob,
            "city": city,
            "country_id": countryId,
            "state_id": state_id,
            "latlong": lat + "," + lng,
            "is_default": 1,
            "phone": phone,
          }));
      return AddAddressResponse.fromJson(response.data);
    } catch (error) {
      return AddAddressResponse.withError(_handleError(error));
    }
  }

  Future<AddAddressResponse> updateCustomerAddress(
      int id,
      String firstName,
      String lastName,
      String gender,
      String company,
      String streetAddress,
      String suburb,
      String postCode,
      String dob,
      String city,
      int countryId,
      int state_id,
      String lat,
      String lng,
      String phone) async {
    try {
      Response response = await _dio.put(
          _baseUrl + "customer_address_book" + "/" + id.toString(),
          data: jsonEncode({
            "first_name": firstName,
            "last_name": lastName,
            "gender": gender,
            "company": company,
            "street_address": streetAddress,
            "suburb": suburb,
            "postcode": postCode,
            "dob": dob,
            "city": city,
            "country_id": countryId,
            "state_id": state_id,
            "latlong": lat + "," + lng,
            "is_default": 1,
            "phone": phone,
          }));
      return AddAddressResponse.fromJson(response.data);
    } catch (error) {
      return AddAddressResponse.withError(_handleError(error));
    }
  }

  Future<AddAddressResponse> setDefaultCustomerAddress(
      int addressBookID,
      String firstName,
      String lastName,
      String gender,
      String company,
      String streetAddress,
      String suburb,
      String postCode,
      String dob,
      String city,
      int countryId,
      int state_id,
      String lat,
      String lng,
      String phone) async {
    try {
      Response response = await _dio.put(
          _baseUrl + "customer_address_book/" + addressBookID.toString(),
          data: jsonEncode({
            "first_name": firstName,
            "last_name": lastName,
            "gender": gender,
            "company": company,
            "street_address": streetAddress,
            "suburb": suburb,
            "postcode": postCode,
            "dob": dob,
            "city": city,
            "country_id": 162,
            "state_id": 167,
            "lattitude": lat,
            "longitude": lng,
            "is_default": 1,
            "phone": phone,
          }));
      return AddAddressResponse.fromJson(response.data);
    } catch (error) {
      return AddAddressResponse.withError(_handleError(error));
    }
  }

  Future<int?> saveOrder(WooCheckoutParams orderDetails) async {
    try {
      Response response = await _dio.post(
          AppConfig.WOO_ECOMMERCE_URL +
              "/wp-json/api/tc_settings/app_data_link",
          data: jsonEncode(orderDetails.toJson()));
      return response.data;
    } catch (error) {
      return null;
    }
  }

  Future<OrderPlaceResponse> placeOrder(
      String billingFirstName,
      String billingLastName,
      String billingStreetAddress,
      String billingCity,
      String billingPostCode,
      int billingCountry,
      int billingState,
      String billingPhone,
      String deliveryFirstName,
      String deliveryLastName,
      String deliveryStreetAddress,
      String deliveryCity,
      String deliveryPostCode,
      int deliveryCountry,
      int deliveryState,
      String deliveryPhone,
      int currencyId,
      int languageId,
      String paymentMethod,
      String latLng,
      String cardNumber,
      String cvc,
      String expMonth,
      String expYear) async {
    try {
      Response response = await _dio.post(_baseUrl + "order",
          data: jsonEncode({
            "billing_first_name": billingFirstName,
            "billing_last_name": billingLastName,
            "billing_street_aadress": billingStreetAddress,
            "billing_city": billingCity,
            "billing_postcode": billingPostCode,
            "billing_country": billingCountry,
            "billing_state": billingState,
            "billing_phone": billingPhone,
            "delivery_first_name": deliveryFirstName,
            "delivery_last_name": deliveryLastName,
            "delivery_street_aadress": deliveryStreetAddress,
            "delivery_city": deliveryCity,
            "delivery_postcode": deliveryPostCode,
            "delivery_country": deliveryCountry,
            "delivery_state": deliveryState,
            "delivery_phone": deliveryPhone,
            "currency_id": currencyId,
            "language_id": languageId,
            "session_id": (AppData.sessionId == null) ? "" : AppData.sessionId,
            "payment_method": paymentMethod,
            "latlong": latLng,
            "payment_id": 0,
            "cc_cvc": cvc,
            "cc_expiry_month": expMonth,
            "cc_expiry_year": expYear,
            "cc_number": cardNumber,
          }));
      return OrderPlaceResponse.fromJson(response.data);
    } catch (error) {
      return OrderPlaceResponse.withError(_handleError(error));
    }
  }

  Future<GetPageResponse> getPage(int pageNo) async {
    try {
      Response response =
          await _dio.get(_baseUrl + "pages/" + pageNo.toString());
      return GetPageResponse.fromJson(response.data);
    } catch (error) {
      return GetPageResponse.withError(_handleError(error));
    }
  }

  Future<List<WooOrder>> getWooOrders(int? customerId) async {
    try {
      List<WooOrder> _data = [];
      var response = await wooCommerceAPI.getAsync(
          "orders?customer=$customerId&per_page=100&lang=${AppData.language.code}&currency=${AppData.currency.name}");
      if (response != null) {
        response.forEach((v) {
          _data.add(new WooOrder.fromJson(v));
        });
      }
      return _data;
    } catch (error) {
      return [];
    }
  }

  Future<WooOrderDetail> getWooOrderDetail(int orderId) async {
    try {
      var response = await wooCommerceAPI.getAsync(
          "orders/$orderId?lang=${AppData.language.code}&status=publish&currency=${AppData.currency.name}");
      return WooOrderDetail.fromJson(response);
    } catch (error) {
      return WooOrderDetail.withError(_handleError(error));
    }
  }

  Future<OrdersResponse> getOrders() async {
    try {
      Response response = await _dio.get(
          _baseUrl + "customer/order?orderDetail=1&productDetail=1&currency=1");
      return OrdersResponse.fromJson(response.data);
    } catch (error) {
      return OrdersResponse.withError(_handleError(error));
    }
  }

  Future<ReviewsResponse> getReviews(int productId) async {
    try {
      Response response = await _dio.get(_baseUrl +
          "review?product_id=" +
          productId.toString() +
          "&language_id=1&customer=1&currency=1");
      return ReviewsResponse.fromJson(response.data);
    } catch (error) {
      return ReviewsResponse.withError(_handleError(error));
    }
  }

  Future<List<WooReview>> getWooReviews(int? productId) async {
    try {
      List<WooReview> _data = [];
      var response = await wooCommerceAPI.getAsync(
          "products/reviews?product=$productId&status=publish&lang=${AppData.language.code}&currency=${AppData.currency.name}");
      if (response != null) {
        response.forEach((v) {
          _data.add(new WooReview.fromJson(v));
        });
      }
      return _data;
    } catch (error) {
      return [];
    }
  }

  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    try {
      Response response = await _dio.post(_baseUrl + "forget_password",
          data: jsonEncode({"email": email}));
      return ForgotPasswordResponse.fromJson(response.data);
    } catch (error) {
      return ForgotPasswordResponse.withError(_handleError(error));
    }
  }

  Future<AddReviewResponse> addReview(
      int productId, String comment, double rating) async {
    try {
      Response response = await _dio.post(_baseUrl + "review",
          data: jsonEncode({
            "product_id": productId,
            "comment": comment,
            "rating": rating,
          }));
      return AddReviewResponse.fromJson(response.data);
    } catch (error) {
      return AddReviewResponse.withError(_handleError(error));
    }
  }

  Future<GetWishlistOnStartResponse> getWishlistOnStart() async {
    try {
      Response response = await _dio.get(_baseUrl + "wishlist?currency=1");
      return GetWishlistOnStartResponse.fromJson(response.data);
    } catch (error) {
      return GetWishlistOnStartResponse.withError(_handleError(error));
    }
  }

  Future<GetWishlistOnStartResponse> likeProduct(int productId) async {
    print(GetWishlistOnStartResponse);
    try {
      Response response = await _dio.post(
        _baseUrl +
            "wishlist?product_id=" +
            productId.toString() +
            "&currency=1",
      );
      print("wish");
      print(response);
      return GetWishlistOnStartResponse.fromJson(response.data);
    } catch (error) {
      return GetWishlistOnStartResponse.withError(_handleError(error));
    }
  }

  Future<GetWishlistOnStartResponse> unLikeProduct(int wishlistId) async {
    try {
      Response response = await _dio.delete(
          _baseUrl + "wishlist/" + wishlistId.toString() + "?currency=1");
      return GetWishlistOnStartResponse.fromJson(response.data);
    } catch (error) {
      return GetWishlistOnStartResponse.withError(_handleError(error));
    }
  }

  Future<WishlistDetailResponse> getWishlistProducts(int pageNo) async {
    try {
      Response response = await _dio.get(_baseUrl +
          "wishlist?limit=10&getCategory=1&products=1&getDetail=1&language_id=1&currency=1&stock=1&page=" +
          pageNo.toString());
      return WishlistDetailResponse.fromJson(response.data);
    } catch (error) {
      return WishlistDetailResponse.withError(_handleError(error));
    }
  }

  Future<ContactUsResponse> submitContactUs(
      String firstName, String lastName, String email, String message) async {
    try {
      Response response = await _dio.post(_baseUrl +
          "contact-us?first_name=" +
          firstName +
          "&last_name=" +
          lastName +
          "&email=" +
          email +
          "&message=" +
          message);
      return ContactUsResponse.fromJson(response.data);
    } catch (error) {
      return ContactUsResponse.withError(_handleError(error));
    }
  }

  Future<RewardPointsResponse> getRewardPoints() async {
    try {
      Response response = await _dio.get(_baseUrl + "points?currency=1");
      return RewardPointsResponse.fromJson(response.data);
    } catch (error) {
      return RewardPointsResponse.withError(_handleError(error));
    }
  }

  Future<RedeemResponse> redeemRewardPoints() async {
    try {
      Response response = await _dio.post(_baseUrl + "redeem?currency=1");
      return RedeemResponse.fromJson(response.data);
    } catch (error) {
      return RedeemResponse.withError(_handleError(error));
    }
  }

  Future<List<WooFilter>> getWooFilters() async {
    try {
      List<WooFilter> _data = [];
      var response = await wooCommerceAPI.getAsync(
          "products/attributes?lang=${AppData.language.code}&status=publish&currency=${AppData.currency.name}");
      if (response != null) {
        response.forEach((v) {
          _data.add(new WooFilter.fromJson(v));
        });
      }
      for (int i = 0; i < _data.length; i++) {
        _data[i].variations = await getWooVariations(_data[i].id);
      }
      return _data;
    } catch (error) {
      return [];
    }
  }

  Future<List<WooVariation>> getWooVariations(int? filterId) async {
    try {
      List<WooVariation> _data = [];
      var response = await wooCommerceAPI.getAsync(
          "products/attributes/${filterId.toString()}/terms?lang=${AppData.language.code}&currency=${AppData.currency.name}");
      if (response != null) {
        response.forEach((v) {
          _data.add(new WooVariation.fromJson(v));
        });
      }
      return _data;
    } catch (error) {
      return [];
    }
  }

  Future<FiltersResponse> getFilters() async {
    try {
      Response response = await _dio.get(_baseUrl +
          "attributes?getVariation=1&getDetail=1&page=1&language_id=1&currency=1");
      return FiltersResponse.fromJson(response.data);
    } catch (error) {
      return FiltersResponse.withError(_handleError(error));
    }
  }

  Future<LanguagesResponse> getLanguages() async {
    try {
      Response response =
          await _dio.get(_baseUrl + "language?page=1&limit=100");
      return LanguagesResponse.fromJson(response.data);
    } catch (error) {
      return LanguagesResponse.withError(_handleError(error));
    }
  }

  Future<WooCurrenciesResponse> getWooCurrencies() async {
    try {
      Response response = await _dio.post(AppConfig.WOO_ECOMMERCE_URL +
          "/wp-json/api/tc_settings/app_all_currencies/?insecure=cool&status=publish");
      return WooCurrenciesResponse.fromJson(response.data);
    } catch (error) {
      return WooCurrenciesResponse.withError(_handleError(error));
    }
  }

  Future<CurrenciesResponse> getCurrencies() async {
    try {
      Response response = await _dio.get(_baseUrl + "currency");
      return CurrenciesResponse.fromJson(response.data);
    } catch (error) {
      return CurrenciesResponse.withError(_handleError(error));
    }
  }

  Future<UpdateProfileResponse> updateProfile(String firstName, String lastName,
      String password, String confirmPassword) async {
    try {
      Response response = await _dio.put(_baseUrl +
          "profile/" +
          AppData.user!.id.toString() +
          "?first_name=" +
          firstName +
          "&last_name=" +
          lastName +
          "&password=" +
          password +
          "&password_confirmation=" +
          confirmPassword);
      return UpdateProfileResponse.fromJson(response.data);
    } catch (error) {
      return UpdateProfileResponse.withError(_handleError(error));
    }
  }

  Future<CountriesResponse> getCountries() async {
    try {
      Response response =
          await _dio.get(_baseUrl + "country?limit=1000&getStates=1");
      return CountriesResponse.fromJson(response.data);
    } catch (error) {
      return CountriesResponse.withError(_handleError(error));
    }
  }

  Future<PaymentMethodsResponse> getPaymentMethods() async {
    try {
      Response response = await _dio.get(_baseUrl + "payment_method");
      return PaymentMethodsResponse.fromJson(response.data);
    } catch (error) {
      return PaymentMethodsResponse.withError(_handleError(error));
    }
  }

  Future<List<WooPaymentMethod>> getWooPaymentMethods() async {
    try {
      List<WooPaymentMethod> _paymentMethods = [];
      var response = await wooCommerceAPI.getAsync(
          "payment_gateways?lang=${AppData.language.code}&status=publish&currency=${AppData.currency.name}");
      response.forEach((v) {
        _paymentMethods.add(new WooPaymentMethod.fromJson(v));
      });
      return _paymentMethods;
    } catch (error) {
      return [];
    }
  }

  Future<List<WooShippingMethod>> getWooShippingMethods(
      AddressData? addressData) async {
    try {
      var response = await wooCommerceAPI.getAsync(
          "shipping/zones?lang=${AppData.language.code}&status=publish&currency=${AppData.currency.name}");
      List<WooZone> _zones = [];
      response.forEach((v) {
        _zones.add(new WooZone.fromJson(v));
      });
      return getWooLocationsBasedOnZones(_zones, addressData);
    } catch (error) {
      return [];
    }
  }

  Future<List<WooShippingMethod>> getWooLocationsBasedOnZones(
      List<WooZone> zones, AddressData? addressData) async {
    try {
      List<WooLocation> allLocations = [];
      for (int i = 0; i < zones.length; i++) {
        List<WooLocation> _locations = [];
        var response = await wooCommerceAPI.getAsync(
            "shipping/zones/${zones[i].id.toString()}/locations?lang=${AppData.language.code}&status=publish&currency=${AppData.currency.name}");
        if (response != null) {
          response.forEach((v) {
            _locations.add(new WooLocation.fromJson(v));
          });
        }
        _locations.forEach((loc) {
          loc.zoneId = zones[i].id;
        });
        allLocations.addAll(_locations);

        if (i == zones.length - 1) {
          int? selectedZoneId = findZoneId(allLocations, addressData);
          var shippingMethodsResponse = await wooCommerceAPI.getAsync(
              "shipping/zones/${selectedZoneId.toString()}/methods?lang=${AppData.language.code}&status=publish&currency=${AppData.currency.name}");
          List<WooShippingMethod> shippingMethods = [];
          shippingMethodsResponse.forEach((v) {
            shippingMethods.add(new WooShippingMethod.fromJson(v));
          });
          return shippingMethods;
        }
      }
      return [];
    } catch (error) {
      return [];
    }
  }

  String _handleError(Object error) {
    String errorDescription = "";
    if (error is DioError) {
      DioError dioError = error;
      switch (dioError.type) {
        case DioErrorType.connectTimeout:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.sendTimeout:
          errorDescription = "Send timeout in connection with API server";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.response:
          errorDescription =
              "Received invalid status code: ${dioError.response!.statusCode}";
          break;
        case DioErrorType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.other:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
      }
    } else {
      errorDescription = error.toString();
      print(error);
      // print(error.stackTrace);
    }
    return errorDescription;
  }

  int? findZoneId(List<WooLocation> locations, AddressData? addressData) {
    int? zoneId = 0;
    for (var value in locations) {
      if (value.type == "postcode") {
        if (matchPostCode(value, addressData!.postcode!)) {
          zoneId = value.zoneId;
          break;
        }
      } else if (value.type == "state") {
        if (matchState(value, addressData!.country!, addressData.state!)) {
          zoneId = value.zoneId;
          break;
        }
      } else if (value.type == "country") {
        if (matchCountry(value, addressData!.country!)) {
          zoneId = value.zoneId;
          break;
        }
      } else if (value.type == "continent") {
        if (matchContinent(value, addressData!.country!)) {
          zoneId = value.zoneId;
          break;
        }
      }
    }

    return zoneId;
  }

  bool matchPostCode(WooLocation value, String postCode) {
    if (value.code!.toUpperCase() == postCode.toUpperCase()) return true;

    if (value.code!.indexOf("*") > 0) {
      var ind = value.code!.indexOf("*");
      var s1 = postCode.substring(0, ind - 1);
      var s2 = value.code!.substring(0, ind - 1);

      if (s1.toUpperCase() == s2.toUpperCase()) {
        return true;
      }
    }

    if (value.code!.indexOf(".") > 0) {
      int i = value.code!.indexOf(".");
      int min = int.parse(value.code!.substring(0, i));
      int max = int.parse(value.code!.substring(i + 3, value.code!.length));

      int p = int.parse(postCode);

      if (p >= min && p <= max) {
        return true;
      }
    }

    return false;
  }

  bool matchState(
      WooLocation value, WooCountry selectedCountry, WooState selectedState) {
    String s = selectedCountry.value! + ":" + selectedState.value!;
    return s == value.code ? true : false;
  }

  bool matchCountry(WooLocation value, WooCountry selectedCountry) {
    return (selectedCountry.value == value.code ? true : false);
  }

  bool matchContinent(WooLocation value, WooCountry selectedCountry) {
    return (selectedCountry.value == value.code ? true : false);
  }
}
