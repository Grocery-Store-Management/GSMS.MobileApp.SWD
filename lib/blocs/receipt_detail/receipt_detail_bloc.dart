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
  }

  final ApiProvider apiProvider;

  Future<void> _fetchReceiptDetails(GetAllEvent event, Emitter<ReceiptDetailState> emit) async {
    List<LineData> chartData = [];
    Map map = {};
    try {
      emit(Initial());

      final data = await apiProvider.fetchReceiptDetails();

      // final List<ReceiptDetail> data = [
      //   ReceiptDetail(name: 'AppleOrangeBanana', quantity: 5),
      //   ReceiptDetail(name: 'AppleBananaOrange', quantity: 50),
      //   ReceiptDetail(name: 'OrangeBananaApple', quantity: 23),
      //   ReceiptDetail(name: 'OrangeAppleBanana', quantity: 4),
      //   ReceiptDetail(name: 'BananaOrangeApple', quantity: 7),
      //   ReceiptDetail(name: 'BananaAppleOrange', quantity: 13),
      // ];

      for (var element in data) {
        String? key = element.name;
        if (map.containsKey(key)) {
          map[key] += element.quantity;
        } else {
          map[key] = element.quantity;
        }
      }

      chartData = map.entries.map((e) => LineData(e.key, e.value)).toList();
      emit(Loaded(chartData));
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