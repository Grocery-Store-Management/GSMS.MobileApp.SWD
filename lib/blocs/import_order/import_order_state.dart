part of 'import_order_bloc.dart';

class ImportOrderState {
  final ImportOrder? order;
  final List<ImportOrder>? orders;
  const ImportOrderState({this.order, this.orders});

  factory ImportOrderState.initial() => const ImportOrderState();
}

class LoadingOrder extends ImportOrderState  {}

class Failure extends ImportOrderState {
  String error;
  Failure(this.error);
}

class LoadingDelete extends ImportOrderState  {}

class SuccessDelete extends ImportOrderState  {}