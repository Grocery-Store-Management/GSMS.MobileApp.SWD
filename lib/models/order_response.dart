import 'order.dart';

class OrderResponse {
  final List<Order> order;
  final String errors;

  OrderResponse(this.order, this.errors);

  OrderResponse.fromJson(Map<String, dynamic> json)
      : order = (json["order"] as List).map((i) => Order.fromJson(i)).toList(),
        errors = "";

  OrderResponse.withError(String errorValue) : order = [], errors = errorValue;
}