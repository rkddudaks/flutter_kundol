import 'package:flutter_kundol/api/api_provider.dart';
// import 'package:flutter_kundol/api/responses/banners_response.dart';
// import 'package:flutter_kundol/api/wooResponses/woo_banner_response.dart';
// import 'package:flutter_kundol/api/wooResponses/woo_banner_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_news_response.dart';
// import 'package:flutter_kundol/api/wooResponses/woo_news_response.dart';
// import 'package:flutter_kundol/api/wooResponses/woo_news_response.dart';

abstract class NewsRepo {
  Future<WooNewsResponse> fetchNews();
}

class RealNewsRepo implements NewsRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<WooNewsResponse> fetchNews() {
    return _apiProvider.getWooNews();
  }
}

class FakeNewsRepo implements NewsRepo {
  @override
  Future<WooNewsResponse> fetchNews() {
    throw UnimplementedError();
  }
}
