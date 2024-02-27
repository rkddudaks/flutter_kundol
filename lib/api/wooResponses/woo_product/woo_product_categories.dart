import 'package:hive/hive.dart';
part 'woo_product_categories.g.dart';

@HiveType(typeId: 3)
class WooProductCategories {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? slug;

  WooProductCategories({this.id, this.name, this.slug});

  WooProductCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}
