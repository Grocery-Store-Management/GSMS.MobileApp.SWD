import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gsms_mobileapp_swd/models/import_order.dart';
import 'package:gsms_mobileapp_swd/services/api_repository.dart';

part 'import_order_event.dart';
part 'import_order_state.dart';

class ImportOrderBloc extends Bloc<ImportOrderEvent, ImportOrderState> {

  ImportOrderBloc() : super(ImportOrderInitial()) {
    on<GetImportOrderList>(
        _onGetImportOrder,
    );
  }

  final ApiRepository _apiRepository = ApiRepository();

  Future<void> _onGetImportOrder(GetImportOrderList event, Emitter<ImportOrderState> emit) async {
    try {
      emit(ImportOrderLoading());
      final mList = await _apiRepository.fetchImportOrderList(startDate: '2022-03-01');
      emit(ImportOrderLoaded(mList!));
      if (mList.error != null) {
        emit(ImportOrderError(mList.error));
      }
    } on NetworkError {
      emit(ImportOrderError("Failed to fetch data. is your device online?"));
    }
  }
}
