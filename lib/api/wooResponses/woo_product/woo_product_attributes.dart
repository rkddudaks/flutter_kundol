import 'package:hive/hive.dart';
part 'woo_product_attributes.g.dart';

@HiveType(typeId: 2)
class WooProductAttributes {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  int? position;
  @HiveField(3)
  bool? visible;
  @HiveField(4)
  bool? variation;
  @HiveField(5)
  String? option;
  @HiveField(6)
  List<String?>? options;

  WooProductAttributes(
      {this.id,
        this.name,
        this.position,
        this.visible,
        this.variation,
        this.options});

  WooProductAttributes.copy(WooProductAttributes attributes) {
    this.id = attributes.id;
    this.name = attributes.name;
    this.position = attributes.position;
    this.visible = attributes.visible;
    this.variation = attributes.variation;
    this.option = attributes.option;
    this.options = attributes.options;
  }

  WooProductAttributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    position = json['position'];
    visible = json['visible'];
    variation = json['variation'];
    options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['position'] = this.position;
    data['visible'] = this.visible;
    data['variation'] = this.variation;
    data['options'] = this.options;
    return data;
  }
}