import 'dart:convert';

import 'package:http/http.dart' as http;

import '../api_url.dart';
import '../model/main_model.dart';

abstract class MainDatasourceAbstract {
  Future<MainModel> getMain(String api);
}

class MainDatasource implements MainDatasourceAbstract {
  @override
  Future<MainModel> getMain(String api) async {
    final Uri uri = Uri.parse(ApiUrl.apiUrl);
    final response = await http.get(uri);
    String data = response.body;
    var json = jsonDecode(data);
    if (json == null) {
      throw Exception("Not Data");
    }
    MainModel mainModel = MainModel.fromJson(json['main']);
    return mainModel;
  }
}
