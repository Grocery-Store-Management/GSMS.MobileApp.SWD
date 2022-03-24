import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gsms_mobileapp_swd/models/brand.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';

part 'brand_state.dart';
part 'brand_event.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  BrandBloc({required this.apiProvider}) : super(Initial()) {
    on<GetAllEvent>(
      _fetchBrands,
    );
    on<CreateEvent>(
      _createBrand,
    );
    on<UpdateEvent>(
      _updateBrand,
    );
    on<DeleteEvent>(
      _deleteBrand,
    );
    on<SortByDateEvent>(
      _sortByDate,
    );
  }

  final ApiProvider apiProvider;

  Future<void> _fetchBrands(GetAllEvent event, Emitter<BrandState> emit) async {
    try {
      emit(Initial());
      final data = await apiProvider.fetchBrands(event.page);
      emit(Loaded(data));
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }

  Future<void> _createBrand(CreateEvent event, Emitter<BrandState> emit) async {
    try {
      emit(Loading());
      final Brand brand = Brand(
        id: null,
        name: event.brandName,
        createdDate: null,
        isDeleted: false,
      );
      await apiProvider.createBrand(brand);
      emit(CreateSuccess());
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }

  Future<void> _updateBrand(UpdateEvent event, Emitter<BrandState> emit) async {
    try {
      emit(Loading());
      final Brand brand = Brand(
        id: event.brand.id,
        name: event.brand.name,
        createdDate: event.brand.createdDate,
        isDeleted: event.brand.isDeleted,
      );
      await apiProvider.updateBrand(brand);
      emit(UpdateSuccess());
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }

  Future<void> _deleteBrand(DeleteEvent event, Emitter<BrandState> emit) async {
    try {
      emit(Loading());
      await apiProvider.deleteBrand(event.getId);
      emit(DeleteSuccess());
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }

  Future<void> _sortByDate(SortByDateEvent event, Emitter<BrandState> emit) async {
    try {
      emit(Loading());
      final data = await apiProvider.fetchBrandsByDate(event.sort);
      emit(SortLoaded(data));
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }
}