class WeatherSearchModel {
  String? name;
  double? lat;
  double? lon;
  String? country;
  String? state;

  WeatherSearchModel({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
    required this.state,
  });

  factory WeatherSearchModel.fromJson(Map<String, dynamic> json) {
    return WeatherSearchModel(
      name: json['name'],
      lat: json['lat'],
      lon: json['lon'],
      country: json['country'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['lat'] = lat;
    data['lon'] = lon;
    data['country'] = country;
    data['state'] = state;
    return data;
  }
}
