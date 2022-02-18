import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final String id;
  final String name;
  final String productID;
  final String storeID;
  final String isDeleted;

  const Order(this.id, this.name, this.productID, this.storeID, this.isDeleted);

  Order.fromJson(Map<String, dynamic> json)
      : id = json["id"] ?? "",
        name = json["name"] ?? "",
        productID = json["productID"] ?? "",
        storeID = json["storeID"] ?? "",
        isDeleted = json["isDeleted"];

  @override
  List<Object> get props => [id, name, productID, storeID, isDeleted];

  static const empty = Order("", "", "", "", "");
}