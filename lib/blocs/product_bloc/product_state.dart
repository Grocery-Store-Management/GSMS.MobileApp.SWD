part of 'product_bloc.dart';

enum ProductStatus { initial, success, failure }

class ProductState extends Equatable {
  const ProductState({
    this.status = ProductStatus.initial,
    this.products = const <Product>[],
    this.hasReachedMax = false,
  });

  final ProductStatus status;
  final List<Product> products;
  final bool hasReachedMax;

  ProductState copyWith({
    ProductStatus? status,
    List<Product>? products,
    bool? hasReachedMax,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''ProductState { status: $status, hasReachedMax: $hasReachedMax, products: ${products.length} }''';
  }

  @override
  List<Object> get props => [status, products, hasReachedMax];
}