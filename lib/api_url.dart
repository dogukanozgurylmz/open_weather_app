import 'package:open_weather_app/api_key.dart';
import 'package:open_weather_app/location_helper.dart';

class ApiUrl {
  static String apiUrl =
      "https://api.openweathermap.org/data/2.5/weather?lat=${LocationHelper.lat}&lon=${LocationHelper.lon}&appid=${ApiKey.apiKey}&units=metric&lang=tr";

  String apiUrlSearch(String query) {
    if (query.isNotEmpty) {
      String apiUrlSearch =
          "https://api.openweathermap.org/geo/1.0/direct?q=$query&limit=5&appid=${ApiKey.apiKey}";
      return apiUrlSearch;
    }
    String apiUrlSearch =
        "https://api.openweathermap.org/geo/1.0/direct?q=*&limit=5&appid=${ApiKey.apiKey}";
    return apiUrlSearch;
  }
}
