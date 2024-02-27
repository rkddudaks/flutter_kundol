class WooReview {
  WooReview({
      int? id,
      String? dateCreated,
      String? dateCreatedGmt,
      int? productId,
      String? status,
      String? reviewer,
      String? reviewerEmail,
      String? review,
      int? rating,
      bool? verified,
      ReviewerAvatarUrls? reviewerAvatarUrls}){
    _id = id;
    _dateCreated = dateCreated;
    _dateCreatedGmt = dateCreatedGmt;
    _productId = productId;
    _status = status;
    _reviewer = reviewer;
    _reviewerEmail = reviewerEmail;
    _review = review;
    _rating = rating;
    _verified = verified;
    _reviewerAvatarUrls = reviewerAvatarUrls;
}

  WooReview.fromJson(dynamic json) {
    _id = json['id'];
    _dateCreated = json['date_created'];
    _dateCreatedGmt = json['date_created_gmt'];
    _productId = json['product_id'];
    _status = json['status'];
    _reviewer = json['reviewer'];
    _reviewerEmail = json['reviewer_email'];
    _review = json['review'];
    _rating = json['rating'];
    _verified = json['verified'];
    _reviewerAvatarUrls = json['reviewer_avatar_urls'] != null ? ReviewerAvatarUrls.fromJson(json['reviewer_avatar_urls']) : null;
  }
  int? _id;
  String? _dateCreated;
  String? _dateCreatedGmt;
  int? _productId;
  String? _status;
  String? _reviewer;
  String? _reviewerEmail;
  String? _review;
  int? _rating;
  bool? _verified;
  ReviewerAvatarUrls? _reviewerAvatarUrls;

  int? get id => _id;
  String? get dateCreated => _dateCreated;
  String? get dateCreatedGmt => _dateCreatedGmt;
  int? get productId => _productId;
  String? get status => _status;
  String? get reviewer => _reviewer;
  String? get reviewerEmail => _reviewerEmail;
  String? get review => _review;
  int? get rating => _rating;
  bool? get verified => _verified;
  ReviewerAvatarUrls? get reviewerAvatarUrls => _reviewerAvatarUrls;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date_created'] = _dateCreated;
    map['date_created_gmt'] = _dateCreatedGmt;
    map['product_id'] = _productId;
    map['status'] = _status;
    map['reviewer'] = _reviewer;
    map['reviewer_email'] = _reviewerEmail;
    map['review'] = _review;
    map['rating'] = _rating;
    map['verified'] = _verified;
    if (_reviewerAvatarUrls != null) {
      map['reviewer_avatar_urls'] = _reviewerAvatarUrls!.toJson();
    }
    return map;
  }

}

class ReviewerAvatarUrls {
  String? s24;
  String? s48;
  String? s96;

  ReviewerAvatarUrls({this.s24, this.s48, this.s96});

  ReviewerAvatarUrls.fromJson(Map<String, dynamic> json) {
    s24 = json['24'];
    s48 = json['48'];
    s96 = json['96'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['24'] = this.s24;
    data['48'] = this.s48;
    data['96'] = this.s96;
    return data;
  }
}