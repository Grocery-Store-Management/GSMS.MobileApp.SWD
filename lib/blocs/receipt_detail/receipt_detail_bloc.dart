import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gsms_mobileapp_swd/models/receipt_detail.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';

part 'receipt_detail_event.dart';
part 'receipt_detail_state.dart';

class ReceiptDetailBloc extends Bloc<ReceiptDetailEvent, ReceiptDetailState> {
  ReceiptDetailBloc({required this.apiProvider}) : super(Initial()) {
    on<GetAllEvent>(
      _fetchReceiptDetails,
    );
    on<GetIdEvent>(
      _fetchReceiptDetailId
    );
  }

  final ApiProvider apiProvider;

  Future<void> _fetchReceiptDetails(GetAllEvent event, Emitter<ReceiptDetailState> emit) async {
    List<LineData> chartData = [];
    Map map = {};
    try {
      emit(Initial());
      final data = await apiProvider.fetchReceiptDetails();

      for (var element in data) {
        String? key = element.name;
        if (map.containsKey(key)) {
          map[key] += element.quantity;
        } else {
          map[key] = element.quantity;
        }
      }

      chartData = map.entries.map((e) => LineData(e.key, e.value)).toList();
      emit(ChartLoaded(chartData));
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }

  Future<void> _fetchReceiptDetailId(GetIdEvent event, Emitter<ReceiptDetailState> emit) async {
    try {
      emit(Initial());
      final data = await apiProvider.fetchReceiptDetailId(event.getId!);
      final List<String> productImages = [];
      for (var item in data) {
        final product = await apiProvider.fetchProductId(item.productId!);
        productImages.add(product.imageUrl!);
      }
      emit(DetailLoaded(data, productImages));
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }
}

class LineData {
  final String? xData;
  final num? yData;
  LineData(this.xData, this.yData);
}