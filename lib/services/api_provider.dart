import 'package:dio/dio.dart';
import 'package:gsms_mobileapp_swd/models/import_order.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = 'https://gsms-api.azurewebsites.net/api/v1.0';

  /* ImportOrder API */
  Future<ImportOrder?> fetchImportOrderList({
    required String startDate,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    ImportOrder? order;

    _dio.options.headers = {
      'lang': lang,
      'Authorization':
          'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6ImNmNWQ4ZTc0ZjNjNDg2ZWU1MDNkNWVlYzkzYTEwMWM2NGJhY2Y3ZGEiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiTmd1eWVuIEh1eW5oIE5oYXQgTWluaCIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS0vQU9oMTRHaXI3bzV6RW1lNVNBOHJFM3dndzlhcC14Wk1HYzBoSDI4enhMOHVmdz1zOTYtYyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nc21zLTQxZjlhIiwiYXVkIjoiZ3Ntcy00MWY5YSIsImF1dGhfdGltZSI6MTY0NjIwMzI5MCwidXNlcl9pZCI6ImEwWndnd1pNc29oTktTQTBqcUIyNXNhUTVQZjEiLCJzdWIiOiJhMFp3Z3daTXNvaE5LU0EwanFCMjVzYVE1UGYxIiwiaWF0IjoxNjQ2MjAzMjkwLCJleHAiOjE2NDYyMDY4OTAsImVtYWlsIjoibWluaG5obnNlMTMwNTE3QGZwdC5lZHUudm4iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjExNjIzNjE5MjUzNzAzMzcwMTU2NyJdLCJlbWFpbCI6WyJtaW5obmhuc2UxMzA1MTdAZnB0LmVkdS52biJdfSwic2lnbl9pbl9wcm92aWRlciI6Imdvb2dsZS5jb20ifX0.lMlW9ABVpzcLYLN606x7QQjmCBHLGDb0mQdoXuI5zxspYssvCDOhnohRzwd499f7ZWQqd8jVkxHeHm9BcrfHBIi_za65-myeWfYd3y1h5ZYPinr5qjOQ4z8DW3J2cnfLJ-wUkVEHsC6vYCWbSB8i2fMBTjb0DuyMrioLG-kfEGGOVZHtYkaZoFqVdptCr7wh4seC_zFvKP4y8eHZCbu3GyH78GvqCF_o8g5pGCWmf5VLBiG1YX0nghyEOJb-TV1c1sVAi1O0lSY4u9ZH8uWkGpJ6CWwUZxFyG3J5nvfbXVWFFDQ5ZtrOSmWtd0NtxmAa3UJCqRJy5ObZJ18GR-wqEg',
      'Content-Type': 'application/json',
    };

    try {
      Response response = await _dio.get(
          _url + '/import-orders?start-date=$startDate&page=1&page-size=10');

      print('Order info: ${response.data}');

      order = ImportOrder.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ImportOrder.withError("Data not found / Connection issue");
    }
    return order;
  }
}
