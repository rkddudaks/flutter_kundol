import 'package:hive/hive.dart';
part 'woo_variation_image.g.dart';

@HiveType(typeId: 7)
class WooVariationImage {
  WooVariationImage({
    int? id,
    String? dateCreated,
    String? dateCreatedGmt,
    String? dateModified,
    String? dateModifiedGmt,
    String? src,
    String? name,
    String? alt,
  }) {
    _id = id;
    _dateCreated = dateCreated;
    _dateCreatedGmt = dateCreatedGmt;
    _dateModified = dateModified;
    _dateModifiedGmt = dateModifiedGmt;
    _src = src;
    _name = name;
    _alt = alt;
  }

  WooVariationImage.fromJson(dynamic json) {
    _id = json['id'];
    _dateCreated = json['date_created'];
    _dateCreatedGmt = json['date_created_gmt'];
    _dateModified = json['date_modified'];
    _dateModifiedGmt = json['date_modified_gmt'];
    _src = json['src'];
    _name = json['name'];
    _alt = json['alt'];
  }

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
  String? _src;
  @HiveField(6)
  String? _name;
  @HiveField(7)
  String? _alt;

  int? get id => _id;

  String? get dateCreated => _dateCreated;

  String? get dateCreatedGmt => _dateCreatedGmt;

  String? get dateModified => _dateModified;

  String? get dateModifiedGmt => _dateModifiedGmt;

  String? get src => _src;

  String? get name => _name;

  String? get alt => _alt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date_created'] = _dateCreated;
    map['date_created_gmt'] = _dateCreatedGmt;
    map['date_modified'] = _dateModified;
    map['date_modified_gmt'] = _dateModifiedGmt;
    map['src'] = _src;
    map['name'] = _name;
    map['alt'] = _alt;
    return map;
  }
}