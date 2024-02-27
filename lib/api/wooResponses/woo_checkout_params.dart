import 'package:flutter_kundol/api/wooResponses/woo_user_billing.dart';
import 'package:flutter_kundol/api/wooResponses/woo_user_shipping.dart';

class WooCheckoutParams {
  WooCheckoutParams({
    int? customerId,
    String? token,
    List<ShippingIds>? shippingIds,
    bool? sameaddress,
    WooUserBilling? billingInfo,
    WooUserShipping? shippingInfo,
    List<CheckoutProducts>? products,
    List<dynamic>? coupons,
    String? paymentMethod,
    String? paymentMethodTitle,
    String? customerNote,
    String? platform,
    String? onePage,
  }) {
    _customerId = customerId;
    _token = token;
    _shippingIds = shippingIds;
    _sameaddress = sameaddress;
    _billingInfo = billingInfo;
    _shippingInfo = shippingInfo;
    _products = products;
    _coupons = coupons as List<WooCheckoutCoupon>?;
    _paymentMethod = paymentMethod;
    _paymentMethodTitle = paymentMethodTitle;
    _customerNote = customerNote;
    _platform = platform;
    _onePage = onePage;
  }

  WooCheckoutParams.fromJson(dynamic json) {
    _customerId = json['customer_id'];
    _token = json['token'];
    if (json['shipping_ids'] != null) {
      _shippingIds = [];
      json['shipping_ids'].forEach((v) {
        _shippingIds!.add(ShippingIds.fromJson(v));
      });
    }
    _sameaddress = json['sameaddress'];
    _billingInfo = json['billing_info'] != null
        ? WooUserBilling.fromJson(json['billingInfo'])
        : null;
    _shippingInfo = json['shipping_info'] != null
        ? WooUserShipping.fromJson(json['shippingInfo'])
        : null;
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products!.add(CheckoutProducts.fromJson(v));
      });
    }
    if (json['coupons'] != null) {
      _coupons = [];
      json['coupons'].forEach((v) {
        _coupons!.add(WooCheckoutCoupon.fromJson(v));
      });
    }
    _customerNote = json['customer_note'];
    _platform = json['platform'];
    _onePage = json['one_page'];
  }

  int? _customerId;
  String? _token;
  List<ShippingIds>? _shippingIds;
  bool? _sameaddress;
  WooUserBilling? _billingInfo;
  WooUserShipping? _shippingInfo;
  List<CheckoutProducts>? _products;
  List<WooCheckoutCoupon>? _coupons;
  String? _paymentMethod;
  String? _paymentMethodTitle;
  String? _customerNote;
  String? _platform;
  String? _onePage;

  int? get customerId => _customerId;

  String? get token => _token;

  List<ShippingIds>? get shippingIds => _shippingIds;

  bool? get sameaddress => _sameaddress;

  WooUserBilling? get billingInfo => _billingInfo;

  WooUserShipping? get shippingInfo => _shippingInfo;

  List<CheckoutProducts>? get products => _products;

  List<WooCheckoutCoupon>? get coupons => _coupons;

  String? get paymentMethod => _paymentMethod;

  String? get paymentMethodTitle => _paymentMethodTitle;

  String? get customerNote => _customerNote;

  String? get platform => _platform;

  String? get onePage => _onePage;

  set customerId(int? value) {
    _customerId = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['customer_id'] = _customerId;
    map['token'] = _token;
    if (_shippingIds != null) {
      map['shipping_ids'] = _shippingIds!.map((v) => v.toJson()).toList();
    }
    map['sameaddress'] = _sameaddress;
    if (_billingInfo != null) {
      map['billing_info'] = _billingInfo!.toJson();
    }
    if (_shippingInfo != null) {
      map['shipping_info'] = _shippingInfo!.toJson();
    }
    if (_products != null) {
      map['products'] = _products!.map((v) => v.toJson()).toList();
    }
    /*if (_coupons != null) {
      map['coupons'] = _coupons.map((v) => v.toJson()).toList();
    }*/
    map['payment_method'] = _paymentMethod;
    map['payment_method_title'] = _paymentMethodTitle;
    map['customer_note'] = _customerNote;
    map['platform'] = _platform;
    map['one_page'] = _onePage;
    return map;
  }

  set token(String? value) {
    _token = value;
  }

  set shippingIds(List<ShippingIds>? value) {
    _shippingIds = value;
  }

  set sameaddress(bool? value) {
    _sameaddress = value;
  }

  set billingInfo(WooUserBilling? value) {
    _billingInfo = value;
  }

  set shippingInfo(WooUserShipping? value) {
    _shippingInfo = value;
  }

  set products(List<CheckoutProducts>? value) {
    _products = value;
  }

  set coupons(List<WooCheckoutCoupon>? value) {
    _coupons = value;
  }

  set customerNote(String? value) {
    _customerNote = value;
  }

  set platform(String? value) {
    _platform = value;
  }

  set onePage(String? value) {
    _onePage = value;
  }

  set paymentMethodTitle(String? value) {
    _paymentMethodTitle = value;
  }

  set paymentMethod(String? value) {
    _paymentMethod = value;
  }
}

