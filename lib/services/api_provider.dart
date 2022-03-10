import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gsms_mobileapp_swd/models/import_order.dart';

class ApiProvider {
  final Dio dio = Dio();
  final String baseUrl = 'https://gsms-api.azurewebsites.net/api/v1.0';
  final String jsonPlaceHolder = 'https://jsonplaceholder.typicode.com/';

  /* ImportOrder API */
  Future<List<ImportOrder>> fetchOrders() async {
    List<ImportOrder> orderList = [];
    try {
      var response = await dio.get(baseUrl + '/import-orders?page=1&page-size=10',
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            'Authorization':
                'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjJkYzBlNmRmOTgyN2EwMjA2MWU4MmY0NWI0ODQwMGQwZDViMjgyYzAiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiTmd1eWVuIEh1eW5oIE5oYXQgTWluaCIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS0vQU9oMTRHaXI3bzV6RW1lNVNBOHJFM3dndzlhcC14Wk1HYzBoSDI4enhMOHVmdz1zOTYtYyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nc21zLTQxZjlhIiwiYXVkIjoiZ3Ntcy00MWY5YSIsImF1dGhfdGltZSI6MTY0Njg4MDQ4OCwidXNlcl9pZCI6ImEwWndnd1pNc29oTktTQTBqcUIyNXNhUTVQZjEiLCJzdWIiOiJhMFp3Z3daTXNvaE5LU0EwanFCMjVzYVE1UGYxIiwiaWF0IjoxNjQ2ODgwNDg4LCJleHAiOjE2NDY4ODQwODgsImVtYWlsIjoibWluaG5obnNlMTMwNTE3QGZwdC5lZHUudm4iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjExNjIzNjE5MjUzNzAzMzcwMTU2NyJdLCJlbWFpbCI6WyJtaW5obmhuc2UxMzA1MTdAZnB0LmVkdS52biJdfSwic2lnbl9pbl9wcm92aWRlciI6Imdvb2dsZS5jb20ifX0.IiRcgtFSygqj1akBrpwPmeO44LVZR0mEj5bTBeupxWFzQXim1DCgz57gYbNrt1_5KLwJzOPCcrZu37BVU0a4rcgFi8LPnIl1DX0jZWPB9jEtrNtukqye95qJ2Yr4EwP7v2wCAh6G3TfSzsyW4Is5_XcPCE7dWAZS1IGWHZBHIOwWq5tjEqpEYZduTj3tFmCrcDagXcuU593W3MYVvVpTB6vTUOcBpP2J51rZV-uCtZUVgkn5MBbUgoHtRDomUg-AmtPvVFvmbPq_6zWirWSJoSTVBDL9tXYQXTm7wZEI3HN03XPJ4rjQd5aM6caTIkouLUo-z32KhRkllXHEsZCvTA'
          },
        ),
      );
      print("Response: " + response.data.toString());

      Iterable l = jsonDecode(response.data.toString());
      orderList = List<ImportOrder>.from(l.map((e) => ImportOrder.fromJson(e)));

      // orderList = (json.decode(response.data) as List).map((i) => ImportOrder.fromJson(i)).toList();
    } catch (error, stacktrace) {
      if (error is DioError) {
        // Only catch Dio error
        print('Dio error!');
        print('STATUS: ${error.response?.statusCode}');
        print('DATA: ${error.response?.data}');
        print('HEADERS: ${error.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print("Exception occured: $error stackTrace: $stacktrace");
      }
    }
    return orderList;
  }
}
