part of 'import_order_bloc.dart';

abstract class ImportOrderEvent {}

class GetAllEvent extends ImportOrderEvent {}

class GetIdEvent extends ImportOrderEvent{
  String getId;
  GetIdEvent({required this.getId});
}

class DeleteEvent extends ImportOrderEvent {
  String? deleteId;
  DeleteEvent({required this.deleteId});
}