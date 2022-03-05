import 'package:gsms_mobileapp_swd/models/import_order.dart';
import 'api_provider.dart';

class ApiRepository {
  final _apiProvider = ApiProvider();

  Future<ImportOrder?> fetchImportOrderList({required String startDate}) async {
    return _apiProvider.fetchImportOrderList(startDate: '2022-03-01');
  }
}

class NetworkError extends Error {}
