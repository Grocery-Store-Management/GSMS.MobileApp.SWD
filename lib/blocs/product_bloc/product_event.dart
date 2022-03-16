part of 'product_bloc.dart';

abstract class ProductEvent {}

class GetAllEvent extends ProductEvent{}

class GetIdEvent extends ProductEvent{
  int id;
  GetIdEvent({required this.id});
}

class CreateEvent extends ProductEvent{
  double? atomicPrice;
  String? masterProductId;
  String? name;
  String? imageUrl;
  String? categoryId;
  bool? isDeleted;
  CreateEvent({required this.atomicPrice, this.masterProductId, this.name, this.isDeleted, this.categoryId, this.imageUrl});
}

class DeleteEvent extends ProductEvent{
  int id;
  DeleteEvent({required this.id});
}