part of 'import_order_detail_bloc.dart';

abstract class ImportOrderDetailState extends Equatable {
  const ImportOrderDetailState();

  @override
  List<Object?> get props => [];
}

class OrderDetailInitial extends ImportOrderDetailState {}

class OrderDetailLoaded extends ImportOrderDetailState  {
  final List<ImportOrderDetail> details;
  const OrderDetailLoaded(this.details);
}

class Failure extends ImportOrderDetailState {
  final String? error;
  const Failure(this.error);
}
