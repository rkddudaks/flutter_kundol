import 'package:hive/hive.dart';

part 'woo_user_billing.g.dart';

@HiveType(typeId: 10)
class WooUserBilling {
  WooUserBilling({
    String? firstName,
    String? lastName,
    String? company,
    String? address1,
    String? address2,
    String? city,
    String? postcode,
    String? country,
    String? state,
    String? email,
    String? phone,
  }) {
    _firstName = firstName;
    _lastName = lastName;
    _company = company;
    _address1 = address1;
    _address2 = address2;
    _city = city;
    _postcode = postcode;
    _country = country;
    _state = state;
    _email = email;
    _phone = phone;
  }

  WooUserBilling.fromJson(dynamic json) {
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _company = json['company'];
    _address1 = json['address_1'];
    _address2 = json['address_2'];
    _city = json['city'];
    _postcode = json['postcode'];
    _country = json['country'];
    _state = json['state'];
    _email = json['email'];
    _phone = json['phone'];
  }

  @HiveField(0)
  String? _firstName;
  @HiveField(1)
  String? _lastName;
  @HiveField(2)
  String? _company;
  @HiveField(3)
  String? _address1;
  @HiveField(4)
  String? _address2;
  @HiveField(5)
  String? _city;
  @HiveField(6)
  String? _postcode;
  @HiveField(7)
  String? _country;
  @HiveField(8)
  String? _state;
  @HiveField(9)
  String? _email;
  @HiveField(10)
  String? _phone;

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String? get company => _company;

  String? get address1 => _address1;

  String? get address2 => _address2;

  String? get city => _city;

  String? get postcode => _postcode;

  String? get country => _country;

  String? get state => _state;

  String? get email => _email;

  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['company'] = _company;
    map['address_1'] = _address1;
    map['address_2'] = _address2;
    map['city'] = _city;
    map['postcode'] = _postcode;
    map['country'] = _country;
    map['state'] = _state;
    map['email'] = _email;
    map['phone'] = _phone;
    return map;
  }

  set phone(String? value) {
    _phone = value;
  }

  set email(String? value) {
    _email = value;
  }

  set state(String? value) {
    _state = value;
  }

  set country(String? value) {
    _country = value;
  }

  set postcode(String? value) {
    _postcode = value;
  }

  set city(String? value) {
    _city = value;
  }

  set address2(String? value) {
    _address2 = value;
  }

  set address1(String? value) {
    _address1 = value;
  }

  set company(String? value) {
    _company = value;
  }

  set lastName(String? value) {
    _lastName = value;
  }

  set firstName(String? value) {
    _firstName = value;
  }
}
