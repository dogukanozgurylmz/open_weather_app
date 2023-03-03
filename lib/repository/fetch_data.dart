import 'package:open_weather_app/datasources/main_datasource.dart';
import 'package:open_weather_app/datasources/wind_datasource.dart';
import 'package:open_weather_app/model/main_model.dart';
import 'package:open_weather_app/model/open_weather_model.dart';
import 'package:open_weather_app/model/weather_model.dart';
import 'package:open_weather_app/model/wind_model.dart';
import '../datasources/open_weather_datasource.dart';
import '../datasources/weather_datasource.dart';

class FetchData {
  WeatherModel? weatherModel;
  MainModel? mainModel;
  WindModel? windModel;
  OpenWeatherModel? openWeatherModel;

  FetchData({
    this.openWeatherModel,
    this.mainModel,
    this.weatherModel,
    this.windModel,
  });

  Future<WeatherModel?> fetchWeatherData() async {
    WeatherDatasource weatherDatasource = WeatherDatasource();
    weatherModel = await weatherDatasource.getWeather();
    if (weatherModel == null) {
      throw Exception("Boş");
    }
    return weatherModel;
  }

  Future<OpenWeatherModel?> fetchOpenWeatherData() async {
    OpenWeatherDatasource weatherDatasource = OpenWeatherDatasource();
    openWeatherModel = await weatherDatasource.getOpenWeather();
    if (openWeatherModel == null) {
      throw Exception("Boş");
    }
    return openWeatherModel;
  }

  Future<MainModel?> fetchMainData() async {
    MainDatasource mainDatasource = MainDatasource();
    mainModel = await mainDatasource.getMain();
    if (mainModel == null) {
      throw Exception("Boş");
    }
    return mainModel;
  }

  Future<WindModel?> fetchWindData() async {
    WindDatasource windDatasource = WindDatasource();
    windModel = await windDatasource.getWind();
    if (windModel == null) {
      throw Exception("Boş");
    }
    return windModel;
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
