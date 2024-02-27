import 'package:hive/hive.dart';
part 'woo_variations_attributes.g.dart';

@HiveType(typeId: 8)
class WooVariationsAttributes {
  WooVariationsAttributes({
    int? id,
    String? name,
    String? option,
  }) {
    _id = id;
    _name = name;
    _option = option;
  }

  WooVariationsAttributes.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _option = json['option'];
  }

  @HiveField(0)
  int? _id;
  @HiveField(1)
  String? _name;
  @HiveField(2)
  String? _option;

  int? get id => _id;

  String? get name => _name;

  String? get option => _option;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['option'] = _option;
    return map;
  }
}