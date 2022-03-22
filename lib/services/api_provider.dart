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
  var token = '';

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
