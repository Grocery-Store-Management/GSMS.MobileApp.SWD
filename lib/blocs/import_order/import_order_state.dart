part of 'import_order_bloc.dart';

enum ImportOrderStatus { initial, success, failure }

class ImportOrderState extends Equatable {
  const ImportOrderState({
    this.status = ImportOrderStatus.initial,
    this.orders = const <ImportOrder>[],
    this.hasReachedMax = false,
  });

  final ImportOrderStatus status;
  final List<ImportOrder> orders;
  final bool hasReachedMax;

  ImportOrderState copyWith({
    ImportOrderStatus? status,
    List<ImportOrder>? orders,
    bool? hasReachedMax,
  }) {
    return ImportOrderState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''ImportOrderState { status: $status, hasReachedMax: $hasReachedMax, orders: ${orders.length} }''';
  }

  @override
  List<Object> get props => [status, orders, hasReachedMax];
}