class WindModel {
  double? speed;
  int? deg;
  double? gust;

  WindModel({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory WindModel.fromJson(Map<String, dynamic> json) {
    return WindModel(
      speed: json['speed'],
      deg: json['deg'],
      gust: json['gust'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'speed': speed,
      'deg': deg,
      'gust': gust,
    };
  }
}
