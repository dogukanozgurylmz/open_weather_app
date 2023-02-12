import 'dart:convert';

import 'package:open_weather_app/model/weather_model.dart';
import 'package:http/http.dart' as http;

import '../api_url.dart';

abstract class WeatherDatasourceAbstract {
  Future<WeatherModel> getWeather();
}

class WeatherDatasource implements WeatherDatasourceAbstract {
  @override
  Future<WeatherModel> getWeather() async {
    final Uri uri = Uri.parse(ApiUrl.apiUrl);
    final response = await http.get(uri);
    String data = response.body;
    var json = jsonDecode(data);
    WeatherModel weatherModel = WeatherModel(
      id: json['weather'][0]['id'],
      main: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
    if (json == null) {
      throw Exception("Not Data");
    }
    return weatherModel;
  }
}
