class WooPaymentMethod {
  WooPaymentMethod({
      String? id, 
      String? title, 
      String? description, 
      String? order,
      bool? enabled, 
      String? methodTitle, 
      String? methodDescription, 
      List<String>? methodSupports, 
      Settings? settings,}){
    _id = id;
    _title = title;
    _description = description;
    _order = order;
    _enabled = enabled;
    _methodTitle = methodTitle;
    _methodDescription = methodDescription;
    _methodSupports = methodSupports;
    _settings = settings;
}

  WooPaymentMethod.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _order = json['order'];
    _enabled = json['enabled'];
    _methodTitle = json['method_title'];
    _methodDescription = json['method_description'];
    _methodSupports = json['method_supports'] != null ? json['method_supports'].cast<String>() : [];
    _settings = json['settings'] != null ? Settings.fromJson(json['settings']) : null;
  }
  String? _id;
  String? _title;
  String? _description;
  String? _order;
  bool? _enabled;
  String? _methodTitle;
  String? _methodDescription;
  List<String>? _methodSupports;
  Settings? _settings;

  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get order => _order;
  bool? get enabled => _enabled;
  String? get methodTitle => _methodTitle;
  String? get methodDescription => _methodDescription;
  List<String>? get methodSupports => _methodSupports;
  Settings? get settings => _settings;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['order'] = _order;
    map['enabled'] = _enabled;
    map['method_title'] = _methodTitle;
    map['method_description'] = _methodDescription;
    map['method_supports'] = _methodSupports;
    if (_settings != null) {
      map['settings'] = _settings!.toJson();
    }
    return map;
  }

}

class Settings {
  Settings({
      Title? title, 
      Instructions? instructions,}){
    _title = title;
    _instructions = instructions;
}

  Settings.fromJson(dynamic json) {
    _title = json['title'] != null ? Title.fromJson(json['title']) : null;
    _instructions = json['instructions'] != null ? Instructions.fromJson(json['instructions']) : null;
  }
  Title? _title;
  Instructions? _instructions;

  Title? get title => _title;
  Instructions? get instructions => _instructions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_title != null) {
      map['title'] = _title!.toJson();
    }
    if (_instructions != null) {
      map['instructions'] = _instructions!.toJson();
    }
    return map;
  }

}

class Instructions {
  Instructions({
      String? id, 
      String? label, 
      String? description, 
      String? type, 
      String? value, 
      String? defaultt,
      String? tip, 
      String? placeholder,}){
    _id = id;
    _label = label;
    _description = description;
    _type = type;
    _value = value;
    _default = defaultt;
    _tip = tip;
    _placeholder = placeholder;
}

  Instructions.fromJson(dynamic json) {
    _id = json['id'];
    _label = json['label'];
    _description = json['description'];
    _type = json['type'];
    _value = json['value'];
    _default = json['default'];
    _tip = json['tip'];
    _placeholder = json['placeholder'];
  }
  String? _id;
  String? _label;
  String? _description;
  String? _type;
  String? _value;
  String? _default;
  String? _tip;
  String? _placeholder;

  String? get id => _id;
  String? get label => _label;
  String? get description => _description;
  String? get type => _type;
  String? get value => _value;
  String? get defaultt => _default;
  String? get tip => _tip;
  String? get placeholder => _placeholder;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['label'] = _label;
    map['description'] = _description;
    map['type'] = _type;
    map['value'] = _value;
    map['default'] = _default;
    map['tip'] = _tip;
    map['placeholder'] = _placeholder;
    return map;
  }

}

class Title {
  Title({
      String? id, 
      String? label, 
      String? description, 
      String? type, 
      String? value, 
      String? defaultt,
      String? tip, 
      String? placeholder,}){
    _id = id;
    _label = label;
    _description = description;
    _type = type;
    _value = value;
    _default = defaultt;
    _tip = tip;
    _placeholder = placeholder;
}

  Title.fromJson(dynamic json) {
    _id = json['id'];
    _label = json['label'];
    _description = json['description'];
    _type = json['type'];
    _value = json['value'];
    _default = json['default'];
    _tip = json['tip'];
    _placeholder = json['placeholder'];
  }
  String? _id;
  String? _label;
  String? _description;
  String? _type;
  String? _value;
  String? _default;
  String? _tip;
  String? _placeholder;

  String? get id => _id;
  String? get label => _label;
  String? get description => _description;
  String? get type => _type;
  String? get value => _value;
  String? get defaultt => _default;
  String? get tip => _tip;
  String? get placeholder => _placeholder;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['label'] = _label;
    map['description'] = _description;
    map['type'] = _type;
    map['value'] = _value;
    map['default'] = _default;
    map['tip'] = _tip;
    map['placeholder'] = _placeholder;
    return map;
  }

}