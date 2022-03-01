part of 'import_order_bloc.dart';

abstract class ImportOrderState extends Equatable {
  const ImportOrderState();

  @override
  List<Object?> get props => [];
}

class ImportOrderInitial extends ImportOrderState {}

class ImportOrderLoading extends ImportOrderState {}

class ImportOrderLoaded extends ImportOrderState {
  final ImportOrderModel importOrderModel;
  const ImportOrderLoaded(this.importOrderModel);
}

class ImportOrderError extends ImportOrderState {
  final String? message;
  const ImportOrderError(this.message);
}