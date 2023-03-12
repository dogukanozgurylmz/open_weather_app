// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_weather_app/location_helper.dart';

import 'package:open_weather_app/model/main_model.dart';
import 'package:open_weather_app/model/wind_model.dart';
import '../../model/weather_model.dart';
import 'cubit/home_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();
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
            child: state.isLoad
                ? SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                WeatherIconWidget(
                                    weatherModel: cubit.weatherModel!),
                                Text(
                                  "${cubit.mainModel!.temp!.round()}°",
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
                                Flexible(
                                  child: Text(
                                    overflow: TextOverflow.fade,
                                    "${cubit.weatherModel!.description}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "${cubit.openWeatherModel!.name}",
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
                            WeatherDetails(
                              mainModel: cubit.mainModel,
                              windModel: cubit.windModel,
                            ),
                            const SizedBox(height: 30),
                            const MapWidget()
                          ],
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
          );
        },
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
