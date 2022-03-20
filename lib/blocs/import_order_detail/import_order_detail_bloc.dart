import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';
import 'package:gsms_mobileapp_swd/models/import_order_detail.dart';

part 'import_order_detail_event.dart';
part 'import_order_detail_state.dart';

class ImportOrderDetailBloc extends Bloc<ImportOrderDetailEvent, ImportOrderDetailState> {
  ImportOrderDetailBloc({required this.apiProvider}) : super(OrderDetailInitial()) {
    on<GetIdEvent>(
      _fetchOrderDetail,
    );
  }

  final ApiProvider apiProvider;

  Future<void> _fetchOrderDetail(GetIdEvent event, Emitter<ImportOrderDetailState> emit) async {
    try {
      emit(OrderDetailInitial());
      final data = await apiProvider.fetchOrderDetails(event.orderId);
      emit(OrderDetailLoaded(data));
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }
}

class NetworkError extends Error {}