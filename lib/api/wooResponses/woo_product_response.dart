import 'package:flutter_kundol/api/wooResponses/woo_product/woo_product.dart';

import '../../constants/app_constants.dart';

class WooProductsResponse {
  String? _status;
  String? _error;
  List<WooProduct>? _data;

  WooProductsResponse({List<WooProduct>? data}) {
    this._data = data;
    _status = AppConstants.STATUS_SUCCESS;
    _error = null;
  }

  WooProductsResponse.fromJson(List<dynamic>? json) {
    if (json != null) {
      _data = [];
      json.forEach((v) {
        _data!.add(new WooProduct.fromJson(v));
      });
    }
    _status = AppConstants.STATUS_SUCCESS;
    _error = null;
  }

  WooProductsResponse.withError(String error) {
    _data = null;
    _status = AppConstants.STATUS_ERROR;
    _error = error;
  }

  List<Map<String, dynamic>> toJson() {
    List<Map<String, dynamic>> data = [];
    if (this._data != null) {
      data = this._data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  List<WooProduct>? get data => _data;

  set data(List<WooProduct>? value) {
    _data = value;
  }

  String? get error => _error;

  set error(String? value) {
    _error = value;
  }

  String? get status => _status;

  set status(String? value) {
    _status = value;
  }
}
