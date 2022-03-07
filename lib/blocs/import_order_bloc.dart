import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:gsms_mobileapp_swd/models/import_order.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';
import 'package:stream_transform/stream_transform.dart';

part 'import_order_event.dart';
part 'import_order_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ImportOrderBloc extends Bloc<ImportOrderEvent, ImportOrderState> {
  ImportOrderBloc({required this.apiProvider}) : super(const ImportOrderState()) {
    on<ImportOrderFetched>(
      _onOrderFetched,
      transformer: throttleDroppable(throttleDuration),);
  }

  final ApiProvider apiProvider;

  Future<void> _onOrderFetched(ImportOrderFetched event, Emitter<ImportOrderState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ImportOrderStatus.initial) {
        final orders = await apiProvider.fetchOrders();
        return emit(state.copyWith(
          status: ImportOrderStatus.success,
          orders: orders,
          hasReachedMax: false,
        ));
      }
      final orders = await apiProvider.fetchOrders();
      emit(orders.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
        status: ImportOrderStatus.success,
        orders: List.of(state.orders)
          ..addAll(orders),
        hasReachedMax: false,
      ));
    } catch (_) {
      emit(state.copyWith(status: ImportOrderStatus.failure));
    }
  }
}
