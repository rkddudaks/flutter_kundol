class WooRewardResponse {
  WooRewardResponse({
    List<WooRewardData>? data,
  }) {
    _data = data;
  }

  WooRewardResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data!.add(WooRewardData.fromJson(v));
      });
    }
  }

  WooRewardResponse.withError(String error) {
    _data = [];
  }

  List<WooRewardData>? _data;

  WooRewardResponse copyWith({
    List<WooRewardData>? data,
  }) =>
      WooRewardResponse(
        data: data ?? _data,
      );

  List<WooRewardData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class WooRewardData {
  WooRewardData({
    String? id,
    String? userId,
    String? points,
    String? type,
    String? userPointsId,
    String? orderId,
    String? adminUserId,
    String? data,
    String? date,
  }) {
    _id = id;
    _userId = userId;
    _points = points;
    _type = type;
    _userPointsId = userPointsId;
    _orderId = orderId;
    _adminUserId = adminUserId;
    _data = data;
    _date = date;
  }

  WooRewardData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _points = json['points'];
    _type = json['type'];
    _userPointsId = json['user_points_id'];
    _orderId = json['order_id'];
    _adminUserId = json['admin_user_id'];
    _data = json['data'];
    _date = json['date'];
  }

  String? _id;
  String? _userId;
  String? _points;
  String? _type;
  String? _userPointsId;
  String? _orderId;
  String? _adminUserId;
  String? _data;
  String? _date;

  WooRewardData copyWith({
    String? id,
    String? userId,
    String? points,
    String? type,
    String? userPointsId,
    String? orderId,
    String? adminUserId,
    String? data,
    String? date,
  }) =>
      WooRewardData(
        id: id ?? _id,
        userId: userId ?? _userId,
        points: points ?? _points,
        type: type ?? _type,
        userPointsId: userPointsId ?? _userPointsId,
        orderId: orderId ?? _orderId,
        adminUserId: adminUserId ?? _adminUserId,
        data: data ?? _data,
        date: date ?? _date,
      );

  String? get id => _id;

  String? get userId => _userId;

  String? get points => _points;

  String? get type => _type;

  String? get userPointsId => _userPointsId;

  String? get orderId => _orderId;

  String? get adminUserId => _adminUserId;

  String? get data => _data;

  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['points'] = _points;
    map['type'] = _type;
    map['user_points_id'] = _userPointsId;
    map['order_id'] = _orderId;
    map['admin_user_id'] = _adminUserId;
    map['data'] = _data;
    map['date'] = _date;
    return map;
  }
}
