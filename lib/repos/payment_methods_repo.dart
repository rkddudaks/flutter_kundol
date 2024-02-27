import 'package:flutter_kundol/api/api_provider.dart';
// import 'package:flutter_kundol/api/responses/payment_method_response.dart';
import 'package:flutter_kundol/api/wooResponses/WooPaymentMethod.dart';

abstract class PaymentMethodsRepo {
  Future<List<WooPaymentMethod>> fetchPaymentMethods();
}

class RealPaymentMethodsRepo implements PaymentMethodsRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<List<WooPaymentMethod>> fetchPaymentMethods() {
    return _apiProvider.getWooPaymentMethods();
  }
}

class FakePaymentMethodsRepo implements PaymentMethodsRepo {
  @override
  Future<List<WooPaymentMethod>> fetchPaymentMethods() {
    throw UnimplementedError();
  }
}
