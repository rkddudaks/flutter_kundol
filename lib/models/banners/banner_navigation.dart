class BannerNavigation {
  int? id;
  String? name;

  BannerNavigation({this.id, this.name});

  BannerNavigation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}