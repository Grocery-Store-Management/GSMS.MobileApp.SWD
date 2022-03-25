import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';

import '../../models/product.dart';

part 'product_state.dart';
part 'product_event.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({required this.apiProvider}) : super(Initial()) {
    on<GetAllEvent>(_fetchProducts);
    on<GetIdEvent>(_fetchProductId);
    on<DeleteEvent>(_deleteProduct);
  }

  final ApiProvider apiProvider;

  Future<void> _fetchProducts(GetAllEvent event, Emitter<ProductState> emit) async {
    try {
      emit(Initial());
      final data = await apiProvider.fetchProducts(event.page, event.pageSize, event.sort);
      List<String> cateNameList = [];
      List<Details> productDetailList = [];
      for (var product in data) {
        String? id = product.categoryId;
        final category = await apiProvider.fetchCategoryId(id!);
        cateNameList.add(category.name!);
        final productDetail = await apiProvider.fetchProductDetail(product.id!);
        productDetailList.add(
            Details(productDetail[0].price, productDetail[0].storedQuantity));
      }
      emit(ProductsFetched(data, cateNameList, productDetailList));
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }

  Future<void> _fetchProductId(
      GetIdEvent event, Emitter<ProductState> emit) async {
    try {
      emit(Initial());
      final data = await apiProvider.fetchProductId(event.id);
      emit(ProductIdFetched(data));
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }

  Future<void> _deleteProduct(DeleteEvent event, Emitter<ProductState> emit) async {
    try {
      emit(Loading());
      await apiProvider.deleteProduct(event.id);
      emit(DeleteSuccess());
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }
}

class Details {
  final double? price;
  final int? quantity;
  Details(this.price, this.quantity);
}
