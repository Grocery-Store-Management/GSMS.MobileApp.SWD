import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gsms_mobileapp_swd/models/product.dart';
import 'package:gsms_mobileapp_swd/models/import_order.dart';
import 'package:gsms_mobileapp_swd/models/import_order_detail.dart';

class ApiProvider {
  final dio = Dio();
  final String baseUrl = 'https://gsms-api.azurewebsites.net/api/v1.0';

  var token =
      'eyJhbGciOiJSUzI1NiIsImtpZCI6ImYxZDU2YTI1MWU0ZGRhM2Y0NWM0MWZkNWQ0ZGEwMWQyYjlkNzJlMGQiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiTmd1eWVuIEh1eW5oIE5oYXQgTWluaCIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS0vQU9oMTRHaXI3bzV6RW1lNVNBOHJFM3dndzlhcC14Wk1HYzBoSDI4enhMOHVmdz1zOTYtYyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nc21zLTQxZjlhIiwiYXVkIjoiZ3Ntcy00MWY5YSIsImF1dGhfdGltZSI6MTY0NzY3NDM4MywidXNlcl9pZCI6ImEwWndnd1pNc29oTktTQTBqcUIyNXNhUTVQZjEiLCJzdWIiOiJhMFp3Z3daTXNvaE5LU0EwanFCMjVzYVE1UGYxIiwiaWF0IjoxNjQ3Njc0MzgzLCJleHAiOjE2NDc2Nzc5ODMsImVtYWlsIjoibWluaG5obnNlMTMwNTE3QGZwdC5lZHUudm4iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjExNjIzNjE5MjUzNzAzMzcwMTU2NyJdLCJlbWFpbCI6WyJtaW5obmhuc2UxMzA1MTdAZnB0LmVkdS52biJdfSwic2lnbl9pbl9wcm92aWRlciI6Imdvb2dsZS5jb20ifX0.EqyxMMr2Rq3iZBuTy_8RfSQB6hrcLy2qaujgmCB8XN3zFWaHuJQS_VlvgykDp5MbVsbzwBqSyOmGj8JVfOCZd5w1hsjWk5NufmIt6Z2rQXvleBZDyYYJHFhD-3Ki2tbHcqhDjCOCDLq_GUKrJwL6CxiiA1z99CvtWZNQqWxgmCywZb5YdSWUQrErazbTUSq7tzsVkV4tBGBVv0PNLeClx7G-bdoS5lLPfg9Pcjzm4f7XDYPsRxATrLxxKznYZJ9Zd1s_CIOd3QGhIecsUGRjaHV2R_sUy3Jonnl2Ldf0n0J7BlYkPNwpclc3LUbTBHaWW8ygiQPGyBeGSJAKj5tO6A';

  /* ImportOrder API */

  Future<List<ImportOrder>> fetchOrders() async {
    List<ImportOrder> list = [];
    dio.options.headers = {"Authorization": 'Bearer $token'};
    try {
      var response = await dio.get(baseUrl + '/import-orders?page=1&page-size=10', options: Options(responseType: ResponseType.plain));
      list = (json.decode(response.data) as List).map((e) => ImportOrder.fromJson(e)).toList();
    } catch (error, stacktrace) {
      if (error is DioError) {
        debugPrint('An error has occurred!');
        debugPrint('STATUS: ${error.response?.statusCode}');
        debugPrint('DATA: ${error.response?.data}');
        debugPrint('HEADERS: ${error.response?.headers}');
      } else {
        debugPrint('Error sending request!');
        debugPrint("Exception occurred: $error stackTrace: $stacktrace");
      }
    }
    return list;
  }

  Future<bool> deleteOrder(String orderId) async {
    bool isDeleted = false;
    dio.options.headers = {"Authorization": 'Bearer $token'};
    try {
      Response response = await dio.delete(baseUrl + '/import-orders/$orderId');
      if (response.statusCode == 200) {
        isDeleted = true;
      }
    } catch (error, stacktrace) {
      if (error is DioError) {
        debugPrint('An error has occurred!');
        debugPrint('STATUS: ${error.response?.statusCode}');
        debugPrint('DATA: ${error.response?.data}');
        debugPrint('HEADERS: ${error.response?.headers}');
      } else {
        debugPrint('Error sending request!');
        debugPrint("Exception occurred: $error stackTrace: $stacktrace");
      }
    }
    return isDeleted;
  }

  /* ImportOrderDetail API */

  Future<List<ImportOrderDetail>> fetchOrderDetails([orderID]) async {
    List<ImportOrderDetail> list = [];
    dio.options.headers = {"Authorization": 'Bearer $token'};
    try {
      Response response = await dio.get(baseUrl + '/import-order-details?importOrderId=$orderID', options: Options(responseType: ResponseType.plain));
      list = (json.decode(response.data) as List).map((e) => ImportOrderDetail.fromJson(e)).toList();
    } catch (error, stacktrace) {
      if (error is DioError) {
        debugPrint('An error has occurred!');
        debugPrint('STATUS: ${error.response?.statusCode}');
        debugPrint('DATA: ${error.response?.data}');
        debugPrint('HEADERS: ${error.response?.headers}');
      } else {
        debugPrint('Error sending request!');
        debugPrint("Exception occurred: $error stackTrace: $stacktrace");
      }
    }
    return list;
  }

  /* Product API */

  Future<List<Product>> fetchProducts() async {
    List<Product> list = [];
    dio.options.headers = {"Authorization": 'Bearer $token'};
    try {
      Response response = await dio.get(baseUrl + '/products?page=1&page-size=10', options: Options(responseType: ResponseType.plain));
      list = (json.decode(response.data) as List).map((e) => Product.fromJson(e)).toList();
    } catch (error, stacktrace) {
      if (error is DioError) {
        debugPrint('An error has occurred!');
        debugPrint('STATUS: ${error.response?.statusCode}');
        debugPrint('DATA: ${error.response?.data}');
        debugPrint('HEADERS: ${error.response?.headers}');
      } else {
        debugPrint('Error sending request!');
        debugPrint("Exception occurred: $error stackTrace: $stacktrace");
      }
    }
    return list;
  }

  Future<bool> createProduct(Product product) async {
    bool isCreated = false;
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
      if (response.statusCode! == 201) {
        isCreated = true;
      }
    } catch (error, stacktrace) {
      if (error is DioError) {
        debugPrint('An error has occurred!');
        debugPrint('STATUS: ${error.response?.statusCode}');
        debugPrint('DATA: ${error.response?.data}');
        debugPrint('HEADERS: ${error.response?.headers}');
      } else {
        debugPrint('Error sending request!');
        debugPrint("Exception occurred: $error stackTrace: $stacktrace");
      }
    }
    return isCreated;
  }
}

// , options: Options(responseType: ResponseType.plain)
