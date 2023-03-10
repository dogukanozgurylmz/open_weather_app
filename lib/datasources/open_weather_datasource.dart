import 'dart:convert';
import 'package:http/http.dart' as http;

import '../api_url.dart';
import '../model/open_weather_model.dart';

abstract class OpenWeatherDatasourceAbstract {
  Future<OpenWeatherModel> getOpenWeather(String api);
}

class OpenWeatherDatasource implements OpenWeatherDatasourceAbstract {
  @override
  Future<OpenWeatherModel> getOpenWeather(String api) async {
    final Uri uri = Uri.parse(ApiUrl.apiUrl);
    final response = await http.get(uri);
    String data = response.body;
    var json = jsonDecode(data);
    if (json == null) {
      throw Exception("Not Data");
    }
    OpenWeatherModel openWeatherModel = OpenWeatherModel.fromJson(json);

    return openWeatherModel;
  }
}
