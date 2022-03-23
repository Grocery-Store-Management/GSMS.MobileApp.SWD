class Product {
  String? id;
  double? atomicPrice;
  String? masterProductId;
  String? name;
  String? imageUrl;
  String? categoryId;
  bool? isDeleted;

  Product({
    this.id,
    this.atomicPrice,
    this.masterProductId,
    this.name,
    this.imageUrl,
    this.categoryId,
    this.isDeleted,
  });

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
    data['id'] = id as String;
    data['atomicPrice'] = atomicPrice as String;
    data['masterProductId'] = masterProductId as String;
    data['name'] = name as String;
    data['imageUrl'] = imageUrl as String;
    data['categoryId'] = categoryId as String;
    data['isDeleted'] = isDeleted as String;
    return data;
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, atomicPrice: $atomicPrice, masterProductId: $masterProductId, imageUrl: $imageUrl, categoryId: $categoryId, isDeleted: $isDeleted}';
  }
}
