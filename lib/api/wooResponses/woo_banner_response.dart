import 'package:flutter_kundol/constants/app_constants.dart';

class WooBannerResponse {
  WooBannerResponse({
    List<WooBannerData>? data,
  }) {
    _data = data;
    _status = AppConstants.STATUS_SUCCESS;
    _error = null;
  }

  WooBannerResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(WooBannerData.fromJson(v));
      });
    }
    _status = AppConstants.STATUS_SUCCESS;
    _error = null;
  }

  WooBannerResponse.withError(String error) {
    _data = null;
    _status = AppConstants.STATUS_ERROR;
    _error = error;
  }

  String? _status;
  String? _error;
  List<WooBannerData>? _data;

  List<WooBannerData>? get data => _data;

  String? get status => _status;

  String? get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  set error(String? value) {
    _error = value;
  }

  set data(List<WooBannerData>? value) {
    _data = value;
  }
}

class WooBannerData {
  WooBannerData({
    String? bannersId,
    String? bannersTitle,
    String? bannersUrl,
    String? bannersImage,
    String? bannersGroup,
    dynamic bannersHtmlText,
    String? expiresImpressions,
    String? expiresDate,
    dynamic dateScheduled,
    String? dateAdded,
    dynamic dateStatusChange,
    String? status,
    String? type,
    String? bannersOrder,
  }) {
    _bannersId = bannersId;
    _bannersTitle = bannersTitle;
    _bannersUrl = bannersUrl;
    _bannersImage = bannersImage;
    _bannersGroup = bannersGroup;
    _bannersHtmlText = bannersHtmlText;
    _expiresImpressions = expiresImpressions;
    _expiresDate = expiresDate;
    _dateScheduled = dateScheduled;
    _dateAdded = dateAdded;
    _dateStatusChange = dateStatusChange;
    _status = status;
    _type = type;
    _bannersOrder = bannersOrder;
  }

  WooBannerData.fromJson(dynamic json) {
    _bannersId = json['banners_id'];
    _bannersTitle = json['banners_title'];
    _bannersUrl = json['banners_url'];
    _bannersImage = json['banners_image'];
    _bannersGroup = json['banners_group'];
    _bannersHtmlText = json['banners_html_text'];
    _expiresImpressions = json['expires_impressions'];
    _expiresDate = json['expires_date'];
    _dateScheduled = json['date_scheduled'];
    _dateAdded = json['date_added'];
    _dateStatusChange = json['date_status_change'];
    _status = json['status'];
    _type = json['type'];
    _bannersOrder = json['banners_order'];
  }

  String? _bannersId;
  String? _bannersTitle;
  String? _bannersUrl;
  String? _bannersImage;
  String? _bannersGroup;
  dynamic _bannersHtmlText;
  String? _expiresImpressions;
  String? _expiresDate;
  dynamic _dateScheduled;
  String? _dateAdded;
  dynamic _dateStatusChange;
  String? _status;
  String? _type;
  String? _bannersOrder;

  String? get bannersId => _bannersId;

  String? get bannersTitle => _bannersTitle;

  String? get bannersUrl => _bannersUrl;

  String? get bannersImage => _bannersImage;

  String? get bannersGroup => _bannersGroup;

  dynamic get bannersHtmlText => _bannersHtmlText;

  String? get expiresImpressions => _expiresImpressions;

  String? get expiresDate => _expiresDate;

  dynamic get dateScheduled => _dateScheduled;

  String? get dateAdded => _dateAdded;

  dynamic get dateStatusChange => _dateStatusChange;

  String? get status => _status;

  String? get type => _type;

  String? get bannersOrder => _bannersOrder;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['banners_id'] = _bannersId;
    map['banners_title'] = _bannersTitle;
    map['banners_url'] = _bannersUrl;
    map['banners_image'] = _bannersImage;
    map['banners_group'] = _bannersGroup;
    map['banners_html_text'] = _bannersHtmlText;
    map['expires_impressions'] = _expiresImpressions;
    map['expires_date'] = _expiresDate;
    map['date_scheduled'] = _dateScheduled;
    map['date_added'] = _dateAdded;
    map['date_status_change'] = _dateStatusChange;
    map['status'] = _status;
    map['type'] = _type;
    map['banners_order'] = _bannersOrder;
    return map;
  }
}
