import 'package:open_weather_app/model/main_model.dart';
import 'package:open_weather_app/model/weather_model.dart';
import 'package:open_weather_app/model/wind_model.dart';

class OpenWeatherModel {
  WeatherModel? weather;
  MainModel? main;
  WindModel? wind;
  int? timezone;
  int? id;
  String? name;
  int? cod;
  int? dt;

  OpenWeatherModel({
    required this.weather,
    required this.main,
    required this.wind,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
    required this.dt,
  });

  factory OpenWeatherModel.fromJson(Map<String, dynamic> json) {
    return OpenWeatherModel(
      weather: WeatherModel.fromJson(json['weather'][0]),
      main: MainModel.fromJson(json['main']),
      wind: WindModel.fromJson(json['wind']),
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
      dt: json['dt'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'weather': weather,
      'main': main,
      'wind': wind,
      'timezone': timezone,
      'id': id,
      'name': name,
      'cod': cod,
      'dt': dt,
    };
  }
}
