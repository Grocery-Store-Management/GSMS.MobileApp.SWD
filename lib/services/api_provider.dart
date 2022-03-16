import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gsms_mobileapp_swd/models/product.dart';
import 'package:gsms_mobileapp_swd/models/import_order.dart';
import 'package:gsms_mobileapp_swd/models/import_order_detail.dart';

class APIService<T> {
  final Uri? url;
  final dynamic body;
  T Function(Dio response)? parse;
  APIService({this.url, this.body, this.parse});
}

class ApiProvider {
  final dio = Dio();
  final String baseUrl = 'https://gsms-api.azurewebsites.net/api/v1.0';

  var token =
      'eyJhbGciOiJSUzI1NiIsImtpZCI6ImYxZDU2YTI1MWU0ZGRhM2Y0NWM0MWZkNWQ0ZGEwMWQyYjlkNzJlMGQiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiTmd1eWVuIEh1eW5oIE5oYXQgTWluaCIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS0vQU9oMTRHaXI3bzV6RW1lNVNBOHJFM3dndzlhcC14Wk1HYzBoSDI4enhMOHVmdz1zOTYtYyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nc21zLTQxZjlhIiwiYXVkIjoiZ3Ntcy00MWY5YSIsImF1dGhfdGltZSI6MTY0NzQwMTYyOCwidXNlcl9pZCI6ImEwWndnd1pNc29oTktTQTBqcUIyNXNhUTVQZjEiLCJzdWIiOiJhMFp3Z3daTXNvaE5LU0EwanFCMjVzYVE1UGYxIiwiaWF0IjoxNjQ3NDAxNjI4LCJleHAiOjE2NDc0MDUyMjgsImVtYWlsIjoibWluaG5obnNlMTMwNTE3QGZwdC5lZHUudm4iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjExNjIzNjE5MjUzNzAzMzcwMTU2NyJdLCJlbWFpbCI6WyJtaW5obmhuc2UxMzA1MTdAZnB0LmVkdS52biJdfSwic2lnbl9pbl9wcm92aWRlciI6Imdvb2dsZS5jb20ifX0.Kfmo-kra3XAhsAuZi8evxO0RzA3XUVUYBmhvmJpUlbi-uf-GLu3vcRy9do-9Sk8NFvsrnnbNgkZJa5w_kZFHkNkfAd-5NDTO6Bunp1HX0AyrWDJ_bR_GfkYleiH_1WDquJUkuH0Wrp-Hv76Vv9dY7OzKbC1_OvrDqCGLYBylqvDtkKwixHy9WzgbbMcAcGcpCGTOUZxk46dRk_AJ9DfS1WxGHjziy2SWoa6yd3xhP9aytcGjCl1FolfLGVYUDDD07uIOAu8IdklJZaFC2xPfmqw3GU3vPAqkDOrHVI0wH3kLugICrm4plMPiYpErwOD7s5fww6Qzi19Ciuj_rOKLMw';

  /* ImportOrder API */
  Future<List<ImportOrder>> fetchOrders() async {
    List<ImportOrder> list = [];
    dio.options.headers = {"Authorization": 'Bearer $token'};
    try {
      var response = await dio.get(
          baseUrl + '/import-orders?page=1&page-size=10',
          options: Options(responseType: ResponseType.plain));
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
    dio.options.headers = {"Authorization": 'Bearer $token'};
    try {
      var response = await dio.get(
          baseUrl + '/import-order-details?importOrderId=$orderID',
          options: Options(responseType: ResponseType.plain));
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
    dio.options.headers = {"Authorization": 'Bearer $token'};
    try {
      var response = await dio.get(baseUrl + '/products?page=1&page-size=10',
          options: Options(responseType: ResponseType.plain));
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

  Future<Product> createProduct(Product product) async {
    Product product = Product();
    dio.options.headers = {"Authorization": 'Bearer $token'};
    var formData = FormData.fromMap({
      'atomicPrice': product.atomicPrice,
      'masterProductId': product.masterProductId,
      'name': product.name,
      'imageUrl': product.imageUrl,
      'categoryId': product.categoryId,
      'isDeleted': false,
    });
    try {
      var response = await dio.post(baseUrl + '/products', data: formData);
      product = json.decode(response.data);
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
    return product;
  }

}

// , options: Options(responseType: ResponseType.plain)
