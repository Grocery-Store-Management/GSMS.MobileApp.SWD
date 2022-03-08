class ImportOrder {
  String? id;
  String? name;
  String? productId;
  String? storeId;
  bool? isDeleted;
  String? createdDate;
  String? store;

  ImportOrder({
    this.id,
    this.name,
    this.productId,
    this.storeId,
    this.isDeleted,
    this.createdDate,
    this.store,
  });

  ImportOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    productId = json['productId'];
    storeId = json['storeId'];
    isDeleted = json['isDeleted'];
    createdDate = json['createdDate'];
    store = json['store'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['productId'] = this.productId;
    data['storeId'] = this.storeId;
    data['isDeleted'] = this.isDeleted;
    data['createdDate'] = this.createdDate;
    data['store'] = this.store;
    return data;
  }
}
