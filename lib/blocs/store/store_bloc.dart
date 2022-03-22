import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gsms_mobileapp_swd/models/store.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc({required this.apiProvider}) : super(Initial()) {
    on<GetAllEvent>(
      _fetchStores,
    );
  }

  final ApiProvider apiProvider;

  Future<void> _fetchStores(GetAllEvent event, Emitter<StoreState> emit) async {
    try {
      emit(Initial());
      final data = await apiProvider.fetchStores();
      List<String> brandName = [];
      for (var store in data) {
        final brand = await apiProvider.fetchBrandId(store.brandId!);
        brandName.add(brand.name!);
      }
      emit(Loaded(data, brandName));
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }
}