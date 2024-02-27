class WooNewsResponse {
  List<WooNewsData>? featureNews;
  List<WooNewsData>? latestNews;
  List<WooNewsCategory>? newsCategories;

  WooNewsResponse({this.featureNews, this.latestNews, this.newsCategories});

  WooNewsResponse.withError(String error) {
    featureNews = [];
    latestNews = [];
    newsCategories = [];
  }
}

class WooNewsData {
  WooNewsData(
      {int? id,
      String? date,
      String? dateGmt,
      Guid? guid,
      String? modified,
      String? modifiedGmt,
      String? slug,
      String? status,
      String? type,
      String? link,
      Title? title,
      Content? content,
      Excerpt? excerpt,
      int? author,
      int? featuredMedia,
      String? commentStatus,
      String? pingStatus,
      bool? sticky,
      String? template,
      String? format,
      List<dynamic>? meta,
      List<int>? categories,
      List<dynamic>? tags}) {
    _id = id;
    _date = date;
    _dateGmt = dateGmt;
    _guid = guid;
    _modified = modified;
    _modifiedGmt = modifiedGmt;
    _slug = slug;
    _status = status;
    _type = type;
    _link = link;
    _title = title;
    _content = content;
    _excerpt = excerpt;
    _author = author;
    _featuredMedia = featuredMedia;
    _commentStatus = commentStatus;
    _pingStatus = pingStatus;
    _sticky = sticky;
    _template = template;
    _format = format;
    _categories = categories;
  }

  WooNewsData.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];
    _dateGmt = json['date_gmt'];
    _guid = json['guid'] != null ? Guid.fromJson(json['guid']) : null;
    _modified = json['modified'];
    _modifiedGmt = json['modified_gmt'];
    _slug = json['slug'];
    _status = json['status'];
    _type = json['type'];
    _link = json['link'];
    _title = json['title'] != null ? Title.fromJson(json['title']) : null;
    _content =
        json['content'] != null ? Content.fromJson(json['content']) : null;
    _excerpt =
        json['excerpt'] != null ? Excerpt.fromJson(json['excerpt']) : null;
    _author = json['author'];
    _featuredMedia = json['featured_media'];
    _commentStatus = json['comment_status'];
    _pingStatus = json['ping_status'];
    _sticky = json['sticky'];
    _template = json['template'];
    _format = json['format'];
    _categories =
        json['categories'] != null ? json['categories'].cast<int>() : [];
  }

  int? _id;
  String? _date;
  String? _dateGmt;
  Guid? _guid;
  String? _modified;
  String? _modifiedGmt;
  String? _slug;
  String? _status;
  String? _type;
  String? _link;
  Title? _title;
  Content? _content;
  Excerpt? _excerpt;
  int? _author;
  int? _featuredMedia;
  String? _commentStatus;
  String? _pingStatus;
  bool? _sticky;
  String? _template;
  String? _format;
  List<int>? _categories;

  WooNewsData copyWith(
          {int? id,
          String? date,
          String? dateGmt,
          Guid? guid,
          String? modified,
          String? modifiedGmt,
          String? slug,
          String? status,
          String? type,
          String? link,
          Title? title,
          Content? content,
          Excerpt? excerpt,
          int? author,
          int? featuredMedia,
          String? commentStatus,
          String? pingStatus,
          bool? sticky,
          String? template,
          String? format,
          List<dynamic>? meta,
          List<int>? categories,
          List<dynamic>? tags}) =>
      WooNewsData(
        id: id ?? _id,
        date: date ?? _date,
        dateGmt: dateGmt ?? _dateGmt,
        guid: guid ?? _guid,
        modified: modified ?? _modified,
        modifiedGmt: modifiedGmt ?? _modifiedGmt,
        slug: slug ?? _slug,
        status: status ?? _status,
        type: type ?? _type,
        link: link ?? _link,
        title: title ?? _title,
        content: content ?? _content,
        excerpt: excerpt ?? _excerpt,
        author: author ?? _author,
        featuredMedia: featuredMedia ?? _featuredMedia,
        commentStatus: commentStatus ?? _commentStatus,
        pingStatus: pingStatus ?? _pingStatus,
        sticky: sticky ?? _sticky,
        template: template ?? _template,
        format: format ?? _format,
        categories: categories ?? _categories,
      );

  int? get id => _id;

  String? get date => _date;

  String? get dateGmt => _dateGmt;

  Guid? get guid => _guid;

  String? get modified => _modified;

  String? get modifiedGmt => _modifiedGmt;

  String? get slug => _slug;

  String? get status => _status;

  String? get type => _type;

  String? get link => _link;

  Title? get title => _title;

  Content? get content => _content;

  Excerpt? get excerpt => _excerpt;

  int? get author => _author;

  int? get featuredMedia => _featuredMedia;

  String? get commentStatus => _commentStatus;

  String? get pingStatus => _pingStatus;

  bool? get sticky => _sticky;

  String? get template => _template;

  String? get format => _format;

  List<int>? get categories => _categories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    map['date_gmt'] = _dateGmt;
    if (_guid != null) {
      map['guid'] = _guid!.toJson();
    }
    map['modified'] = _modified;
    map['modified_gmt'] = _modifiedGmt;
    map['slug'] = _slug;
    map['status'] = _status;
    map['type'] = _type;
    map['link'] = _link;
    if (_title != null) {
      map['title'] = _title!.toJson();
    }
    if (_content != null) {
      map['content'] = _content!.toJson();
    }
    if (_excerpt != null) {
      map['excerpt'] = _excerpt!.toJson();
    }
    map['author'] = _author;
    map['featured_media'] = _featuredMedia;
    map['comment_status'] = _commentStatus;
    map['ping_status'] = _pingStatus;
    map['sticky'] = _sticky;
    map['template'] = _template;
    map['format'] = _format;
    map['categories'] = _categories;
    return map;
  }
}

