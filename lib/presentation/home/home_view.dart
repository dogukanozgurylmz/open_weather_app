// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_weather_app/location_helper.dart';

import 'package:open_weather_app/model/main_model.dart';
import 'package:open_weather_app/model/wind_model.dart';

import '../../model/open_weather_model.dart';
import '../../model/weather_model.dart';
import '../../repository/fetch_data.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late FetchData fetchData;
  OpenWeatherModel? openWeatherModel;
  WeatherModel? weatherModel;
  MainModel? mainModel;
  WindModel? windModel;
  late DateTime dt;
  bool isLoading = true;

  Future<void> _fetchData() async {
    openWeatherModel = await fetchData.fetchOpenWeatherData();
    weatherModel = await fetchData.fetchWeatherData();
    mainModel = await fetchData.fetchMainData();
    windModel = await fetchData.fetchWindData();
    dateConvert();
    changeLoading();
  }

  void dateConvert() {
    var weatherDate = openWeatherModel!.dt;
    dt = DateTime.fromMillisecondsSinceEpoch(weatherDate! * 1000);
  }

  void changeLoading() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData = FetchData();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color(0xff02001E),
                  Color(0xff05003F),
                  Color(0xff5b0060),
                ],
                tileMode: TileMode.mirror,
              )),
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WeatherIconWidget(weatherModel: weatherModel!),
                          Text(
                            "${mainModel!.temp!.round()}°",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 112,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                          Text(
                            "${openWeatherModel!.name}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "${weatherModel!.description}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "Humidity",
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 20,
                                ),
                              ),
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: const Color(0xff191731),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(
                                  child: Text(
                                    "%${mainModel!.humidity}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "Wind",
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 20,
                                ),
                              ),
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: const Color(0xff191731),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(
                                  child: Text(
                                    "${windModel!.gust}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "Feels like",
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 20,
                                ),
                              ),
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: const Color(0xff191731),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(
                                  child: Text(
                                    mainModel!.feelsLike != null
                                        ? "${mainModel!.feelsLike!.round()}"
                                        : "yok",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        height: 300,
                        child: FlutterMap(
                          options: MapOptions(
                            center: LatLng(
                                LocationHelper.lat!, LocationHelper.lon!),
                            zoom: 13,
                          ),
                          nonRotatedChildren: [
                            AttributionWidget.defaultWidget(
                              source: 'OpenStreetMap contributors',
                              onSourceTapped: null,
                            ),
                          ],
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.app',
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class DateTempLocWidget extends StatelessWidget {
  const DateTempLocWidget({
    Key? key,
    required this.dt,
    required this.mainModel,
    required this.openWeatherModel,
  }) : super(key: key);

  final DateTime dt;
  final MainModel? mainModel;
  final OpenWeatherModel? openWeatherModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "${mainModel!.temp!.round()}°",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 96,
          ),
        ),
        Row(
          children: [
            const Icon(
              Icons.location_on,
              color: Colors.white,
              size: 20,
            ),
            Text(
              "${openWeatherModel!.name}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class WeatherIconWidget extends StatelessWidget {
  final WeatherModel weatherModel;

  const WeatherIconWidget({
    Key? key,
    required this.weatherModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 90,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: const Color(0xff191731),
          borderRadius: BorderRadius.circular(100),
          boxShadow: const [
            BoxShadow(
              spreadRadius: -10,
              color: Colors.white38,
              blurRadius: 30,
            )
          ]),
      child: Image.network(
        "http://openweathermap.org/img/w/${weatherModel.icon}.png",
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
