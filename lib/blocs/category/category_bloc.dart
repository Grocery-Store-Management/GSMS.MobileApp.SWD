import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gsms_mobileapp_swd/models/category.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({required this.apiProvider}) : super(Initial()) {
    on<GetAllEvent>(
      _fetchCategories,
    );
  }

  final ApiProvider apiProvider;

  Future<void> _fetchCategories(GetAllEvent event, Emitter<CategoryState> emit) async {
    try {
      emit(Initial());
      final data = await apiProvider.fetchCategories();
      emit(Loaded(data));
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }
}