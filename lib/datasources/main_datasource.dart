import 'dart:convert';

import 'package:open_weather_app/model/weather_model.dart';
import 'package:http/http.dart' as http;

import '../api_url.dart';
import '../model/main_model.dart';

abstract class MainDatasourceAbstract {
  Future<MainModel> getMain();
}

class MainDatasource implements MainDatasourceAbstract {
  @override
  Future<MainModel> getMain() async {
    final Uri uri = Uri.parse(ApiUrl.apiUrl);
    final response = await http.get(uri);
    String data = response.body;
    var json = jsonDecode(data);
    MainModel mainModel = MainModel(
      temp: json['main']['temp'],
      feelsLike: json['main']['feelsLike'],
      tempMin: json['main']['tempMin'],
      tempMax: json['main']['tempMax'],
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
    );
    if (json == null) {
      throw Exception("Not Data");
    }
    return mainModel;
  }
}
