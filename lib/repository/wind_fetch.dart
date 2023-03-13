import 'package:open_weather_app/model/wind_model.dart';
import 'package:open_weather_app/repository/base_repository.dart';

import '../datasources/wind_datasource.dart';

class WindFetch extends BaseRepository<WindModel> {
  WindModel? _windModel;

  @override
  Future<WindModel?> fetchData(String api) async {
    WindDatasourceImpl windDatasource = WindDatasourceImpl();
    _windModel = await windDatasource.getWind(api);
    if (_windModel == null) {
      throw Exception("Boş");
    }
    return _windModel;
  }
}
