class WooCoupon {
  WooCoupon(
      {int? id,
      String? code,
      String? amount,
      String? dateCreated,
      String? dateCreatedGmt,
      String? dateModified,
      String? dateModifiedGmt,
      String? discountType,
      String? description,
      String? dateExpires,
      String? dateExpiresGmt,
      int? usageCount,
      bool? individualUse,
      List<int>? productIds,
      List<int>? excludedProductIds,
      int? usageLimit,
      int? usageLimitPerUser,
      int? limitUsageToXItems,
      bool? freeShipping,
      List<int>? productCategories,
      List<int>? excludedProductCategories,
      bool? excludeSaleItems,
      String? minimumAmount,
      String? maximumAmount,
      List<String>? emailRestrictions,
      List<String>? usedBy}) {
    _id = id;
    _code = code;
    _amount = amount;
    _dateCreated = dateCreated;
    _dateCreatedGmt = dateCreatedGmt;
    _dateModified = dateModified;
    _dateModifiedGmt = dateModifiedGmt;
    _discountType = discountType;
    _description = description;
    _dateExpires = dateExpires;
    _dateExpiresGmt = dateExpiresGmt;
    _usageCount = usageCount;
    _individualUse = individualUse;
    _productIds = productIds;
    _excludedProductIds = excludedProductIds;
    _usageLimit = usageLimit;
    _usageLimitPerUser = usageLimitPerUser;
    _limitUsageToXItems = limitUsageToXItems;
    _freeShipping = freeShipping;
    _productCategories = productCategories;
    _excludedProductCategories = excludedProductCategories;
    _excludeSaleItems = excludeSaleItems;
    _minimumAmount = minimumAmount;
    _maximumAmount = maximumAmount;
    _emailRestrictions = emailRestrictions;
    _usedBy = usedBy;
  }

  WooCoupon.fromJson(dynamic json) {
    _id = json['id'];
    _code = json['code'];
    _amount = json['amount'];
    _dateCreated = json['date_created'];
    _dateCreatedGmt = json['date_created_gmt'];
    _dateModified = json['date_modified'];
    _dateModifiedGmt = json['date_modified_gmt'];
    _discountType = json['discount_type'];
    _description = json['description'];
    _dateExpires = json['date_expires'];
    _dateExpiresGmt = json['date_expires_gmt'];
    _usageCount = json['usage_count'];
    _individualUse = json['individual_use'];
    _productIds =
        json['product_ids'] != null ? json['product_ids'].cast<int>() : [];
    _excludedProductIds = json['excluded_product_ids'] != null
        ? json['excluded_product_ids'].cast<int>()
        : [];
    _usageLimit = json['usage_limit'];
    _usageLimitPerUser = json['usage_limit_per_user'];
    _limitUsageToXItems = json['limit_usage_to_x_items'];
    _freeShipping = json['free_shipping'];
    _productCategories = json['product_categories'] != null
        ? json['product_categories'].cast<int>()
        : [];
    _excludedProductCategories = json['excluded_product_categories'] != null
        ? json['excluded_product_categories'].cast<int>()
        : [];
    _excludeSaleItems = json['exclude_sale_items'];
    _minimumAmount = json['minimum_amount'];
    _maximumAmount = json['maximum_amount'];
    _emailRestrictions = json['email_restrictions'] != null
        ? json['email_restrictions'].cast<String>()
        : [];
    _usedBy = json['used_by'] != null ? json['used_by'].cast<String>() : [];
  }

  int? _id;
  String? _code;
  String? _amount;
  String? _dateCreated;
  String? _dateCreatedGmt;
  String? _dateModified;
  String? _dateModifiedGmt;
  String? _discount;
  String? _discountType;
  String? _description;
  String? _dateExpires;
  String? _dateExpiresGmt;
  int? _usageCount;
  bool? _individualUse;
  List<int>? _productIds;
  List<int>? _excludedProductIds;
  List<int?> _validItems = [];
  int? _validItemsCount;
  int? _usageLimit;
  int? _usageLimitPerUser;
  int? _limitUsageToXItems;
  bool? _freeShipping;
  List<int>? _productCategories;
  List<int>? _excludedProductCategories;
  bool? _excludeSaleItems;
  String? _minimumAmount;
  String? _maximumAmount;
  List<String>? _emailRestrictions;
  List<String>? _usedBy;

  int? get id => _id;

  String? get code => _code;

  String? get amount => _amount;

  String? get dateCreated => _dateCreated;

  String? get dateCreatedGmt => _dateCreatedGmt;

  String? get dateModified => _dateModified;

