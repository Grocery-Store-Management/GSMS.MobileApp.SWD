import 'package:dio/dio.dart';
import 'package:gsms_mobileapp_swd/models/import_order.dart';

class ApiProvider {
  final Dio dio = Dio();
  final String baseUrl = 'https://gsms-api.azurewebsites.net/api/v1.0';

  /* ImportOrder API */
  Future<ImportOrder> fetchOrders() async {
    try {
      Response response = await dio.get(
        baseUrl +
            '/import-orders?start-date=2022-02-01&end-date=2022-03-01&page=1&page-size=10',
        options: Options(
          headers: {
            'Authorization':
                'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjJkYzBlNmRmOTgyN2EwMjA2MWU4MmY0NWI0ODQwMGQwZDViMjgyYzAiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiTmd1eWVuIEh1eW5oIE5oYXQgTWluaCIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS0vQU9oMTRHaXI3bzV6RW1lNVNBOHJFM3dndzlhcC14Wk1HYzBoSDI4enhMOHVmdz1zOTYtYyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nc21zLTQxZjlhIiwiYXVkIjoiZ3Ntcy00MWY5YSIsImF1dGhfdGltZSI6MTY0NjcyMjcxOCwidXNlcl9pZCI6ImEwWndnd1pNc29oTktTQTBqcUIyNXNhUTVQZjEiLCJzdWIiOiJhMFp3Z3daTXNvaE5LU0EwanFCMjVzYVE1UGYxIiwiaWF0IjoxNjQ2NzIyNzE4LCJleHAiOjE2NDY3MjYzMTgsImVtYWlsIjoibWluaG5obnNlMTMwNTE3QGZwdC5lZHUudm4iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjExNjIzNjE5MjUzNzAzMzcwMTU2NyJdLCJlbWFpbCI6WyJtaW5obmhuc2UxMzA1MTdAZnB0LmVkdS52biJdfSwic2lnbl9pbl9wcm92aWRlciI6Imdvb2dsZS5jb20ifX0.Qmu4I_QizZnWZCTVImF8DPVK6GT45iLFeAvZJiMMJjJej9xU6-_CVd_LgYWx5OqyAYkGANR3HU4CtCwxHVsjqwH-vzYDQyZlJIs8duQ8TxDq37C4hBP_0P7Aten9-ngMI2tarlQGBrZ_8izsRhJZ0Es6TmpRCZ99sl0VVHP1IlNaXDfgRJH6-2hcL_FjLEI1iK-lTFQ5VgLxU4mFBaoItyD8x_fVZRGm5DYCe1bKnOZPzUrGxzWDXDpxYrhNrcV_pBxPJFdYK7M6k7F3hT4tz1eH8d99yxc90GTPSfPBVGzxqysucXIC9R70Hb7xhKHNEg9-sRoucf8SRmFd9uMqWA'
          },
        ),
      );
      print("Status Code:" + response.statusCode.toString());
      return ImportOrder.fromJson(response.data);
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
      return ImportOrder.withError("Data not found / Connection issue");
    }
  }
}
