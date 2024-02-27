import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/banners/banner.dart';

class BannersResponse {
  List<BannerData>? data;
  String? status;
  String? message;
  int? statusCode;

  BannersResponse({this.data, this.status, this.message, this.statusCode});

  BannersResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new BannerData.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
  }

  BannersResponse.withError(String error){
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