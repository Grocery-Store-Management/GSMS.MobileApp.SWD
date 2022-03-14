import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gsms_mobileapp_swd/models/product.dart';
import 'package:gsms_mobileapp_swd/models/import_order.dart';
import 'package:gsms_mobileapp_swd/models/import_order_detail.dart';

class ApiProvider {
  final dio = Dio();
  final String baseUrl = 'https://gsms-api.azurewebsites.net/api/v1.0';

  var token =
      'eyJhbGciOiJSUzI1NiIsImtpZCI6ImYxZDU2YTI1MWU0ZGRhM2Y0NWM0MWZkNWQ0ZGEwMWQyYjlkNzJlMGQiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiTmd1eWVuIEh1eW5oIE5oYXQgTWluaCIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS0vQU9oMTRHaXI3bzV6RW1lNVNBOHJFM3dndzlhcC14Wk1HYzBoSDI4enhMOHVmdz1zOTYtYyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nc21zLTQxZjlhIiwiYXVkIjoiZ3Ntcy00MWY5YSIsImF1dGhfdGltZSI6MTY0NzIyMTc1MCwidXNlcl9pZCI6ImEwWndnd1pNc29oTktTQTBqcUIyNXNhUTVQZjEiLCJzdWIiOiJhMFp3Z3daTXNvaE5LU0EwanFCMjVzYVE1UGYxIiwiaWF0IjoxNjQ3MjIxNzUwLCJleHAiOjE2NDcyMjUzNTAsImVtYWlsIjoibWluaG5obnNlMTMwNTE3QGZwdC5lZHUudm4iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjExNjIzNjE5MjUzNzAzMzcwMTU2NyJdLCJlbWFpbCI6WyJtaW5obmhuc2UxMzA1MTdAZnB0LmVkdS52biJdfSwic2lnbl9pbl9wcm92aWRlciI6Imdvb2dsZS5jb20ifX0.XUyMI4_EL4clCHLIiqIRfVlGkryi69McyO3k3zHcJKgUTXTmsHpZ4WQUMayyhAVbFstnxf1zkoK7Ll0VR6ppKzmXypLuhZpcHIHfRoFB7slt99djrbyCF69TXylmtdEO1YuXX75cU-NeZrsiDaf-vGxEcVh-Mid6EnoaHTTrEJb_At0CVQu4C6LqEHhvyyXIWgM6pSvM2XgBEIi-5HdP07m5sxirHkMS56_SpRpstWd4MGyPGUYv5JIkh3A3yCjywiY1xbptgIo5kkLGbSKImx3X6BK551EAu_UEkRyT64GtGJ48Q6OWz1QGmrZpElS-kGIYxRmlpmpUzJN7JkjVsQ';

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

  Future<Product> createProduct([atomicPrice, name, imageUrl, categoryId]) async {
    Product product = Product();
    dio.options.headers = {"Authorization": 'Bearer $token'};
    var formData = FormData.fromMap({
      "atomicPrice": atomicPrice,
      "name": name,
      "imageUrl": imageUrl,
      "categoryId": categoryId,
      "isDeleted": false,
    });
    try {
      var response = await dio.post(baseUrl + '/products', data: formData);
      if (response.statusCode == 200) {
        print("Product created successfully.");
      }
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
