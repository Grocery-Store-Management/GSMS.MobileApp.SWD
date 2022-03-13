class Product {
  String? id;
  double? atomicPrice;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['atomicPrice'] = atomicPrice;
    data['masterProductId'] = masterProductId;
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    data['categoryId'] = categoryId;
    data['isDeleted'] = isDeleted;
    return data;
  }
}
