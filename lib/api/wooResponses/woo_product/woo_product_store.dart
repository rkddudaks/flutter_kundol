class WooProductStore {
  WooProductStore({
      int? vendorId, 
      String? vendorDisplayName, 
      String? vendorShopName, 
      String? formattedDisplayName, 
      String? vendorEmail, 
      String? vendorPhone, 
      String? vendorAddress, 
      String? vendorShopLogo, 
      String? vendorBanner, 
      String? storeRating, 
      String? vendorDescription,}){
    _vendorId = vendorId;
    _vendorDisplayName = vendorDisplayName;
    _vendorShopName = vendorShopName;
    _formattedDisplayName = formattedDisplayName;
    _vendorEmail = vendorEmail;
    _vendorPhone = vendorPhone;
    _vendorAddress = vendorAddress;
    _vendorShopLogo = vendorShopLogo;
    _vendorBanner = vendorBanner;
    _storeRating = storeRating;
    _vendorDescription = vendorDescription;
}

  WooProductStore.fromJson(dynamic json) {
    _vendorId = json['vendor_id'];
    _vendorDisplayName = json['vendor_display_name'];
    _vendorShopName = json['vendor_shop_name'];
    _formattedDisplayName = json['formatted_display_name'];
    _vendorEmail = json['vendor_email'];
    _vendorPhone = json['vendor_phone'];
    _vendorAddress = json['vendor_address'];
    _vendorShopLogo = json['vendor_shop_logo'];
    _vendorBanner = json['vendor_banner'];
    _storeRating = json['store_rating'];
    _vendorDescription = json['vendor_description'];
  }
  int? _vendorId;
  String? _vendorDisplayName;
  String? _vendorShopName;
  String? _formattedDisplayName;
  String? _vendorEmail;
  String? _vendorPhone;
  String? _vendorAddress;
  String? _vendorShopLogo;
  String? _vendorBanner;
  String? _storeRating;
  String? _vendorDescription;

  int? get vendorId => _vendorId;
  String? get vendorDisplayName => _vendorDisplayName;
  String? get vendorShopName => _vendorShopName;
  String? get formattedDisplayName => _formattedDisplayName;
  String? get vendorEmail => _vendorEmail;
  String? get vendorPhone => _vendorPhone;
  String? get vendorAddress => _vendorAddress;
  String? get vendorShopLogo => _vendorShopLogo;
  String? get vendorBanner => _vendorBanner;
  String? get storeRating => _storeRating;
  String? get vendorDescription => _vendorDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['vendor_id'] = _vendorId;
    map['vendor_display_name'] = _vendorDisplayName;
    map['vendor_shop_name'] = _vendorShopName;
    map['formatted_display_name'] = _formattedDisplayName;
    map['vendor_email'] = _vendorEmail;
    map['vendor_phone'] = _vendorPhone;
    map['vendor_address'] = _vendorAddress;
    map['vendor_shop_logo'] = _vendorShopLogo;
    map['vendor_banner'] = _vendorBanner;
    map['store_rating'] = _storeRating;
    map['vendor_description'] = _vendorDescription;
    return map;
  }

}