import 'dart:convert';

import 'package:open_weather_app/model/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class WeatherDatasourceAbstract {
  Future<WeatherModel?> getWeather(String api);
}

class WeatherDatasource implements WeatherDatasourceAbstract {
  @override
  Future<WeatherModel?> getWeather(String api) async {
    try {
      final Uri uri = Uri.parse(api);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        String data = response.body;
        var json = jsonDecode(data);
        WeatherModel weatherModel = WeatherModel.fromJson(json['weather'][0]);
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
