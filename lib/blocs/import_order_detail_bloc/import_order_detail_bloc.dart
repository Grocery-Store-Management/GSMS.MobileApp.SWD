import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';
import 'package:gsms_mobileapp_swd/models/import_order_detail.dart';

part 'import_order_detail_event.dart';
part 'import_order_detail_state.dart';

class ImportOrderDetailBloc extends Bloc<ImportOrderDetailEvent, ImportOrderDetailState> {
  ImportOrderDetailBloc({required this.apiProvider}) : super(const ImportOrderDetailState()) {
    on<ImportOrderDetailFetched>(
      _fetchOrder,
    );
  }

  final ApiProvider apiProvider;

  Future<void> _fetchOrder(ImportOrderDetailFetched event, Emitter<ImportOrderDetailState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ImportOrderDetailStatus.initial) {
        final List<ImportOrderDetail> response = await apiProvider.fetchOrderDetails();
        return emit(state.copyWith(
          status: ImportOrderDetailStatus.success,
          orderDetail: response,
          hasReachedMax: response.length <= 10 ? true : false,
        ));
      }
      final List<ImportOrderDetail> response = await apiProvider.fetchOrderDetails();
      response.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
        state.copyWith(
          status: ImportOrderDetailStatus.success,
          orderDetail: List.of(state.orderDetail)..addAll(response),
          hasReachedMax: response.length <= 10 ? true : false,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: ImportOrderDetailStatus.failure));
    }
  }
}

class NetworkError extends Error {}