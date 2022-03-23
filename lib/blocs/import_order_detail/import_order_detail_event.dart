part of 'import_order_detail_bloc.dart';

abstract class ImportOrderDetailEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class GetIdEvent extends ImportOrderDetailEvent{
  final String orderId;
  GetIdEvent({required this.orderId});
}

class DeleteEvent extends ImportOrderDetailEvent {
  final String? deleteId;
  DeleteEvent({required this.deleteId});
}