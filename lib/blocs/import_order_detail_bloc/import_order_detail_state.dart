part of 'import_order_detail_bloc.dart';

enum ImportOrderDetailStatus { initial, success, failure }

class ImportOrderDetailState extends Equatable {
  const ImportOrderDetailState({
    this.status = ImportOrderDetailStatus.initial,
    this.orderDetail = const <ImportOrderDetail>[],
    this.hasReachedMax = false,
  });

  final ImportOrderDetailStatus status;
  final List<ImportOrderDetail> orderDetail;
  final bool hasReachedMax;

  ImportOrderDetailState copyWith({
    ImportOrderDetailStatus? status,
    List<ImportOrderDetail>? orderDetail,
    bool? hasReachedMax,
  }) {
    return ImportOrderDetailState(
      status: status ?? this.status,
      orderDetail: orderDetail ?? this.orderDetail,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''ImportOrderDetailState { status: $status, hasReachedMax: $hasReachedMax, orders: ${orderDetail.length} }''';
  }

  @override
  List<Object> get props => [status, orderDetail, hasReachedMax];
}