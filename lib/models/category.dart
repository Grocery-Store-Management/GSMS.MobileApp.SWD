class Category {
  String? id;
  String? name;
  bool? isDeleted;

  Category({this.id, this.name, this.isDeleted});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['isDeleted'] = this.isDeleted;
    return data;
  }
}