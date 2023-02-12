import 'dart:convert';

import '../api_url.dart';
import 'package:http/http.dart' as http;

abstract class FetchDataAbstract {
  Future<void> fetchMainData() async {
    final Uri uri = Uri.parse(ApiUrl.apiUrl);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      String data = response.body;
      var json = jsonDecode(data);
    }
  }
}
