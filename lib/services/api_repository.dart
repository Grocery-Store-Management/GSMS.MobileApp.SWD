import 'package:gsms_mobileapp_swd/models/import_order_model.dart';
import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<ImportOrderModel> fetchCovidList() {
    return _provider.fetchImportOrderList();
  }
}

class NetworkError extends Error {}