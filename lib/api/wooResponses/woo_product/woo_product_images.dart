import 'package:hive/hive.dart';
part 'woo_product_images.g.dart';

@HiveType(typeId: 5)
class WooProductImages {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? dateCreated;
  @HiveField(2)
  String? dateCreatedGmt;
  @HiveField(3)
  String? dateModified;
  @HiveField(4)
  String? dateModifiedGmt;
  @HiveField(5)
  String? src;
  @HiveField(6)
  String? name;
  @HiveField(7)
  String? alt;

  WooProductImages(
      {this.id,
        this.dateCreated,
        this.dateCreatedGmt,
        this.dateModified,
        this.dateModifiedGmt,
        this.src,
        this.name,
        this.alt});

  WooProductImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    if(json['src'] != null){
      src=json['src'];
    }
   // src = json['src'];
    name = json['name'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['src'] = this.src;
    data['name'] = this.name;
    data['alt'] = this.alt;
    return data;
  }
}