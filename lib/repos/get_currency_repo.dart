import 'package:flutter_kundol/api/api_provider.dart';
// import 'package:flutter_kundol/api/responses/currencies_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_currencies_response.dart';
// import 'package:flutter_kundol/api/wooResponses/woo_currencies_response.dart';
// import 'package:flutter_kundol/api/wooResponses/woo_currencies_response.dart';

abstract class GetCurrencyRepo {
  Future<WooCurrenciesResponse> fetchCurrencies();
}

class RealGetCurrencyRepo implements GetCurrencyRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<WooCurrenciesResponse> fetchCurrencies() {
    return _apiProvider.getWooCurrencies();
  }
}

class FakeBannersRepo implements GetCurrencyRepo {
  @override
  Future<WooCurrenciesResponse> fetchCurrencies() {
    throw UnimplementedError();
  }
}
