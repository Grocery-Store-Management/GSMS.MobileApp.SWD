import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gsms_mobileapp_swd/models/brand.dart';
import 'package:gsms_mobileapp_swd/models/category.dart';
import 'package:gsms_mobileapp_swd/models/product.dart';
import 'package:gsms_mobileapp_swd/models/import_order.dart';
import 'package:gsms_mobileapp_swd/models/import_order_detail.dart';
import 'package:gsms_mobileapp_swd/models/product_detail.dart';
import 'package:gsms_mobileapp_swd/models/receipt.dart';
import 'package:gsms_mobileapp_swd/models/receipt_detail.dart';
import 'package:gsms_mobileapp_swd/models/store.dart';

class ApiProvider {
  final dio = Dio();
  final String baseUrl = 'https://gsms-api.azurewebsites.net/api/v1.0';
  final FirebaseAuth _auth = FirebaseAuth.instance;
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authChanges => _auth.authStateChanges();
  User get user => _auth.currentUser!;
  var token = '';

/* Brand API */

  Future<List<Brand>> fetchBrands(int sort, int page, int pageSize) async {
    List<Brand> data = [];
    if (user != null) {
      token = await user.getIdToken();
    }
    dio.options.headers = {"Authorization": 'Bearer $token'};
    try {
      var response = await dio.get(baseUrl + '/brands?sort-by-date=$sort&page=$page&page-size=$pageSize',
          options: Options(responseType: ResponseType.plain));
      data = (json.decode(response.data) as List)
          .map((e) => Brand.fromJson(e))
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
    return data;
  }

  Future<Brand> fetchBrandId(String id) async {
    if (user != null) {
      token = await user.getIdToken();
    }
    Brand data = Brand();
    dio.options.headers = {"Authorization": 'Bearer $token'};
    try {
      Response response = await dio.get(baseUrl + '/brands/$id',
          options: Options(responseType: ResponseType.plain));
      data = Brand.fromJson(json.decode(response.data));
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
    return data;
  }

  Future<bool> createBrand(Brand brand) async {
    bool isCreated = false;
    if (user != null) {
      token = await user.getIdToken();
    }
    dio.options.headers = {"Authorization": 'Bearer $token'};
    var formData = {
      "id": null,
      "name": brand.name,
      "createdDate": null,
      "isDeleted": false,
    };
    try {
      await dio.post(baseUrl + '/brands', data: json.encode(formData));
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

  Future<bool> updateBrand(Brand brand) async {
    bool isCreated = false;
    if (user != null) {
      token = await user.getIdToken();
    }
    dio.options.headers = {"Authorization": 'Bearer $token'};
    var formData = {
      "id": brand.id,
      "name": brand.name,
      "createdDate": brand.createdDate,
      "isDeleted": brand.isDeleted,
    };
    try {
      await dio.put(baseUrl + '/brands/${brand.id}', data: json.encode(formData));
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

  Future<bool> deleteBrand(String brandId) async {
    if (user != null) {
      token = await user.getIdToken();
    }
    bool isDeleted = false;
    dio.options.headers = {"Authorization": 'Bearer $token'};
    try {
      await dio.delete(baseUrl + '/brands/$brandId');
      isDeleted = true;
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

  Future<List<Brand>> fetchBrandsByDate(int sort) async {
    List<Brand> data = [];
    if (user != null) {
      token = await user.getIdToken();
    }
    dio.options.headers = {"Authorization": 'Bearer $token'};
    try {
      var response = await dio.get(baseUrl + '/brands?sort-by-date=$sort&page=1&page-size=10',
          options: Options(responseType: ResponseType.plain));
      data = (json.decode(response.data) as List)
          .map((e) => Brand.fromJson(e))
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
    return data;
  }

/* ImportOrder API */

  Future<List<ImportOrder>> fetchOrders() async {
    List<ImportOrder> data = [];
    if (user != null) {
      token = await user.getIdToken();
    }
    dio.options.headers = {"Authorization": 'Bearer $token'};
    try {
      var response = await dio.get(
          baseUrl + '/import-orders?page=1&page-size=10',
          options: Options(responseType: ResponseType.plain));
      data = (json.decode(response.data) as List)
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
    return data;
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
    List<ImportOrderDetail> data = [];
    dio.options.headers = {"Authorization": 'Bearer $token'};
    try {
      Response response = await dio.get(
          baseUrl + '/import-order-details?importOrderId=$orderId',
          options: Options(responseType: ResponseType.plain));
      data = (json.decode(response.data) as List)
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
    return data;
  }

/* Product API */

  Future<List<Product>> fetchProducts(int page, int pageSize, int sort) async {
    if (user != null) {
      token = await user.getIdToken();
    }
    List<Product> data = [];
    dio.options.headers = {"Authorization": 'Bearer $token'};
    try {
      Response response = await dio.get(
          baseUrl + '/products?sort-by-name=$sort&page=$page&page-size=$pageSize',
          options: Options(responseType: ResponseType.plain));
      data = (json.decode(response.data) as List)
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
    return data;
  }

  Future<Product> fetchProductId(String id) async {
    if (user != null) {
      token = await user.getIdToken();
    }
    Product data = Product();
    dio.options.headers = {"Authorization": 'Bearer $token'};
    try {
      Response response = await dio.get(baseUrl + '/products/$id',
          options: Options(responseType: ResponseType.plain));
      data = Product.fromJson(json.decode(response.data));
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
    return data;
  }

  Future<bool> deleteProduct(String Id) async {
    if (user != null) {
      token = await user.getIdToken();
    }
    bool isDeleted = false;
    dio.options.headers = {"Authorization": 'Bearer $token'};
    try {
      Response response = await dio.delete(baseUrl + '/products/$Id');
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

/* ProductDetail API */

  Future<List<ProductDetail>> fetchProductDetail(String id) async {
    if (user != null) {
      token = await user.getIdToken();
    }
    List<ProductDetail> data = [];
    dio.options.headers = {"Authorization": 'Bearer $token'};
    try {
      Response response = await dio.get(
          baseUrl + '/product-details?product-id=$id&page=1&page-size=10',
          options: Options(responseType: ResponseType.plain));
      data = (json.decode(response.data) as List)
          .map((e) => ProductDetail.fromJson(e))
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
    return data;
  }

/* Category API */

  Future<List<Category>> fetchCategories() async {
    List<Category> data = [];
    if (user != null) {
      token = await user.getIdToken();
    }
    dio.options.headers = {"Authorization": 'Bearer $token'};
    try {
      var response = await dio.get(baseUrl + '/categories?page=1&page-size=10',
          options: Options(responseType: ResponseType.plain));
      data = (json.decode(response.data) as List)
          .map((e) => Category.fromJson(e))
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
    return data;
  }

  Future<Category> fetchCategoryId(String? id) async {
    if (user != null) {
      token = await user.getIdToken();
    }
    Category data = Category();
    dio.options.headers = {"Authorization": 'Bearer $token'};
    try {
      Response response = await dio.get(baseUrl + '/categories/${id!}',
          options: Options(responseType: ResponseType.plain));
      data = Category.fromJson(json.decode(response.data));
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
    return data;
  }

/* Receipt API */

  Future<List<Receipt>> fetchReceipts() async {
    if (user != null) {
      token = await user.getIdToken();
    }
    List<Receipt> data = [];
    dio.options.headers = {"Authorization": 'Bearer $token'};
    try {
      Response response = await dio.get(
          baseUrl + '/receipts?page=1&page-size=10',
          options: Options(responseType: ResponseType.plain));
      data = (json.decode(response.data) as List)
          .map((e) => Receipt.fromJson(e))
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
    return data;
  }

/* ReceiptDetail API */

  Future<List<ReceiptDetail>> fetchReceiptDetails() async {
    if (user != null) {
      token = await user.getIdToken();
    }
    List<ReceiptDetail> data = [];
    dio.options.headers = {"Authorization": 'Bearer $token'};
    try {
      var response = await dio.get(baseUrl + '/receipt-details',
          options: Options(responseType: ResponseType.plain));
      data = (json.decode(response.data) as List)
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
    return data;
  }

  Future<List<ReceiptDetail>> fetchReceiptDetailId(String id) async {
    if (user != null) {
      token = await user.getIdToken();
    }
    List<ReceiptDetail> data = [];
    dio.options.headers = {"Authorization": 'Bearer $token'};
    try {
      var response = await dio.get(baseUrl + '/receipt-details?receiptId=2c8472c4-8644-499b-8003-e1563895f3f0',
          options: Options(responseType: ResponseType.plain));
      data = (json.decode(response.data) as List)
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
    return data;
  }

/* Store API */

  Future<List<Store>> fetchStores() async {
    if (user != null) {
      token = await user.getIdToken();
    }
    List<Store> data = [];
    dio.options.headers = {"Authorization": 'Bearer $token'};
    try {
      Response response = await dio.get(
          baseUrl + '/stores?page=1&page-size=10',
          options: Options(responseType: ResponseType.plain));
      data = (json.decode(response.data) as List)
          .map((e) => Store.fromJson(e))
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
    return data;
  }
}
