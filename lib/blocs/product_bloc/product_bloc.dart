import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/product.dart';
import '../../services/api_provider.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({required this.apiProvider}) : super(const ProductState()) {
    on<ProductFetched>(
      _fetchProduct,
    );
  }

  final ApiProvider apiProvider;

  Future<void> _fetchProduct(ProductFetched event, Emitter<ProductState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ProductStatus.initial) {
        final List<Product> response = await apiProvider.fetchProducts();
        return emit(state.copyWith(
          status: ProductStatus.success,
          products: response,
          hasReachedMax: response.length <= 10 ? true : false,
        ));
      }
      final List<Product> response = await apiProvider.fetchProducts();
      response.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
        state.copyWith(
          status: ProductStatus.success,
          products: List.of(state.products)..addAll(response),
          hasReachedMax: response.length <= 10 ? true : false,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: ProductStatus.failure));
    }
  }
}

class NetworkError extends Error {}