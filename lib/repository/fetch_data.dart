import 'dart:convert';

import 'package:open_weather_app/api_url.dart';
import 'package:open_weather_app/datasources/main_datasource.dart';
import 'package:open_weather_app/datasources/wind_datasource.dart';
import 'package:open_weather_app/model/main_model.dart';
import 'package:open_weather_app/model/open_weather_model.dart';
import 'package:open_weather_app/model/weather_model.dart';
import 'package:open_weather_app/model/wind_model.dart';

import 'package:http/http.dart' as http;

import '../datasources/open_weather_datasource.dart';
import '../datasources/weather_datasource.dart';

class FetchData {
  late WeatherModel? weatherModel;
  late MainModel? mainModel;
  late WindModel? windModel;
  late OpenWeatherModel? openWeatherModel;

  FetchData({
    this.openWeatherModel,
    this.mainModel,
    this.weatherModel,
    this.windModel,
  });

  Future<void> fetchWeatherData() async {
    WeatherDatasource weatherDatasource = WeatherDatasource();
    weatherModel = await weatherDatasource.getWeather();
  }

  Future<void> fetchOpenWeatherData() async {
    OpenWeatherDatasource weatherDatasource = OpenWeatherDatasource();
    openWeatherModel = await weatherDatasource.getOpenWeather();
  }

  Future<void> fetchMainData() async {
    MainDatasource mainDatasource = MainDatasource();
    mainModel = await mainDatasource.getMain();
  }

  Future<void> fetchWindData() async {
    WindDatasource windDatasource = WindDatasource();
    windModel = await windDatasource.getWind();
  }

  // Future<void> fetchOpenWeatherData() async {
  //   final Uri uri = Uri.parse(ApiUrl.apiUrl);
  //   final response = await http.get(uri);
  //   if (response.statusCode == 200) {
  //     String data = response.body;
  //     var json = jsonDecode(data);
  //     List<WeatherModel>? weather;
  //     // json['weather']
  //     OpenWeatherModel openWeatherModel = OpenWeatherModel(
  //       weather: weather,
  //       main: json['main'],
  //       wind: json['wind'],
  //       timezone: json['timezone'],
  //       id: json['id'],
  //       name: json['name'],
  //       cod: json['cod'],
  //     );
  //     this.openWeatherModel = openWeatherModel;
  //   }
  // }
}
