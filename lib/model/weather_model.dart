class WeatherModel {
  int? id;
  String? main;
  String? description;
  String? icon;

  WeatherModel({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }
}
