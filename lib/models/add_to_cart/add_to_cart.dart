import 'package:flutter_kundol/constants/app_constants.dart';

class AddToCartResponse {
  AddToCartData? data;
  String? status;
  String? message;
  int? statusCode;

  AddToCartResponse({this.data, this.status, this.message, this.statusCode});

  AddToCartResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new AddToCartData.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
  }

  AddToCartResponse.withError(String error) {
    data = null;
    status = AppConstants.STATUS_ERROR;
    message = error;
    statusCode = 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    return data;
  }
}

class AddToCartData {
  String? session;

  AddToCartData({this.session});

  AddToCartData.fromJson(Map<String, dynamic> json) {
    session = json['session'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['session'] = this.session;
    return data;
  }
}
