import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/language_data.dart';

class LanguagesResponse {
  List<LanguageData>? data;
  String? status;
  String? message;
  int? statusCode;

  LanguagesResponse(
      {this.data,
        this.status,
        this.message,
        this.statusCode});

  LanguagesResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new LanguageData.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
  }

  LanguagesResponse.withError(String error) {
    status = AppConstants.STATUS_ERROR;
    message = error;
    statusCode = 0;
    data = null;
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