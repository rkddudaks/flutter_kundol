import 'package:flutter_kundol/constants/app_constants.dart';
// import 'package:flutter_kundol/models/category.dart';

class WooCategoriesResponse {
  String? _status;
  String? _error;
  List<WooCategory>? _data;

  CategoriesResponse({List<WooCategory>? data}) {
    _data = data;
    _status = AppConstants.STATUS_SUCCESS;
    _error = null;
  }

  WooCategoriesResponse.fromJson(List<dynamic>? json) {
    if (json != null) {
      _data = [];
      json.forEach((v) {
        _data!.add(new WooCategory.fromJson(v));
      });
    }
    _status = AppConstants.STATUS_SUCCESS;
    _error = null;
  }

  WooCategoriesResponse.withError(String error) {
    _data = null;
    _status = AppConstants.STATUS_ERROR;
    _error = error;
  }

  List<Map<String, dynamic>> toJson() {
    List<Map<String, dynamic>> data = [];
    if (this._data != null) {
      data = this._data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  List<WooCategory>? get data => _data;

  String? get error => _error;

  String? get status => _status;

  set data(List<WooCategory>? value) {
    _data = value;
  }

  set error(String? value) {
    _error = value;
  }

  set status(String? value) {
    _status = value;
  }
}

class WooCategory {
  int? id;
  String? name;
  String? slug;
  int? parent;
  String? description;
  String? display;
  WooCategoryImage? image;
  int? menuOrder;
  int? count;

  WooCategory(
      {this.id,
      this.name,
      this.slug,
      this.parent,
      this.description,
      this.display,
      this.image,
      this.menuOrder,
      this.count});

  WooCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    parent = json['parent'];
    description = json['description'];
    display = json['display'];
    image = json['image'] != null
        ? new WooCategoryImage.fromJson(json['image'])
        : null;
    menuOrder = json['menu_order'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['parent'] = this.parent;
    data['description'] = this.description;
    data['display'] = this.display;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['menu_order'] = this.menuOrder;
    data['count'] = this.count;
    return data;
  }
}

class WooCategoryImage {
  int? id;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? src;
  String? name;
  String? alt;

  WooCategoryImage(
      {this.id,
      this.dateCreated,
      this.dateCreatedGmt,
      this.dateModified,
      this.dateModifiedGmt,
      this.src,
      this.name,
      this.alt});

  WooCategoryImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    src = json['src'];
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
