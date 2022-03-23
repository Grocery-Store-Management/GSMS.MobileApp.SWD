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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['productId'] = productId;
    data['storeId'] = storeId;
    data['isDeleted'] = isDeleted;
    data['createdDate'] = createdDate;
    data['store'] = store;
    return data;
  }
}
