import 'package:open_weather_app/model/open_weather_model.dart';
import 'package:open_weather_app/repository/base_repository.dart';

import '../datasources/open_weather_datasource.dart';

class OpenWeatherFetch extends BaseRepository<OpenWeatherModel> {
  OpenWeatherModel? _openWeatherModel;

  @override
  Future<OpenWeatherModel?> fetchData() async {
    OpenWeatherDatasource weatherDatasource = OpenWeatherDatasource();
    _openWeatherModel = await weatherDatasource.getOpenWeather();
    if (_openWeatherModel == null) {
      throw Exception("Boş");
    }
    return _openWeatherModel;
  }
}
