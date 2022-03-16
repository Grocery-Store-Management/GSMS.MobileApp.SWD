part of 'product_bloc.dart';

class ProductState{
  final Product? product;
  final List<Product>? products;
  const ProductState({this.product, this.products});

  factory ProductState.initial() => const ProductState();
}

class LoadingProduct extends ProductState  {}

class SuccessCreate extends ProductState  {}

class Failure extends ProductState {
  String error;
  Failure(this.error);
}

class LoadingDelete extends ProductState  {}

class SuccessDelete extends ProductState  {}