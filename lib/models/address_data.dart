import 'package:flutter_kundol/api/responses/woo_countries_response.dart';
// import 'package:hive/hive.dart';

class AddressData {
  AddressData({
    String? firstName,
    String? lastName,
    String? company,
    String? address1,
    String? address2,
    String? city,
    String? postcode,
    WooCountry? country,
    WooState? state,
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

  String? _firstName;
  String? _lastName;
  String? _company;
  String? _address1;
  String? _address2;
  String? _city;
  String? _postcode;
  WooCountry? _country;
  WooState? _state;
  String? _email;
  String? _phone;

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String? get company => _company;

  String? get address1 => _address1;

  String? get address2 => _address2;

  String? get city => _city;

  String? get postcode => _postcode;

  WooCountry? get country => _country;

  WooState? get state => _state;

  String? get email => _email;

  String? get phone => _phone;

  set phone(String? value) {
    _phone = value;
  }

  set email(String? value) {
    _email = value;
  }

  set state(WooState? value) {
    _state = value;
  }

  set country(WooCountry? value) {
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
