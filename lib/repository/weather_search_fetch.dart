import 'package:open_weather_app/datasources/weather_search_datasource.dart';
import 'package:open_weather_app/model/weather_search_model.dart';

class WeatherSearchFetch {
  List<WeatherSearchModel?>? _weatherSearchList;

  Future<List<WeatherSearchModel?>?> getAll(String api) async {
    WeatherSearchDatasourceImpl weatherSearchDatasourceImpl =
        WeatherSearchDatasourceImpl();
    _weatherSearchList = await weatherSearchDatasourceImpl.getAll(api);
    if (_weatherSearchList == null) {
      throw Exception("Boş");
    }
    return _weatherSearchList;
  }
}
