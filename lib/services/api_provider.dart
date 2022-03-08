import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gsms_mobileapp_swd/models/import_order.dart';

class ApiProvider {
  final Dio dio = Dio();
  final String baseUrl = 'https://gsms-api.azurewebsites.net/api/v1.0';

  /* ImportOrder API */
  Future<List<ImportOrder>> fetchOrders() async {
    List<ImportOrder> temp = [];
    try {
      Response response = await dio.get(
        baseUrl + '/import-orders?start-date=2022-02-01&end-date=2022-03-01&page=1&page-size=10',
        options: Options(
          headers: {
            'Authorization':
                'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjJkYzBlNmRmOTgyN2EwMjA2MWU4MmY0NWI0ODQwMGQwZDViMjgyYzAiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiTmd1eWVuIEh1eW5oIE5oYXQgTWluaCIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS0vQU9oMTRHaXI3bzV6RW1lNVNBOHJFM3dndzlhcC14Wk1HYzBoSDI4enhMOHVmdz1zOTYtYyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nc21zLTQxZjlhIiwiYXVkIjoiZ3Ntcy00MWY5YSIsImF1dGhfdGltZSI6MTY0Njc0ODU1MiwidXNlcl9pZCI6ImEwWndnd1pNc29oTktTQTBqcUIyNXNhUTVQZjEiLCJzdWIiOiJhMFp3Z3daTXNvaE5LU0EwanFCMjVzYVE1UGYxIiwiaWF0IjoxNjQ2NzQ4NTUyLCJleHAiOjE2NDY3NTIxNTIsImVtYWlsIjoibWluaG5obnNlMTMwNTE3QGZwdC5lZHUudm4iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjExNjIzNjE5MjUzNzAzMzcwMTU2NyJdLCJlbWFpbCI6WyJtaW5obmhuc2UxMzA1MTdAZnB0LmVkdS52biJdfSwic2lnbl9pbl9wcm92aWRlciI6Imdvb2dsZS5jb20ifX0.UizvpiCyhLwnPxFCv5sRCK3ufEJ9e9hl_26x-xqqF5zV6UfdtIImyk9t24ygpdBbM2wKjhJqsHYUS8z802qbR3MGW0pFL72NyPIcr6C6DBlhjtynIxwR0ST5qPLiQtTeuN1iPhfro5SXZ23c9yByGIRRvV9Yh6yqHh3oUeMKDj5y8R6n-aD7eE11NLnFhlGVw-EdA3GtpUc9tqt5xO2uhcGaB8Yu6Iv1_cnh9a54EnsJKC43WSmk1PN2HY2wACqzoiruX2IPiGCn2YKfAP7KE9RwrrpSrhw-_Wc-jDR9chQM5uuRHKUMn6A8AjBiiDZxweXVLbVfFeVYlvx5VDzMpQ'
          },
        ),
      );
      var jsonList = jsonDecode(response.data);
      for (var order in jsonList){
        temp.add(ImportOrder.fromJson(order));
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
    return temp;
  }
}
