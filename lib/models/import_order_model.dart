class ImportOrderModel {
  String? id;
  String? name;
  String? productId;
  String? storeId;
  bool? isDeleted;
  String? createdDate;
  String? store;
  String? error;
  List<ImportOrderDetails>? importOrderDetails;

  ImportOrderModel(
      {this.id,
      this.name,
      this.productId,
      this.storeId,
      this.isDeleted,
      this.createdDate,
      this.store,
      this.importOrderDetails});

  ImportOrderModel.withError(String errorMessage) {
    error = errorMessage;
  }

  ImportOrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    productId = json['productId'];
    storeId = json['storeId'];
    isDeleted = json['isDeleted'];
    createdDate = json['createdDate'];
    store = json['store'];
    if (json['importOrderDetails'] != null) {
      importOrderDetails = <ImportOrderDetails>[];
      json['importOrderDetails'].forEach((v) {
        importOrderDetails!.add(new ImportOrderDetails.fromJson(v));
      });
    }
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
    if (this.importOrderDetails != null) {
      data['importOrderDetails'] =
          this.importOrderDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImportOrderDetails {
  String? id;
  String? importOrderId;
  String? name;
  String? distributor;
  String? productId;
  int? quantity;
  bool? isDeleted;
  int? price;
  String? product;

  ImportOrderDetails(
      {this.id,
      this.importOrderId,
      this.name,
      this.distributor,
      this.productId,
      this.quantity,
      this.isDeleted,
      this.price,
      this.product});

  ImportOrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    importOrderId = json['importOrderId'];
    name = json['name'];
    distributor = json['distributor'];
    productId = json['productId'];
    quantity = json['quantity'];
    isDeleted = json['isDeleted'];
    price = json['price'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['importOrderId'] = this.importOrderId;
    data['name'] = this.name;
    data['distributor'] = this.distributor;
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    data['isDeleted'] = this.isDeleted;
    data['price'] = this.price;
    data['product'] = this.product;
    return data;
  }
}
