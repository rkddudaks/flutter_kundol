import 'package:flutter_kundol/api/api_provider.dart';
// import 'package:flutter_kundol/api/responses/payment_method_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_shipping_method.dart';
import 'package:flutter_kundol/models/address_data.dart';

abstract class ShippingMethodsRepo {
  Future<List<WooShippingMethod>> fetchShippingMethods(
      AddressData? addressData);
}

class RealShippingMethodsRepo implements ShippingMethodsRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<List<WooShippingMethod>> fetchShippingMethods(
      AddressData? addressData) {
    return _apiProvider.getWooShippingMethods(addressData);
  }
}

class FakeShippingMethodsRepo implements ShippingMethodsRepo {
  @override
  Future<List<WooShippingMethod>> fetchShippingMethods(
      AddressData? addressData) {
    throw UnimplementedError();
  }
}
