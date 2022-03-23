class Brand {
  String? id;
  String? name;
  String? createdDate;
  bool? isDeleted;

  Brand({this.id, this.name, this.createdDate, this.isDeleted});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdDate = json['createdDate'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['createdDate'] = this.createdDate;
    data['isDeleted'] = this.isDeleted;
    return data;
  }
}