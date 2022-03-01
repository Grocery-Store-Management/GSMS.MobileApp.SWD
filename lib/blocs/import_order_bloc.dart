import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gsms_mobileapp_swd/models/import_order_model.dart';
import 'package:gsms_mobileapp_swd/services/api_repository.dart';

part 'import_order_event.dart';
part 'import_order_state.dart';

class ImportOrderBloc extends Bloc<ImportOrderEvent, ImportOrderState> {
  ImportOrderBloc() : super(ImportOrderInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetImportOrderList>((event, emit) async {
      try {
        emit(ImportOrderLoading());
        final mList = await _apiRepository.fetchCovidList();
        emit(ImportOrderLoaded(mList));
        if (mList.error != null) {
          emit(ImportOrderError(mList.error));
        }
      } on NetworkError {
        emit(ImportOrderError("Failed to fetch data. is your device online?"));
      }
    });
  }
}