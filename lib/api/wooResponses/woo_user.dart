import 'package:flutter_kundol/api/wooResponses/woo_user_billing.dart';
import 'package:flutter_kundol/api/wooResponses/woo_user_shipping.dart';
import 'package:hive/hive.dart';
part 'woo_user.g.dart';

@HiveType(typeId: 9)
class WooUser {
  WooUser({
    int? id,
    String? dateCreated,
    String? dateCreatedGmt,
    String? dateModified,
    String? dateModifiedGmt,
    String? email,
    String? firstName,
    String? lastName,
    String? role,
    String? username,
    WooUserBilling? billing,
    WooUserShipping? shipping,
    bool? isPayingCustomer,
    String? avatarUrl,
    String? cookie,
  }) {
    _id = id;
    _dateCreated = dateCreated;
    _dateCreatedGmt = dateCreatedGmt;
    _dateModified = dateModified;
    _dateModifiedGmt = dateModifiedGmt;
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _role = role;
    _username = username;
    _billing = billing;
    _shipping = shipping;
    _isPayingCustomer = isPayingCustomer;
    _avatarUrl = avatarUrl;
    _cookie = cookie;
  }

  WooUser.fromJson(dynamic json, String? cookie) {
    _id = json['id'];
    _dateCreated = json['date_created'];
    _dateCreatedGmt = json['date_created_gmt'];
    _dateModified = json['date_modified'];
    _dateModifiedGmt = json['date_modified_gmt'];
    _email = json['email'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _role = json['role'];
    _username = json['username'];
    _billing = json['billing'] != null
        ? WooUserBilling.fromJson(json['billing'])
        : null;
    _shipping = json['shipping'] != null
        ? WooUserShipping.fromJson(json['shipping'])
        : null;
    _isPayingCustomer = json['is_paying_customer'];
    _avatarUrl = json['avatar_url'];
    _cookie = cookie;
  }

  WooUser.withError(String error);

  @HiveField(0)
  int? _id;
  @HiveField(1)
  String? _dateCreated;
  @HiveField(2)
  String? _dateCreatedGmt;
  @HiveField(3)
  String? _dateModified;
  @HiveField(4)
  String? _dateModifiedGmt;
  @HiveField(5)
  String? _email;
  @HiveField(6)
  String? _firstName;
  @HiveField(7)
  String? _lastName;
  @HiveField(8)
  String? _role;
  @HiveField(9)
  String? _username;
  @HiveField(10)
  WooUserBilling? _billing;
  @HiveField(11)
  WooUserShipping? _shipping;
  @HiveField(12)
  bool? _isPayingCustomer;
  @HiveField(13)
  String? _avatarUrl;
  @HiveField(14)
  String? _cookie;

  int? get id => _id;

  String? get dateCreated => _dateCreated;

  String? get dateCreatedGmt => _dateCreatedGmt;

  String? get dateModified => _dateModified;

  String? get dateModifiedGmt => _dateModifiedGmt;

  String? get email => _email;

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String? get role => _role;

  String? get username => _username;

  WooUserBilling? get billing => _billing;

  WooUserShipping? get shipping => _shipping;

  bool? get isPayingCustomer => _isPayingCustomer;

  String? get avatarUrl => _avatarUrl;

  String? get cookie => _cookie;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date_created'] = _dateCreated;
    map['date_created_gmt'] = _dateCreatedGmt;
    map['date_modified'] = _dateModified;
    map['date_modified_gmt'] = _dateModifiedGmt;
    map['email'] = _email;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['role'] = _role;
    map['username'] = _username;
    if (_billing != null) {
      map['billing'] = _billing!.toJson();
    }
    if (_shipping != null) {
      map['shipping'] = _shipping!.toJson();
    }
    map['is_paying_customer'] = _isPayingCustomer;
    map['avatar_url'] = _avatarUrl;
    return map;
  }

  set avatarUrl(String? value) {
    _avatarUrl = value;
  }

  set isPayingCustomer(bool? value) {
    _isPayingCustomer = value;
  }

  set shipping(WooUserShipping? value) {
    _shipping = value;
  }

  set billing(WooUserBilling? value) {
    _billing = value;
  }

  set username(String? value) {
    _username = value;
  }

  set role(String? value) {
    _role = value;
  }

  set lastName(String? value) {
    _lastName = value;
  }

  set firstName(String? value) {
    _firstName = value;
  }

  set email(String? value) {
    _email = value;
  }

  set dateModifiedGmt(String? value) {
    _dateModifiedGmt = value;
  }

  set dateModified(String? value) {
    _dateModified = value;
  }

  set dateCreatedGmt(String? value) {
    _dateCreatedGmt = value;
  }

  set dateCreated(String? value) {
    _dateCreated = value;
  }

  set id(int? value) {
    _id = value;
  }

  set cookie(String? value) {
    _cookie = value;
  }
}
