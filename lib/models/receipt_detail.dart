class ReceiptDetail {
  String? id;
  String? receiptId;
  String? productId;
  int? quantity;
  String? createdDate;
  String? name;
  double? price;

  ReceiptDetail(
      {this.id,
        this.receiptId,
        this.productId,
        this.quantity,
        this.createdDate,
        this.name,
        this.price});

  ReceiptDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    receiptId = json['receiptId'];
    productId = json['productId'];
    quantity = json['quantity'];
    createdDate = json['createdDate'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['receiptId'] = this.receiptId;
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    data['createdDate'] = this.createdDate;
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}