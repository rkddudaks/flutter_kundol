class WooCountriesResponse {
  List<WooCountry>? _countries;

  WooCountriesResponse({List<WooCountry>? countries}) {
    if (countries != null) {
      this._countries = countries;
    }
  }

  List<WooCountry>? get countries => _countries;

  set countries(List<WooCountry>? countries) => _countries = countries;

  WooCountriesResponse.fromJson(Map<String, dynamic> json) {
    if (json['countries'] != null) {
      _countries = <WooCountry>[];
      json['countries'].forEach((v) {
        _countries!.add(new WooCountry.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._countries != null) {
      data['countries'] = this._countries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WooCountry {
  String? _value;
  String? _name;
  List<WooState>? _states;

  WooCountry({String? value, String? name, List<WooState>? states}) {
    if (value != null) {
      this._value = value;
    }
    if (name != null) {
      this._name = name;
    }
    if (states != null) {
      this._states = states;
    }
  }

  String? get value => _value;

  set value(String? value) => _value = value;

  String? get name => _name;

  set name(String? name) => _name = name;

  List<WooState>? get states => _states;

  set states(List<WooState>? states) => _states = states;

  WooCountry.fromJson(Map<String, dynamic> json) {
    _value = json['value'];
    _name = json['name'];
    if (json['states'] != null) {
      _states = <WooState>[];
      json['states'].forEach((v) {
        _states!.add(new WooState.fromJson(v));
      });
    }
  }

  WooCountry.fromValue(String? value) {
    _value = value;
    _name = "";
    _states = [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this._value;
    data['name'] = this._name;
    if (this._states != null) {
      data['states'] = this._states!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WooState {
  String? _value;
  String? _name;

  WooState({String? value, String? name}) {
    if (value != null) {
      this._value = value;
    }
    if (name != null) {
      this._name = name;
    }
  }

  String? get value => _value;

  set value(String? value) => _value = value;

  String? get name => _name;

  set name(String? name) => _name = name;

  WooState.fromJson(Map<String, dynamic> json) {
    _value = json['value'];
    _name = json['name'];
  }

  WooState.fromValue(String? value){
    _value = value;
    name = "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this._value;
    data['name'] = this._name;
    return data;
  }
}
