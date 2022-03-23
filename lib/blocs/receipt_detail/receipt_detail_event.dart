part of 'receipt_detail_bloc.dart';

abstract class ReceiptDetailEvent extends Equatable  {

  @override
  List<Object> get props => [];
}

class GetAllEvent extends ReceiptDetailEvent {}

class GetIdEvent extends ReceiptDetailEvent{
  final String? getId;
  GetIdEvent({required this.getId});
}
