import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gsms_mobileapp_swd/models/product.dart';
import 'package:gsms_mobileapp_swd/models/import_order.dart';
import 'package:gsms_mobileapp_swd/models/import_order_detail.dart';

class ApiProvider {
  final dio = Dio();
  final String baseUrl = 'https://gsms-api.azurewebsites.net/api/v1.0';

  var token =
      'eyJhbGciOiJSUzI1NiIsImtpZCI6ImYxZDU2YTI1MWU0ZGRhM2Y0NWM0MWZkNWQ0ZGEwMWQyYjlkNzJlMGQiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiTmd1eWVuIEh1eW5oIE5oYXQgTWluaCIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS0vQU9oMTRHaXI3bzV6RW1lNVNBOHJFM3dndzlhcC14Wk1HYzBoSDI4enhMOHVmdz1zOTYtYyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nc21zLTQxZjlhIiwiYXVkIjoiZ3Ntcy00MWY5YSIsImF1dGhfdGltZSI6MTY0NzU3MzQ1MywidXNlcl9pZCI6ImEwWndnd1pNc29oTktTQTBqcUIyNXNhUTVQZjEiLCJzdWIiOiJhMFp3Z3daTXNvaE5LU0EwanFCMjVzYVE1UGYxIiwiaWF0IjoxNjQ3NTczNDUzLCJleHAiOjE2NDc1NzcwNTMsImVtYWlsIjoibWluaG5obnNlMTMwNTE3QGZwdC5lZHUudm4iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjExNjIzNjE5MjUzNzAzMzcwMTU2NyJdLCJlbWFpbCI6WyJtaW5obmhuc2UxMzA1MTdAZnB0LmVkdS52biJdfSwic2lnbl9pbl9wcm92aWRlciI6Imdvb2dsZS5jb20ifX0.lhk7rqzFO-yRRtVPjg-ToLJDcsTE7A6iAGuCVYmZJ7v3a4_tW0umnE0Y_J8FJHzqOLToQfngOjWEbmKs7bWwdsj_uhR4ZEq7ST0ZxOigdRYBJd4-27GrG2q9oNE02ZU1O711n-woaYfPlUqLf7b2uq_C0wK75k-qs_jB2gB07hmzM2HNxD1MCDq2pddR7KP2b4dJyaxqaDQyborh_8gchLR67GUY5N8RSBsk_k801fyCLTAVpVQONx8xLP3ufiL1lnKdJCpbl_liiv4uiJgafUplNn4L65I29WCHHGnnNGXLPz5YCuuAt3m90Vzx2EVJpPhcEhSVPtLa-x1egXBaFg';

  /* ImportOrder API */
  Future<List<ImportOrder>> fetchOrders() async {
    List<ImportOrder> list = [];
    dio.options.headers = {"Authorization": 'Bearer $token'};
    try {
      var response = await dio.get(baseUrl + '/import-orders?page=1&page-size=10', options: Options(responseType: ResponseType.plain));
      list = (json.decode(response.data) as List).map((e) => ImportOrder.fromJson(e)).toList();
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
      var response = await dio.get(baseUrl + '/import-order-details?importOrderId=$orderID', options: Options(responseType: ResponseType.plain));
      list = (json.decode(response.data) as List).map((e) => ImportOrderDetail.fromJson(e)).toList();
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
      var response = await dio.get(baseUrl + '/products?page=1&page-size=10', options: Options(responseType: ResponseType.plain));
      list = (json.decode(response.data) as List).map((e) => Product.fromJson(e)).toList();
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

  Future<void> createProduct(Product product) async {
    dio.options.headers = {'Authorization': 'Bearer $token'};
    dio.options.contentType = 'application/json';
    var formData = {
      'atomicPrice': product.atomicPrice,
      'masterProductId': product.masterProductId,
      'name': product.name,
      'imageUrl': product.imageUrl,
      'categoryId': product.categoryId,
      'isDeleted': false,
    };
    try {
      Response response = await dio.post(baseUrl + '/products', data: json.encode(formData));
      print(response.data.toString());
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
  }
}

// , options: Options(responseType: ResponseType.plain)
