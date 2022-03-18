import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gsms_mobileapp_swd/models/import_order.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';

part 'import_order_event.dart';
part 'import_order_state.dart';

class ImportOrderBloc extends Bloc<ImportOrderEvent, ImportOrderState> {
  ImportOrderBloc({required this.apiProvider}) : super(const ImportOrderState()) {
    on<ImportOrderFetched>(
        _fetchOrder,
    );
  }

  final ApiProvider apiProvider;

  Future<void> _fetchOrder(ImportOrderFetched event, Emitter<ImportOrderState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ImportOrderStatus.initial) {
        final List<ImportOrder> response = await apiProvider.fetchOrders();
        return emit(state.copyWith(
          status: ImportOrderStatus.success,
          orders: response,
          hasReachedMax: response.length <= 10 ? true : false,
        ));
      }
      final List<ImportOrder> response = await apiProvider.fetchOrders();
      response.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
        state.copyWith(
          status: ImportOrderStatus.success,
          orders: List.of(state.orders)..addAll(response),
          hasReachedMax: response.length <= 10 ? true : false,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: ImportOrderStatus.failure));
    }
  }
}

class NetworkError extends Error {}