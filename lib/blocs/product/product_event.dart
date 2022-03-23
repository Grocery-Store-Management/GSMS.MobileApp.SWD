part of 'product_bloc.dart';

abstract class ProductEvent {}

class GetAllEvent extends ProductEvent{}

class GetIdEvent extends ProductEvent{
  String id;
  GetIdEvent({required this.id});
}

class DeleteEvent extends ProductEvent{
  int id;
  DeleteEvent({required this.id});
}