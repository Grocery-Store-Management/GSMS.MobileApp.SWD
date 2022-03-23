part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class Initial extends ProductState {}

class ProductsFetched extends ProductState  {
  final List<Product> products;
  final List<String> cateNameList;
  final List<Details> productDetailList;
  const ProductsFetched(this.products, this.cateNameList, this.productDetailList);
}

class ProductIdFetched extends ProductState  {
  final Product product;
  const ProductIdFetched(this.product);
}

class Failure extends ProductState {
  final String? error;
  const Failure(this.error);
}