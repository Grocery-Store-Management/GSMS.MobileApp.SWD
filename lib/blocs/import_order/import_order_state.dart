part of 'import_order_bloc.dart';

abstract class ImportOrderState extends Equatable {
  const ImportOrderState();

  @override
  List<Object?> get props => [];
}

class OrderInitial extends ImportOrderState {}

class OrderLoading extends ImportOrderState  {}

class OrderLoaded extends ImportOrderState  {
  final List<ImportOrder> orders;
  const OrderLoaded(this.orders);
}

class Failure extends ImportOrderState {
  final String error;
  const Failure(this.error);
}

class DeleteLoading extends ImportOrderState  {}

class DeleteSuccess extends ImportOrderState  {}

class OrderError extends ImportOrderState {
  final String? message;
  const OrderError(this.message);
}