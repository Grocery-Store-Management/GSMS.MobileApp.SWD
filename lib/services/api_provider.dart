import 'package:dio/dio.dart';
import 'package:gsms_mobileapp_swd/models/import_order_model.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = 'https://api.covid19api.com/summary';

  Future<ImportOrderModel> fetchImportOrderList() async {
    try {
      Response response = await _dio.get(_url);
      return ImportOrderModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ImportOrderModel.withError("Data not found / Connection issue");
    }
  }
}
