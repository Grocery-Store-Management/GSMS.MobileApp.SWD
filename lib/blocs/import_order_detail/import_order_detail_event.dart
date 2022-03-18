part of 'import_order_detail_bloc.dart';

abstract class ImportOrderDetailEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class ImportOrderDetailFetched extends ImportOrderDetailEvent {
  final String? orderId;
  ImportOrderDetailFetched(this.orderId);
}