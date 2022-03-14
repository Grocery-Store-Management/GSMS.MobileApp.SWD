part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductFetched extends ProductEvent {}

class ProductCreated extends ProductEvent {
  final double? atomicPrice;
  final String? name;
  final String? imageUrl;
  final String? categoryId;
  ProductCreated(this.atomicPrice, this.name, this.imageUrl, this.categoryId);
}