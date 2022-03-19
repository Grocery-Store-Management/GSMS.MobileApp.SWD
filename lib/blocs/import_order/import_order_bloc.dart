import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gsms_mobileapp_swd/models/import_order.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';

part 'import_order_event.dart';
part 'import_order_state.dart';

class ImportOrderBloc extends Bloc<ImportOrderEvent, ImportOrderState> {
  ImportOrderBloc({required this.apiProvider}) : super(OrderInitial()) {
    on<GetAllEvent>(
        _fetchOrder,
    );
    on<DeleteEvent>(
      _deleteOrder,
    );
  }

  final ApiProvider apiProvider;

  Future<void> _fetchOrder(GetAllEvent event, Emitter<ImportOrderState> emit) async {
    try {
      emit(OrderInitial());
      final data = await apiProvider.fetchOrders();
      emit(OrderLoaded(data));
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }

  Future<void> _deleteOrder(DeleteEvent event, Emitter<ImportOrderState> emit) async {
    try {
      emit(DeleteLoading());
      await apiProvider.deleteOrder(event.deleteId!);
      emit(DeleteSuccess());
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }
}

class NetworkError extends Error {}