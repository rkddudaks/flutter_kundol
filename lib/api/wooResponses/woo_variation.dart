class WooVariation {
  WooVariation({
    int? id,
    String? name,
    String? slug,
    String? description,
    int? menuOrder,
    int? count,
  }) {
    _id = id;
    _name = name;
    _slug = slug;
    _description = description;
    _menuOrder = menuOrder;
    _count = count;
  }

  WooVariation.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _description = json['description'];
    _menuOrder = json['menu_order'];
    _count = json['count'];
  }

  int? _id;
  String? _name;
  String? _slug;
  String? _description;
  int? _menuOrder;
  int? _count;

  WooVariation copyWith({
    int? id,
    String? name,
    String? slug,
    String? description,
    int? menuOrder,
    int? count,
  }) =>
      WooVariation(
        id: id ?? _id,
        name: name ?? _name,
        slug: slug ?? _slug,
        description: description ?? _description,
        menuOrder: menuOrder ?? _menuOrder,
        count: count ?? _count,
      );

  int? get id => _id;

  String? get name => _name;

  String? get slug => _slug;

  String? get description => _description;

  int? get menuOrder => _menuOrder;

  int? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    map['description'] = _description;
    map['menu_order'] = _menuOrder;
    map['count'] = _count;
    return map;
  }
}
