import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/address_data.dart';

class GetAddressResponse {
  List<AddressData>? data;
  String? status;
  String? message;
  int? statusCode;

  GetAddressResponse({this.data, this.status, this.message, this.statusCode});

  GetAddressResponse.fromJson(Map<String, dynamic> json) {
    /*if (json['data'] != null) {
      data = new List<AddressData>();
      json['data'].forEach((v) {
        data.add(new AddressData.fromJson(v));
      });
    }*/
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
  }

  GetAddressResponse.withError(String error) {
    data = null;
    message = error;
    status = AppConstants.STATUS_ERROR;
    statusCode = 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    /*if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }*/
    data['status'] = this.status;
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    return data;
  }
}
