import 'dart:convert';
import 'package:http/http.dart' as http;

import '../api_url.dart';
import '../model/open_weather_model.dart';

abstract class OpenWeatherDatasourceAbstract {
  Future<OpenWeatherModel> getOpenWeather();
}

class OpenWeatherDatasource implements OpenWeatherDatasourceAbstract {
  @override
  Future<OpenWeatherModel> getOpenWeather() async {
    final Uri uri = Uri.parse(ApiUrl.apiUrl);
    final response = await http.get(uri);
    String data = response.body;
    var json = jsonDecode(data);
    OpenWeatherModel openWeatherModel = OpenWeatherModel(
      weather: json['weather'][0],
      main: json['main'],
      wind: json['wind'],
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
    );
    if (json == null) {
      throw Exception("Not Data");
    }
    return openWeatherModel;
  }
}
