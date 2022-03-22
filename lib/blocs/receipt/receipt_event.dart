part of 'receipt_bloc.dart';

abstract class ReceiptEvent extends Equatable  {

  @override
  List<Object> get props => [];
}

class GetAllEvent extends ReceiptEvent {}

class GetIdEvent extends ReceiptEvent{
  final String getId;
  GetIdEvent({required this.getId});
}