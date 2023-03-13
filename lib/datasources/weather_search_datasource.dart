import 'dart:convert';

import 'package:open_weather_app/model/weather_search_model.dart';

import 'package:http/http.dart' as http;

abstract class WeatherSearchDatasource {
  Future<List<WeatherSearchModel?>> getAll(String api);
}

class WeatherSearchDatasourceImpl extends WeatherSearchDatasource {
  @override
  Future<List<WeatherSearchModel?>> getAll(String api) async {
    final Uri uri = Uri.parse(api);
    final response = await http.get(uri);
    String data = response.body;
    var json = jsonDecode(data);
    if (json == null) {
      throw Exception("Not Data");
    }
    List<WeatherSearchModel> searchList = [];
    for (var e in json) {
      WeatherSearchModel weatherSearchModel = WeatherSearchModel.fromJson(e);
      searchList.add(weatherSearchModel);
    }
    return searchList;
  }
}
