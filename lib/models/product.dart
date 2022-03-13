class Product {
  String? id;
  int? atomicPrice;
  String? masterProductId;
  String? name;
  String? imageUrl;
  String? categoryId;
  bool? isDeleted;

  Product(
      {this.id,
        this.atomicPrice,
        this.masterProductId,
        this.name,
        this.imageUrl,
        this.categoryId,
        this.isDeleted,});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    atomicPrice = json['atomicPrice'];
    masterProductId = json['masterProductId'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    categoryId = json['categoryId'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['atomicPrice'] = this.atomicPrice;
    data['masterProductId'] = this.masterProductId;
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    data['categoryId'] = this.categoryId;
    data['isDeleted'] = this.isDeleted;
    return data;
  }
}
