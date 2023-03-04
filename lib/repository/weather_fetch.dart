import 'package:open_weather_app/model/weather_model.dart';
import 'package:open_weather_app/repository/base_repository.dart';

import '../datasources/weather_datasource.dart';

class WeatherFetch extends BaseRepository<WeatherModel> {
  WeatherModel? _weatherModel;

  @override
  Future<WeatherModel?> fetchData() async {
    WeatherDatasource weatherDatasource = WeatherDatasource();
    _weatherModel = await weatherDatasource.getWeather();
    if (_weatherModel == null) {
      throw Exception("Boş");
    }
    return _weatherModel;
  }
}
