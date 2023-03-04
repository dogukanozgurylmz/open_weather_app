import 'dart:convert';
import 'dart:math';

import 'package:open_weather_app/model/weather_model.dart';
import 'package:http/http.dart' as http;

import '../api_url.dart';

abstract class WeatherDatasourceAbstract {
  Future<WeatherModel?> getWeather();
}

class WeatherDatasource implements WeatherDatasourceAbstract {
  @override
  Future<WeatherModel?> getWeather() async {
    try {
      final Uri uri = Uri.parse(ApiUrl.apiUrl);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        String data = response.body;
        var json = jsonDecode(data);
        WeatherModel weatherModel = WeatherModel(
          id: json['weather'][0]['id'],
          main: json['weather'][0]['main'],
          description: json['weather'][0]['description'],
          icon: json['weather'][0]['icon'],
        );
        if (weatherModel.toString().isNotEmpty) {
          return weatherModel;
        } else {
          return null;
        }
      }
    } on Exception catch (e) {
      return Future.error(e.toString());
    }
    return null;
  }
}
