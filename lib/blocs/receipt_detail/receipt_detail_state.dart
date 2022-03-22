part of 'receipt_detail_bloc.dart';

abstract class ReceiptDetailState extends Equatable {
  const ReceiptDetailState();

  @override
  List<Object?> get props => [];
}

class Initial extends ReceiptDetailState {}

class Loading extends ReceiptDetailState  {}

class ChartLoaded extends ReceiptDetailState  {
  final List<LineData> chartData;
  const ChartLoaded(this.chartData);
}

class DetailLoaded extends ReceiptDetailState  {
  final List<ReceiptDetail> details;
  final List<String> images;
  const DetailLoaded(this.details, this.images);
}

class Failure extends ReceiptDetailState {
  final String error;
  const Failure(this.error);
}
