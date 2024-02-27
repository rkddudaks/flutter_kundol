import 'package:hive/hive.dart';
part 'woo_product_dimensions.g.dart';

@HiveType(typeId: 4)
class WooProductDimensions {
  @HiveField(0)
  String? length;
  @HiveField(1)
  String? width;
  @HiveField(2)
  String? height;

  WooProductDimensions({this.length, this.width, this.height});

  WooProductDimensions.fromJson(Map<String, dynamic> json) {
    length = json['length'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['length'] = this.length;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}