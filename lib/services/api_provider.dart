import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gsms_mobileapp_swd/models/product.dart';
import 'package:gsms_mobileapp_swd/models/import_order.dart';
import 'package:gsms_mobileapp_swd/models/import_order_detail.dart';
import 'package:gsms_mobileapp_swd/models/receipt_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gsms_mobileapp_swd/utils/utils.dart';

class ApiProvider {
  final dio = Dio();
  final String baseUrl = 'https://gsms-api.azurewebsites.net/api/v1.0';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authChanges => _auth.authStateChanges();
  User get user => _auth.currentUser!;
  //var token = await user.getIdToken();
  var token =
      'eyJhbGciOiJSUzI1NiIsImtpZCI6ImYxZDU2YTI1MWU0ZGRhM2Y0NWM0MWZkNWQ0ZGEwMWQyYjlkNzJlMGQiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiTmd1eWVuIEh1eW5oIE5oYXQgTWluaCIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS0vQU9oMTRHaXI3bzV6RW1lNVNBOHJFM3dndzlhcC14Wk1HYzBoSDI4enhMOHVmdz1zOTYtYyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nc21zLTQxZjlhIiwiYXVkIjoiZ3Ntcy00MWY5YSIsImF1dGhfdGltZSI6MTY0Nzg3NjQyMCwidXNlcl9pZCI6ImEwWndnd1pNc29oTktTQTBqcUIyNXNhUTVQZjEiLCJzdWIiOiJhMFp3Z3daTXNvaE5LU0EwanFCMjVzYVE1UGYxIiwiaWF0IjoxNjQ3ODc2NDIwLCJleHAiOjE2NDc4ODAwMjAsImVtYWlsIjoibWluaG5obnNlMTMwNTE3QGZwdC5lZHUudm4iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjExNjIzNjE5MjUzNzAzMzcwMTU2NyJdLCJlbWFpbCI6WyJtaW5obmhuc2UxMzA1MTdAZnB0LmVkdS52biJdfSwic2lnbl9pbl9wcm92aWRlciI6Imdvb2dsZS5jb20ifX0.V97ry3CwgyEhAq-2vk7wWTh_b0HKVcdtLFCg5jUy7MjdvHgbUQgBqI-sZV53kwvjWL8KfZBvRbtUF7l5RIUHeL-CzLJjd5rB5cLvrm1aP_uJYQDlILxp9dx4XSKIYO033ZU1HjghjvUSdnIvBNhvV3UinnMr1BBwoRYyAcZ4Gh6_JOvCTH3It0ST6cvBNKJlkfDJRYLA9s6FYLuT24HuNxmwdmkEoB1coa8Dg55OfGHA1M0XjkfhZsLtJNpXbh9F6hhMkP2_8bAhBrK_sMicbdzr2IYD6yeXtlq88_Pmt5IToMBjD3SypVeWjkOddNAv51fUhaRiq0wi9DQWwabFeA';

  /* ImportOrder API */

  Future<List<ImportOrder>> fetchOrders() async {
    List<ImportOrder> list = [];
    if (user != null) {
      token = await user.getIdToken();
    }
    dio.options.headers = {"Authorization": 'Bearer $token'};
    try {
      var response = await dio.get(
          baseUrl + '/import-orders?page=1&page-size=10',
          options: Options(responseType: ResponseType.plain));
      list = (json.decode(response.data) as List)
          .map((e) => ImportOrder.fromJson(e))
          .toList();
    } catch (error, stacktrace) {
      if (error is DioError) {
        debugPrint('An error has occurred!');
        debugPrint('STATUS: ${error.response?.statusCode}');
        debugPrint('DATA: ${error.response?.data}');
        debugPrint('HEADERS: ${error.response?.headers}');
        debugPrint("Exception occurred: $error stackTrace: $stacktrace");
      } else {
        debugPrint('Error sending request!');
        debugPrint("Exception occurred: $error stackTrace: $stacktrace");
      }
    }
    return list;
  }

  Future<bool> deleteOrder(String orderId) async {
    if (user != null) {
      token = await user.getIdToken();
    }
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

  Future<List<ImportOrderDetail>> fetchOrderDetails(String orderId) async {
    if (user != null) {
      token = await user.getIdToken();
    }
    List<ImportOrderDetail> list = [];
    dio.options.headers = {"Authorization": 'Bearer $token'};
    try {
      Response response = await dio.get(
          baseUrl + '/import-order-details?importOrderId=$orderId',
          options: Options(responseType: ResponseType.plain));
      list = (json.decode(response.data) as List)
          .map((e) => ImportOrderDetail.fromJson(e))
          .toList();
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
    if (user != null) {
      token = await user.getIdToken();
    }
    List<Product> list = [];
    dio.options.headers = {"Authorization": 'Bearer $token'};
    try {
      Response response = await dio.get(
          baseUrl + '/products?page=1&page-size=10',
          options: Options(responseType: ResponseType.plain));
      list = (json.decode(response.data) as List)
          .map((e) => Product.fromJson(e))
          .toList();
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
    if (user != null) {
      token = await user.getIdToken();
    }
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
      Response response =
          await dio.post(baseUrl + '/products', data: json.encode(formData));
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

  /* ReceiptDetail API */

  Future<List<ReceiptDetail>> fetchReceiptDetails() async {
    if (user != null) {
      token = await user.getIdToken();
    }
    List<ReceiptDetail> list = [];
    dio.options.headers = {"Authorization": 'Bearer $token'};
    try {
      var response = await dio.get(baseUrl + '/receipt-details',
          options: Options(responseType: ResponseType.plain));
      list = (json.decode(response.data) as List)
          .map((e) => ReceiptDetail.fromJson(e))
          .toList();
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
}

// , options: Options(responseType: ResponseType.plain)
