class WooCurrenciesResponse {
  WooCurrenciesResponse({
    List<WooCurrency>? data,
  }) {
    _data = data;
  }

  WooCurrenciesResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data!.add(WooCurrency.fromJson(v));
      });
    }
  }

  WooCurrenciesResponse.withError(String error) {
    _data = [];
  }

  List<WooCurrency>? _data;

  WooCurrenciesResponse copyWith({
    List<WooCurrency>? data,
  }) =>
      WooCurrenciesResponse(
        data: data ?? _data,
      );

  List<WooCurrency>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class WooCurrency {
  WooCurrency({
    String? name,
    int? rate,
    String? symbol,
    String? position,
    int? isEtalon,
    int? hideCents,
    int? decimals,
    String? description,
    String? flag,
  }) {
    _name = name;
    _rate = rate;
    _symbol = symbol;
    _position = position;
    _isEtalon = isEtalon;
    _hideCents = hideCents;
    _decimals = decimals;
    _description = description;
    _flag = flag;
  }

  WooCurrency.fromJson(dynamic json) {
    _name = json['name'];
    _rate = json['rate'];
    _symbol = json['symbol'];
    _position = json['position'];
    _isEtalon = json['is_etalon'];
    _hideCents = json['hide_cents'];
    _decimals = json['decimals'];
    _description = json['description'];
    _flag = json['flag'];
  }

  String? _name;
  var _rate;
  String? _symbol;
  String? _position;
  int? _isEtalon;
  int? _hideCents;
  int? _decimals;
  String? _description;
  String? _flag;

  WooCurrency copyWith({
    String? name,
    int? rate,
    String? symbol,
    String? position,
    int? isEtalon,
    int? hideCents,
    int? decimals,
    String? description,
    String? flag,
  }) =>
      WooCurrency(
        name: name ?? _name,
        rate: rate ?? _rate,
        symbol: symbol ?? _symbol,
        position: position ?? _position,
        isEtalon: isEtalon ?? _isEtalon,
        hideCents: hideCents ?? _hideCents,
        decimals: decimals ?? _decimals,
        description: description ?? _description,
        flag: flag ?? _flag,
      );

  String? get name => _name;

  String get rate => _rate.toString();

  String? get symbol => _symbol;

  String? get position => _position;

  int? get isEtalon => _isEtalon;

  int? get hideCents => _hideCents;

  int? get decimals => _decimals;

  String? get description => _description;

  String? get flag => _flag;


  set name(String? value) {
    _name = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['rate'] = _rate;
    map['symbol'] = _symbol;
    map['position'] = _position;
    map['is_etalon'] = _isEtalon;
    map['hide_cents'] = _hideCents;
    map['decimals'] = _decimals;
    map['description'] = _description;
    map['flag'] = _flag;
    return map;
  }

  set rate(var value) {
    _rate = value;
  }

  set symbol(String? value) {
    _symbol = value;
  }

  set position(String? value) {
    _position = value;
  }

  set isEtalon(int? value) {
    _isEtalon = value;
  }

  set hideCents(int? value) {
    _hideCents = value;
  }

  set decimals(int? value) {
    _decimals = value;
  }

  set description(String? value) {
    _description = value;
  }

  set flag(String? value) {
    _flag = value;
  }
}
