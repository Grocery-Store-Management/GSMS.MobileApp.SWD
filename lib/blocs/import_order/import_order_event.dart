part of 'import_order_bloc.dart';

abstract class ImportOrderEvent extends Equatable  {

  @override
  List<Object> get props => [];
}

class GetAllEvent extends ImportOrderEvent {}

class GetIdEvent extends ImportOrderEvent{
  final String getId;
  GetIdEvent({required this.getId});
}

class DeleteEvent extends ImportOrderEvent {
  final String? deleteId;
  DeleteEvent({required this.deleteId});
}