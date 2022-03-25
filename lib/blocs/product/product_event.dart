part of 'product_bloc.dart';

abstract class ProductEvent {}

class GetAllEvent extends ProductEvent{
  int page;
  int pageSize;
  int sort;
  GetAllEvent({required this.page, required this.pageSize, required this.sort});
}

class GetIdEvent extends ProductEvent{
  String id;
  GetIdEvent({required this.id});
}

class DeleteEvent extends ProductEvent{
  String id;
  DeleteEvent({required this.id});
}