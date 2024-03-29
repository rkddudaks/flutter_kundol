import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/payment_method.dart';

class PaymentMethodsResponse {
  List<PaymentMethod>? data;
  String? status;
  String? message;
  int? statusCode;

  PaymentMethodsResponse(
      {this.data, this.status, this.message, this.statusCode});

  PaymentMethodsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new PaymentMethod.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
  }

  PaymentMethodsResponse.withError(String error) {
    data = null;
    statusCode = 0;
    status = AppConstants.STATUS_ERROR;
    message = error;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    return data;
  }
}
