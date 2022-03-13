import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gsms_mobileapp_swd/models/product.dart';
import 'package:gsms_mobileapp_swd/models/import_order.dart';

import '../models/import_order_detail.dart';

class ApiProvider {
  final dio = Dio();
  final String baseUrl = 'https://gsms-api.azurewebsites.net/api/v1.0';

  var token =
      'eyJhbGciOiJSUzI1NiIsImtpZCI6IjJkYzBlNmRmOTgyN2EwMjA2MWU4MmY0NWI0ODQwMGQwZDViMjgyYzAiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiTmd1eWVuIEh1eW5oIE5oYXQgTWluaCIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS0vQU9oMTRHaXI3bzV6RW1lNVNBOHJFM3dndzlhcC14Wk1HYzBoSDI4enhMOHVmdz1zOTYtYyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nc21zLTQxZjlhIiwiYXVkIjoiZ3Ntcy00MWY5YSIsImF1dGhfdGltZSI6MTY0NzE0MTE5MiwidXNlcl9pZCI6ImEwWndnd1pNc29oTktTQTBqcUIyNXNhUTVQZjEiLCJzdWIiOiJhMFp3Z3daTXNvaE5LU0EwanFCMjVzYVE1UGYxIiwiaWF0IjoxNjQ3MTQxMTkyLCJleHAiOjE2NDcxNDQ3OTIsImVtYWlsIjoibWluaG5obnNlMTMwNTE3QGZwdC5lZHUudm4iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjExNjIzNjE5MjUzNzAzMzcwMTU2NyJdLCJlbWFpbCI6WyJtaW5obmhuc2UxMzA1MTdAZnB0LmVkdS52biJdfSwic2lnbl9pbl9wcm92aWRlciI6Imdvb2dsZS5jb20ifX0.ik5AGbSwQZzDpZJz2Irv1IHOYEqTvPIHzchiXKBOmQKOqMtowbngtjFbPMXaRjNpxA1b27DBDCpefq2zZqMrfoGpIaKo5P6mcYNyl7dtlTYaa03qQk99nksi9FK_l0kfZyMLcWzVQJITzVbzXR6CW2ldUKrAeRZx9z44k3YDVIFgrsQFi5dQx1dnxMBBu4sqOcA4ZYS8Ee_VcGZ3MqEuTDNzq_sf1b_SH3N2r5LsZBlKgaxr-leXj54TIBmZyebnhULUL65hsXQLA9WDxAv0wqUR-o8nZbSKqZ4CsxUFFj45nVCyZ_HtrmiodzU1QfiVWx_O3R0XAP4lsXEf9lfauA';

  /* ImportOrder API */
  Future<List<ImportOrder>> fetchOrders() async {
    List<ImportOrder> list = [];
    dio.options.headers= {"Authorization" : 'Bearer $token'};
    try {
      var response = await dio.get(baseUrl + '/import-orders?page=1&page-size=10', options: Options(responseType: ResponseType.plain));
      var body = (json.decode(response.data) as List)
          .map((e) => ImportOrder.fromJson(e))
          .toList();
      list = body;
    } catch (error, stacktrace) {
      if (error is DioError) {
        print('Dio error!');
        print('STATUS: ${error.response?.statusCode}');
        print('DATA: ${error.response?.data}');
        print('HEADERS: ${error.response?.headers}');
      } else {
        print('Error sending request!');
        print("Exception occured: $error stackTrace: $stacktrace");
      }
    }
    return list;
  }

  /* ImportOrderDetail API */
  Future<List<ImportOrderDetail>> fetchOrderDetails([orderID]) async {
    List<ImportOrderDetail> list = [];
    dio.options.headers= {"Authorization" : 'Bearer $token'};
    try {
      var response = await dio.get(baseUrl + '/import-order-details?importOrderId=$orderID', options: Options(responseType: ResponseType.plain));
      var body = (json.decode(response.data) as List)
          .map((e) => ImportOrderDetail.fromJson(e))
          .toList();
      list = body;
    } catch (error, stacktrace) {
      if (error is DioError) {
        print('Dio error!');
        print('STATUS: ${error.response?.statusCode}');
        print('DATA: ${error.response?.data}');
        print('HEADERS: ${error.response?.headers}');
      } else {
        print('Error sending request!');
        print("Exception occured: $error stackTrace: $stacktrace");
      }
    }
    return list;
  }

  /* Product API */
  Future<List<Product>> fetchProducts() async {
    List<Product> list = [];
    dio.options.headers= {"Authorization" : 'Bearer $token'};
    try {
      var response = await dio.get(baseUrl + '/products?page=1&page-size=10', options: Options(responseType: ResponseType.plain));
      var body = (json.decode(response.data) as List)
          .map((e) => Product.fromJson(e))
          .toList();
      list = body;
    } catch (error, stacktrace) {
      if (error is DioError) {
        print('Dio error!');
        print('STATUS: ${error.response?.statusCode}');
        print('DATA: ${error.response?.data}');
        print('HEADERS: ${error.response?.headers}');
      } else {
        print('Error sending request!');
        print("Exception occured: $error stackTrace: $stacktrace");
      }
    }
    return list;
  }
}

// , options: Options(responseType: ResponseType.plain)
