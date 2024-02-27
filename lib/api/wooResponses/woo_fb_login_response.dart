class WooFbLoginResponse {
  WooFbLoginResponse({
      String? msg, 
      int? id, 
      String? cookie, 
      String? userLogin, 
      WooFbUser? user,}){
    _msg = msg;
    _id = id;
    _cookie = cookie;
    _userLogin = userLogin;
    _user = user;
}

  WooFbLoginResponse.fromJson(dynamic json) {
    _msg = json['msg'];
    _id = json['id'];
    _cookie = json['cookie'];
    _userLogin = json['user_login'];
    _user = json['user'] != null ? WooFbUser.fromJson(json['user']) : null;
  }
  String? _msg;
  int? _id;
  String? _cookie;
  String? _userLogin;
  WooFbUser? _user;

  String? get msg => _msg;
  int? get id => _id;
  String? get cookie => _cookie;
  String? get userLogin => _userLogin;
  WooFbUser? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    map['id'] = _id;
    map['cookie'] = _cookie;
    map['user_login'] = _userLogin;
    if (_user != null) {
      map['user'] = _user!.toJson();
    }
    return map;
  }

}

class WooFbUser {
  WooFbUser({
      String? id, 
      String? name, 
      String? firstName, 
      String? lastName, 
      String? email, 
      WooFbUserPicture? picture,}){
    _id = id;
    _name = name;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _picture = picture;
}

  WooFbUser.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _picture = json['picture'] != null ? WooFbUserPicture.fromJson(json['picture']) : null;
  }
  String? _id;
  String? _name;
  String? _firstName;
  String? _lastName;
  String? _email;
  WooFbUserPicture? _picture;

  String? get id => _id;
  String? get name => _name;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  WooFbUserPicture? get picture => _picture;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    if (_picture != null) {
      map['picture'] = _picture!.toJson();
    }
    return map;
  }

}

class WooFbUserPicture {
  WooFbUserPicture({
      WooFbUserPictureData? data,}){
    _data = data;
}

  WooFbUserPicture.fromJson(dynamic json) {
    _data = json['data'] != null ? WooFbUserPictureData.fromJson(json['data']) : null;
  }
  WooFbUserPictureData? _data;

  WooFbUserPictureData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data!.toJson();
    }
    return map;
  }

}

class WooFbUserPictureData {
  WooFbUserPictureData({
      int? height, 
      bool? isSilhouette, 
      String? url, 
      int? width,}){
    _height = height;
    _isSilhouette = isSilhouette;
    _url = url;
    _width = width;
}

  WooFbUserPictureData.fromJson(dynamic json) {
    _height = json['height'];
    _isSilhouette = json['is_silhouette'];
    _url = json['url'];
    _width = json['width'];
  }
  int? _height;
  bool? _isSilhouette;
  String? _url;
  int? _width;

  int? get height => _height;
  bool? get isSilhouette => _isSilhouette;
  String? get url => _url;
  int? get width => _width;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['height'] = _height;
    map['is_silhouette'] = _isSilhouette;
    map['url'] = _url;
    map['width'] = _width;
    return map;
  }

}