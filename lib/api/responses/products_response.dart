import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/products/product.dart';

class ProductsResponse {
  List<Product>? data;
  String? status;
  String? message;
  int? statusCode;

  ProductsResponse({this.data, this.status, this.message, this.statusCode});

  ProductsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new Product.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
  }

  ProductsResponse.withError(String error) {
    data = null;
    status = AppConstants.STATUS_ERROR;
    message = error;
    statusCode = 0;
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