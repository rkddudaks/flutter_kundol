class WooLocation {
  WooLocation({
    String? code,
    String? type,
    int? zoneId,
  }) {
    _code = code;
    _type = type;
    _zoneId = zoneId;
  }

  WooLocation.fromJson(dynamic json) {
    _code = json['code'];
    _type = json['type'];
  }

  String? _code;
  String? _type;
  int? _zoneId;

  String? get code => _code;

  String? get type => _type;

  int? get zoneId => _zoneId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['type'] = _type;
    return map;
  }

  set zoneId(int? value) {
    _zoneId = value;
  }

  set type(String? value) {
    _type = value;
  }

  set code(String? value) {
    _code = value;
  }
}
