import 'dart:convert';

import 'package:open_weather_app/api_url.dart';
import 'package:open_weather_app/model/wind_model.dart';
import 'package:http/http.dart' as http;

abstract class WindDatasourceAbstract {
  Future<WindModel> getWind();
}

class WindDatasource implements WindDatasourceAbstract {
  @override
  Future<WindModel> getWind() async {
    final Uri uri = Uri.parse(ApiUrl.apiUrl);
    final response = await http.get(uri);
    String data = response.body;
    var json = jsonDecode(data);
    WindModel windModel = WindModel(
      speed: json['wind']['speed'],
      deg: json['wind']['deg'],
      gust: json['wind']['gust'],
    );
    if (json == null) {
      throw Exception("Not Data");
    }
    return windModel;
  }
}