  String? get dateModifiedGmt => _dateModifiedGmt;

  String? get discountType => _discountType;

  String? get discount => _discount;

  String? get description => _description;

  String? get dateExpires => _dateExpires;

  String? get dateExpiresGmt => _dateExpiresGmt;

  int? get usageCount => _usageCount;

  bool? get individualUse => _individualUse;

  List<int>? get productIds => _productIds;

  List<int?> get validItems => _validItems;

  int? get validItemsCount => _validItemsCount;

  List<int>? get excludedProductIds => _excludedProductIds;

  int? get usageLimit => _usageLimit;

  int? get usageLimitPerUser => _usageLimitPerUser;

  int? get limitUsageToXItems => _limitUsageToXItems;

  bool? get freeShipping => _freeShipping;

  List<int>? get productCategories => _productCategories;

  List<int>? get excludedProductCategories => _excludedProductCategories;

  bool? get excludeSaleItems => _excludeSaleItems;

  String? get minimumAmount => _minimumAmount;

  String? get maximumAmount => _maximumAmount;

  List<String>? get emailRestrictions => _emailRestrictions;

  List<String>? get usedBy => _usedBy;


  set id(int? value) {
    _id = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['code'] = _code;
    map['amount'] = _amount;
    map['date_created'] = _dateCreated;
    map['date_created_gmt'] = _dateCreatedGmt;
    map['date_modified'] = _dateModified;
    map['date_modified_gmt'] = _dateModifiedGmt;
    map['discount_type'] = _discountType;
    map['description'] = _description;
    map['date_expires'] = _dateExpires;
    map['date_expires_gmt'] = _dateExpiresGmt;
    map['usage_count'] = _usageCount;
    map['individual_use'] = _individualUse;
    map['product_ids'] = _productIds;
    map['excluded_product_ids'] = _excludedProductIds;
    map['usage_limit'] = _usageLimit;
    map['usage_limit_per_user'] = _usageLimitPerUser;
    map['limit_usage_to_x_items'] = _limitUsageToXItems;
    map['free_shipping'] = _freeShipping;
    map['product_categories'] = _productCategories;
    map['excluded_product_categories'] = _excludedProductCategories;
    map['exclude_sale_items'] = _excludeSaleItems;
    map['minimum_amount'] = _minimumAmount;
    map['maximum_amount'] = _maximumAmount;
    map['email_restrictions'] = _emailRestrictions;
    map['used_by'] = _usedBy;
    return map;
  }

  set code(String? value) {
    _code = value;
  }

  set amount(String? value) {
    _amount = value;
  }

  set dateCreated(String? value) {
    _dateCreated = value;
  }

  set dateCreatedGmt(String? value) {
    _dateCreatedGmt = value;
  }

  set dateModified(String? value) {
    _dateModified = value;
  }

  set dateModifiedGmt(String? value) {
    _dateModifiedGmt = value;
  }

  set discount(String? value) {
    _discount = value;
  }

  set discountType(String? value) {
    _discountType = value;
  }

  set description(String? value) {
    _description = value;
  }

  set dateExpires(String? value) {
    _dateExpires = value;
  }

  set dateExpiresGmt(String? value) {
    _dateExpiresGmt = value;
  }

  set usageCount(int? value) {
    _usageCount = value;
  }

  set individualUse(bool? value) {
    _individualUse = value;
  }

  set productIds(List<int>? value) {
    _productIds = value;
  }

  set excludedProductIds(List<int>? value) {
    _excludedProductIds = value;
  }

  set validItems(List<int?> value) {
    _validItems = value;
  }

  set validItemsCount(int? value) {
    _validItemsCount = value;
  }

  set usageLimit(int? value) {
    _usageLimit = value;
  }

  set usageLimitPerUser(int? value) {
    _usageLimitPerUser = value;
  }

  set limitUsageToXItems(int? value) {
    _limitUsageToXItems = value;
  }

  set freeShipping(bool? value) {
    _freeShipping = value;
  }

  set productCategories(List<int>? value) {
    _productCategories = value;
  }

  set excludedProductCategories(List<int>? value) {
    _excludedProductCategories = value;
  }

  set excludeSaleItems(bool? value) {
    _excludeSaleItems = value;
  }

  set minimumAmount(String? value) {
    _minimumAmount = value;
  }

  set maximumAmount(String? value) {
    _maximumAmount = value;
  }

  set emailRestrictions(List<String>? value) {
    _emailRestrictions = value;
  }

  set usedBy(List<String>? value) {
    _usedBy = value;
  }
}
