class Store {
  String? id;
  String? name;
  String? brandId;
  int? status;
  String? createdDate;
  bool? isDeleted;

  Store(
      {this.id,
        this.name,
        this.brandId,
        this.status,
        this.createdDate,
        this.isDeleted});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    brandId = json['brandId'];
    status = json['status'];
    createdDate = json['createdDate'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['brandId'] = this.brandId;
    data['status'] = this.status;
    data['createdDate'] = this.createdDate;
    data['isDeleted'] = this.isDeleted;
    return data;
  }
}