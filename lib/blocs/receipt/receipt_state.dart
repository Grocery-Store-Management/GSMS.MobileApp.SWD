part of 'receipt_bloc.dart';

abstract class ReceiptState extends Equatable {
  const ReceiptState();

  @override
  List<Object?> get props => [];
}

class Initial extends ReceiptState {}

class Loading extends ReceiptState  {}

class Loaded extends ReceiptState  {
  final List<Receipt> receipts;
  const Loaded(this.receipts);
}

class Failure extends ReceiptState {
  final String error;
  const Failure(this.error);
}