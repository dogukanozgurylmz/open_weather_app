import 'package:open_weather_app/model/main_model.dart';
import 'package:open_weather_app/repository/base_repository.dart';

import '../datasources/main_datasource.dart';

class MainFetch extends BaseRepository<MainModel> {
  MainModel? _mainModel;

  @override
  Future<MainModel?> fetchData() async {
    MainDatasource mainDatasource = MainDatasource();
    _mainModel = await mainDatasource.getMain();
    if (_mainModel == null) {
      throw Exception("Boş");
    }
    return _mainModel;
  }
}
