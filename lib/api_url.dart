import 'package:open_weather_app/api_key.dart';
import 'package:open_weather_app/location_helper.dart';

class ApiUrl {
  static String apiUrl =
      "https://api.openweathermap.org/data/2.5/weather?lat=${LocationHelper.lat}&lon=${LocationHelper.lon}&appid=${ApiKey.apiKey}&units=metric&lang=tr";
}
