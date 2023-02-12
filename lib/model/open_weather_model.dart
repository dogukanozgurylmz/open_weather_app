class OpenWeatherModel {
  Map<String, dynamic>? weather;
  Map<String, dynamic>? main;
  Map<String, dynamic>? wind;
  int? timezone;
  int? id;
  String? name;
  int? cod;

  OpenWeatherModel({
    required this.weather,
    required this.main,
    required this.wind,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  OpenWeatherModel.fromJson(Map<String, dynamic> json) {
    weather = json['weather'];
    main = json['main'];
    wind = json['wind'];
    timezone = json['timezone'];
    id = json['id'];
    name = json['name'];
    cod = json['cod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (weather != null) {
      data['weather'] = weather!;
    }
    if (main != null) {
      data['main'] = main!;
    }
    if (wind != null) {
      data['wind'] = wind!;
    }
    data['timezone'] = timezone;
    data['id'] = id;
    data['name'] = name;
    data['cod'] = cod;
    return data;
  }
}
