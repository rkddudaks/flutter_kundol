import 'package:hive/hive.dart';

part 'woo_login_response.g.dart';

@HiveType(typeId: 12)
class WooLoginResponse {
  WooLoginResponse({
    String? cookie,
    WooLoginUser? user,
  }) {
    _cookie = cookie;
    _user = user;
  }

  WooLoginResponse.fromJson(dynamic json) {
    _cookie = json['cookie'];
    _user = json['user'] != null ? WooLoginUser.fromJson(json['user']) : null;
  }

  WooLoginResponse.withError(String error) {
    _cookie = "";
    _user = null;
  }

  @HiveField(0)
  String? _cookie;
  @HiveField(1)
  WooLoginUser? _user;

  String? get cookie => _cookie;

  WooLoginUser? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cookie'] = _cookie;
    if (_user != null) {
      map['user'] = _user!.toJson();
    }
    return map;
  }
}

class WooLoginUser {
  WooLoginUser({
    int? id,
    String? username,
    String? nicename,
    String? email,
    String? displayName,
    String? firstName,
    String? lastName,
    String? nickname,
    String? description,
  }) {
    _id = id;
    _username = username;
    _nicename = nicename;
    _email = email;
    _displayName = displayName;
    _firstName = firstName;
    _lastName = lastName;
    _nickname = nickname;
    _description = description;
  }

  WooLoginUser.fromJson(dynamic json) {
    _id = json['id'];
    _username = json['username'];
    _nicename = json['nicename'];
    _email = json['email'];
    _displayName = json['display_name'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _nickname = json['nickname'];
    _description = json['description'];
  }

  int? _id;
  String? _username;
  String? _nicename;
  String? _email;
  String? _displayName;
  String? _firstName;
  String? _lastName;
  String? _nickname;
  String? _description;

  int? get id => _id;

  String? get username => _username;

  String? get nicename => _nicename;

  String? get email => _email;

  String? get displayName => _displayName;

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String? get nickname => _nickname;

  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['username'] = _username;
    map['nicename'] = _nicename;
    map['email'] = _email;
    map['display_name'] = _displayName;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['nickname'] = _nickname;
    map['description'] = _description;
    return map;
  }
}
