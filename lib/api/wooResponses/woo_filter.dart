import 'package:flutter_kundol/api/wooResponses/woo_variation.dart';

class WooFilter {
  WooFilter({
    int? id,
    String? name,
    String? slug,
    String? type,
    String? orderBy,
    bool? hasArchives,
  }) {
    _id = id;
    _name = name;
    _slug = slug;
    _type = type;
    _orderBy = orderBy;
    _hasArchives = hasArchives;
  }

  WooFilter.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _type = json['type'];
    _orderBy = json['order_by'];
    _hasArchives = json['has_archives'];
  }

  int? _id;
  String? _name;
  String? _slug;
  String? _type;
  String? _orderBy;
  bool? _hasArchives;
  List<WooVariation>? _variations;

  WooFilter copyWith({
    int? id,
    String? name,
    String? slug,
    String? type,
    String? orderBy,
    bool? hasArchives,
  }) =>
      WooFilter(
        id: id ?? _id,
        name: name ?? _name,
        slug: slug ?? _slug,
        type: type ?? _type,
        orderBy: orderBy ?? _orderBy,
        hasArchives: hasArchives ?? _hasArchives,
      );

  int? get id => _id;

  String? get name => _name;

  String? get slug => _slug;

  String? get type => _type;

  String? get orderBy => _orderBy;

  bool? get hasArchives => _hasArchives;

  List<WooVariation>? get variations => _variations;

  set variations(List<WooVariation>? value) {
    _variations = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    map['type'] = _type;
    map['order_by'] = _orderBy;
    map['has_archives'] = _hasArchives;
    return map;
  }
}
