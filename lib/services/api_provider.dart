import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gsms_mobileapp_swd/models/import_order.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = 'https://gsms-api.azurewebsites.net/api/v1.0';

  /* ImportOrder API */
  Future<List<ImportOrder>> fetchOrders() async {
    final response = await _dio.get(_url + '/import-orders?start-date=2022-02-01&end-date=2022-02-28&page=1&page-size=10');
    if (response.statusCode == 200) {
      final data = json.decode(response.data) as List;
      return data.map((dynamic json) {
        return ImportOrder(
          id: json['id'] as String,
          name: json['name'] as String,
          createdDate: json['createdDate'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching posts');
  }
}

// _dio.options.headers = {
// 'lang': lang,
// 'Authorization': 'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjJkYzBlNmRmOTgyN2Ew'
// 'MjA2MWU4MmY0NWI0ODQwMGQwZDViMjgyYzAiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiT'
// 'md1eWVuIEh1eW5oIE5oYXQgTWluaCIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nb'
// 'GV1c2VyY29udGVudC5jb20vYS0vQU9oMTRHaXI3bzV6RW1lNVNBOHJFM3dndzlhcC14W'
// 'k1HYzBoSDI4enhMOHVmdz1zOTYtYyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ'
// '29vZ2xlLmNvbS9nc21zLTQxZjlhIiwiYXVkIjoiZ3Ntcy00MWY5YSIsImF1dGhfdGltZ'
// 'SI6MTY0NjYzNzk2NCwidXNlcl9pZCI6ImEwWndnd1pNc29oTktTQTBqcUIyNXNhUTVQZ'
// 'jEiLCJzdWIiOiJhMFp3Z3daTXNvaE5LU0EwanFCMjVzYVE1UGYxIiwiaWF0IjoxNjQ2N'
// 'jM3OTY0LCJleHAiOjE2NDY2NDE1NjQsImVtYWlsIjoibWluaG5obnNlMTMwNTE3QGZwd'
// 'C5lZHUudm4iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpd'
// 'GllcyI6eyJnb29nbGUuY29tIjpbIjExNjIzNjE5MjUzNzAzMzcwMTU2NyJdLCJlbWFpb'
// 'CI6WyJtaW5obmhuc2UxMzA1MTdAZnB0LmVkdS52biJdfSwic2lnbl9pbl9wcm92aWRlc'
// 'iI6Imdvb2dsZS5jb20ifX0.YNMIc8PBMzV45ZC3u98TQ8T612bpe-0yYMOC_6MLJxHRQ'
// 'x4oeOigfaxijbfkHxjnrFVDuKSjYqGfMNKgk_fM7Hq_FybMx7z0mWC78HZKr1D__-kNG'
// 'ZUo3HKkxl6BXEB2J27-Lus9Xsp15y7gOaXEieKFqFFUQzjUXa-U-B1TPNDZTF4PuJRAJ'
// 's_IA9fOXDLY7PttuAkRfUrdPx_ckSYib7lkW2nMeuD0wkFKMSLJAzhvB0S13fgTOiL-5'
// 'mpgklLg4a-yDQnE99H95LmzddHat73YihzQrMxkT48BHpDtuutppBzBoB5EIPWI5xlLX'
// 'GRpuIcQtkZOy2yl62Wb6CDlBA',
// 'Content-Type': 'application/json',
// };