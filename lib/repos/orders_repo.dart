import 'package:flutter_kundol/api/api_provider.dart';
// import 'package:flutter_kundol/api/responses/orders_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_order.dart';
import 'package:flutter_kundol/api/wooResponses/woo_order_detail.dart';

abstract class OrdersRepo {
  Future<List<WooOrder>> getOrders(int? customerId);
  Future<WooOrderDetail> getOrderDetails(int orderId);
}

class RealOrdersRepo implements OrdersRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<List<WooOrder>> getOrders(int? customerId) {
    return _apiProvider.getWooOrders(customerId);
  }

  @override
  Future<WooOrderDetail> getOrderDetails(int orderId) {
    return _apiProvider.getWooOrderDetail(orderId);
  }
}
