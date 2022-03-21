part of 'receipt_detail_bloc.dart';

abstract class ReceiptDetailState extends Equatable {
  const ReceiptDetailState();

  @override
  List<Object?> get props => [];
}

class Initial extends ReceiptDetailState {}

class Loading extends ReceiptDetailState  {}

class Loaded extends ReceiptDetailState  {
  final List<LineData> chartData;
  const Loaded(this.chartData);
}

class Failure extends ReceiptDetailState {
  final String error;
  const Failure(this.error);
}
