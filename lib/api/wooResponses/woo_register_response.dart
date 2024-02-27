class WooRegisterResponse {
  WooRegisterResponse({
    String? firstName,
    String? lastName,
    String? userLogin,
    String? userEmail,
    String? userPass,
    dynamic displayName,
    String? userNicename,
    String? nickname,
    String? role,
  }) {
    _firstName = firstName;
    _lastName = lastName;
    _userLogin = userLogin;
    _userEmail = userEmail;
    _userPass = userPass;
    _displayName = displayName;
    _userNicename = userNicename;
    _nickname = nickname;
    _role = role;
  }

  WooRegisterResponse.fromJson(dynamic json) {
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _userLogin = json['user_login'];
    _userEmail = json['user_email'];
    _userPass = json['user_pass'];
    _displayName = json['display_name'];
    _userNicename = json['user_nicename'];
    _nickname = json['nickname'];
    _role = json['role'];
  }

  WooRegisterResponse.withError(String error);

  String? _firstName;
  String? _lastName;
  String? _userLogin;
  String? _userEmail;
  String? _userPass;
  dynamic _displayName;
  String? _userNicename;
  String? _nickname;
  String? _role;

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String? get userLogin => _userLogin;

  String? get userEmail => _userEmail;

  String? get userPass => _userPass;

  dynamic get displayName => _displayName;

  String? get userNicename => _userNicename;

  String? get nickname => _nickname;

  String? get role => _role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['user_login'] = _userLogin;
    map['user_email'] = _userEmail;
    map['user_pass'] = _userPass;
    map['display_name'] = _displayName;
    map['user_nicename'] = _userNicename;
    map['nickname'] = _nickname;
    map['role'] = _role;
    return map;
  }
}