class Excerpt {
  Excerpt({
    String? rendered,
    bool? protected,
  }) {
    _rendered = rendered;
    _protected = protected;
  }

  Excerpt.fromJson(dynamic json) {
    _rendered = json['rendered'];
    _protected = json['protected'];
  }

  String? _rendered;
  bool? _protected;

  Excerpt copyWith({
    String? rendered,
    bool? protected,
  }) =>
      Excerpt(
        rendered: rendered ?? _rendered,
        protected: protected ?? _protected,
      );

  String? get rendered => _rendered;

  bool? get protected => _protected;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rendered'] = _rendered;
    map['protected'] = _protected;
    return map;
  }
}

class Content {
  Content({
    String? rendered,
    bool? protected,
  }) {
    _rendered = rendered;
    _protected = protected;
  }

  Content.fromJson(dynamic json) {
    _rendered = json['rendered'];
    _protected = json['protected'];
  }

  String? _rendered;
  bool? _protected;

  Content copyWith({
    String? rendered,
    bool? protected,
  }) =>
      Content(
        rendered: rendered ?? _rendered,
        protected: protected ?? _protected,
      );

  String? get rendered => _rendered;

  bool? get protected => _protected;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rendered'] = _rendered;
    map['protected'] = _protected;
    return map;
  }
}

class Title {
  Title({
    String? rendered,
  }) {
    _rendered = rendered;
  }

  Title.fromJson(dynamic json) {
    _rendered = json['rendered'];
  }

  String? _rendered;

  Title copyWith({
    String? rendered,
  }) =>
      Title(
        rendered: rendered ?? _rendered,
      );

  String? get rendered => _rendered;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rendered'] = _rendered;
    return map;
  }
}

class Guid {
  Guid({
    String? rendered,
  }) {
    _rendered = rendered;
  }

  Guid.fromJson(dynamic json) {
    _rendered = json['rendered'];
  }

  String? _rendered;

  Guid copyWith({
    String? rendered,
  }) =>
      Guid(
        rendered: rendered ?? _rendered,
      );

  String? get rendered => _rendered;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rendered'] = _rendered;
    return map;
  }
}

class WooNewsCategory {
  WooNewsCategory({
    int? id,
    int? count,
    String? description,
    String? link,
    String? name,
    String? slug,
    String? taxonomy,
    int? parent,}){
    _id = id;
    _count = count;
    _description = description;
    _link = link;
    _name = name;
    _slug = slug;
    _taxonomy = taxonomy;
    _parent = parent;
  }

  WooNewsCategory.fromJson(dynamic json) {
    _id = json['id'];
    _count = json['count'];
    _description = json['description'];
    _link = json['link'];
    _name = json['name'];
    _slug = json['slug'];
    _taxonomy = json['taxonomy'];
    _parent = json['parent'];
  }
  int? _id;
  int? _count;
  String? _description;
  String? _link;
  String? _name;
  String? _slug;
  String? _taxonomy;
  int? _parent;
  WooNewsCategory copyWith({  int? id,
    int? count,
    String? description,
    String? link,
    String? name,
    String? slug,
    String? taxonomy,
    int? parent,
  }) => WooNewsCategory(  id: id ?? _id,
    count: count ?? _count,
    description: description ?? _description,
    link: link ?? _link,
    name: name ?? _name,
    slug: slug ?? _slug,
    taxonomy: taxonomy ?? _taxonomy,
    parent: parent ?? _parent,
  );
  int? get id => _id;
  int? get count => _count;
  String? get description => _description;
  String? get link => _link;
  String? get name => _name;
  String? get slug => _slug;
  String? get taxonomy => _taxonomy;
  int? get parent => _parent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['count'] = _count;
    map['description'] = _description;
    map['link'] = _link;
    map['name'] = _name;
    map['slug'] = _slug;
    map['taxonomy'] = _taxonomy;
    map['parent'] = _parent;
    return map;
  }

}