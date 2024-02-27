import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/reward/reward_point.dart';

class RewardPointsResponse {
  List<RewardPoint>? data;
  String? status;
  String? message;
  int? statusCode;

  RewardPointsResponse({this.data, this.status, this.message, this.statusCode});

  RewardPointsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new RewardPoint.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
  }

  RewardPointsResponse.withError(String error) {
    data = null;
    status = AppConstants.STATUS_ERROR;
    statusCode = 0;
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