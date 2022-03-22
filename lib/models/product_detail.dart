class ProductDetail {
  String? id;
  String? productId;
  double? price;
  int? status;
  int? storedQuantity;

  ProductDetail(
      {this.id,
        this.productId,
        this.price,
        this.status,
        this.storedQuantity,});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    price = json['price'];
    status = json['status'];
    storedQuantity = json['storedQuantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['price'] = this.price;
    data['status'] = this.status;
    data['storedQuantity'] = this.storedQuantity;
    return data;
  }
}