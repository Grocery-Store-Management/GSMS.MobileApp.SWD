import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gsms_mobileapp_swd/models/receipt.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';

part 'receipt_event.dart';
part 'receipt_state.dart';

class ReceiptBloc extends Bloc<ReceiptEvent, ReceiptState> {
  ReceiptBloc({required this.apiProvider}) : super(Initial()) {
    on<GetAllEvent>(
      _fetchReceipts,
    );
  }

  final ApiProvider apiProvider;

  Future<void> _fetchReceipts(GetAllEvent event, Emitter<ReceiptState> emit) async {
    try {
      emit(Initial());
      final data = await apiProvider.fetchReceipts();
      emit(Loaded(data));
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }
}