class CheckoutProducts {
  CheckoutProducts({
    int? quantity,
    int? productId,
    String? total,
    String? price,
  }) {
    _quantity = quantity;
    _productId = productId;
    _total = total;
    _price = price;
  }

  CheckoutProducts.fromJson(dynamic json) {
    _quantity = json['quantity'];
    _productId = json['product_id'];
    _total = json['total'];
    _price = json['price'];
  }

  int? _quantity;
  int? _productId;
  String? _total;
  String? _price;

  int? get quantity => _quantity;

  int? get productId => _productId;

  String? get total => _total;

  String? get price => _price;

  set quantity(int? value) {
    _quantity = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quantity'] = _quantity;
    map['product_id'] = _productId;
    map['total'] = _total;
    map['price'] = _price;
    return map;
  }

  set productId(int? value) {
    _productId = value;
  }

  set total(String? value) {
    _total = value;
  }

  set price(String? value) {
    _price = value;
  }
}

class ShippingIds {
  ShippingIds({
    int? shipId,
    String? methodId,
    String? methodTitle,
    String? total,
  }) {
    _shipId = shipId;
    _methodId = methodId;
    _methodTitle = methodTitle;
    _total = total;
  }

  ShippingIds.fromJson(dynamic json) {
    _shipId = json['ship_id'];
    _methodId = json['method_id'];
    _methodTitle = json['method_title'];
    _total = json['total'];
  }

  int? _shipId;
  String? _methodId;
  String? _methodTitle;
  String? _total;

  int? get shipId => _shipId;

  String? get methodId => _methodId;

  String? get methodTitle => _methodTitle;

  String? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ship_id'] = _shipId;
    map['method_id'] = _methodId;
    map['method_title'] = _methodTitle;
    map['total'] = _total;
    return map;
  }

  set total(String? value) {
    _total = value;
  }

  set methodTitle(String? value) {
    _methodTitle = value;
  }

  set methodId(String? value) {
    _methodId = value;
  }

  set shipId(int? value) {
    _shipId = value;
  }
}

class WooCheckoutCoupon {
  WooCheckoutCoupon({
    String? code,
    String? discount,
  }) {
    _code = code;
    _discount = discount;
  }

  WooCheckoutCoupon.fromJson(dynamic json) {
    _code = json['code'];
    _discount = json['discount'];
  }

  String? _code;
  String? _discount;

  String? get code => _code;

  String? get discount => _discount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['discount'] = _discount;
    return map;
  }

  set discount(String? value) {
    _discount = value;
  }

  set code(String? value) {
    _code = value;
  }
}
