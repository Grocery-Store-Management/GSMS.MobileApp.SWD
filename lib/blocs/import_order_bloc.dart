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
  ImportOrderBloc({required this.apiProvider}) : super(ImportOrderInitial()) {
    on<ImportOrderFetched>(
      _onOrderFetched,
      transformer: throttleDroppable(throttleDuration),);
  }

  final ApiProvider apiProvider;

  Future<void> _onOrderFetched(ImportOrderFetched event, Emitter<ImportOrderState> emit) async {
    try {
      emit(ImportOrderLoading());
      final mList = await apiProvider.fetchOrders();
      emit(ImportOrderLoaded(mList));
      if (mList.error != null) {
        emit(ImportOrderError(mList.error));
      }
    } on NetworkError {
      emit(ImportOrderError("Failed to fetch data. is your device online?"));
    };
  }
}

class NetworkError extends Error {}