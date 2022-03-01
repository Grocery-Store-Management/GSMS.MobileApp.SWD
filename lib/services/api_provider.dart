import 'package:dio/dio.dart';
import 'package:gsms_mobileapp_swd/models/import_order_model.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = 'https://gsms-api.azurewebsites.net/api/v1';

  /* ImportOrder API */
  Future<ImportOrderModel> fetchImportOrderList() async {
    try {
      Response response = await _dio.get(_url + '/import-orders?startDate=2022-02-01&endDate=2022-03-01&page=1&pageSize=10');
      return ImportOrderModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ImportOrderModel.withError("Data not found / Connection issue");
    }
  }
}
