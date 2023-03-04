// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_weather_app/location_helper.dart';

import 'package:open_weather_app/model/main_model.dart';
import 'package:open_weather_app/model/wind_model.dart';
import 'package:open_weather_app/repository/main_fetch.dart';
import 'package:open_weather_app/repository/openweather_fetch.dart';
import 'package:open_weather_app/repository/weather_fetch.dart';
import 'package:open_weather_app/repository/wind_fetch.dart';

import '../../model/open_weather_model.dart';
import '../../model/weather_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late WeatherFetch weatherFetch;
  late MainFetch mainFetch;
  late OpenWeatherFetch openWeatherFetch;
  late WindFetch windFetch;
  OpenWeatherModel? openWeatherModel;
  WeatherModel? weatherModel;
  MainModel? mainModel;
  WindModel? windModel;
  late DateTime dt;
  bool isLoading = true;

  Future<void> _fetchData() async {
    weatherModel = await weatherFetch.fetchData();
    openWeatherModel = await openWeatherFetch.fetchData();
    mainModel = await mainFetch.fetchData();
    windModel = await windFetch.fetchData();
    changeLoading();
  }

  void changeLoading() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    weatherFetch = WeatherFetch();
    openWeatherFetch = OpenWeatherFetch();
    mainFetch = MainFetch();
    windFetch = WindFetch();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : PageView(
              children: [
                HomePage(
                  weatherModel: weatherModel,
                  mainModel: mainModel,
                  openWeatherModel: openWeatherModel,
                  windModel: windModel,
                ),
                HomePage(
                  weatherModel: weatherModel,
                  mainModel: mainModel,
                  openWeatherModel: openWeatherModel,
                  windModel: windModel,
                ),
              ],
            ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.weatherModel,
    required this.mainModel,
    required this.openWeatherModel,
    required this.windModel,
  });

  final WeatherModel? weatherModel;
  final MainModel? mainModel;
  final OpenWeatherModel? openWeatherModel;
  final WindModel? windModel;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
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
                    // const Spacer(),
                    Flexible(
                      child: Text(
                        overflow: TextOverflow.fade,
                        "${weatherModel!.description}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "${openWeatherModel!.name}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    const Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                WeatherDetails(mainModel: mainModel, windModel: windModel),
                const SizedBox(height: 30),
                const MapWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({
    super.key,
    required this.mainModel,
    required this.windModel,
  });

  final MainModel? mainModel;
  final WindModel? windModel;

  @override
  Widget build(BuildContext context) {
    return Row(
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
                  "${windModel!.gust ?? "yok"}",
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
    );
  }
}

class MapWidget extends StatelessWidget {
  const MapWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 50,
            color: Colors.black38,
            spreadRadius: 0,
          ),
        ],
      ),
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(LocationHelper.lat!, LocationHelper.lon!),
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
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
        ],
      ),
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
