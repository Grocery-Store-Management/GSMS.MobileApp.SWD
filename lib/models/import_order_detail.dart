class ImportOrderDetail {
  String? id;
  String? importOrderId;
  String? name;
  String? distributor;
  String? productId;
  int? quantity;
  bool? isDeleted;
  int? price;

  ImportOrderDetail(
      {this.id,
        this.importOrderId,
        this.name,
        this.distributor,
        this.productId,
        this.quantity,
        this.isDeleted,
        this.price,});

  ImportOrderDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    importOrderId = json['importOrderId'];
    name = json['name'];
    distributor = json['distributor'];
    productId = json['productId'];
    quantity = json['quantity'];
    isDeleted = json['isDeleted'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['importOrderId'] = importOrderId;
    data['name'] = name;
    data['distributor'] = distributor;
    data['productId'] = productId;
    data['quantity'] = quantity;
    data['isDeleted'] = isDeleted;
    data['price'] = price;
    return data;
  }
}