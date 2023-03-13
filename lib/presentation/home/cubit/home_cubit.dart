import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:open_weather_app/api_url.dart';

import '../../../model/main_model.dart';
import '../../../model/open_weather_model.dart';
import '../../../model/weather_model.dart';
import '../../../model/wind_model.dart';
import '../../../repository/main_fetch.dart';
import '../../../repository/openweather_fetch.dart';
import '../../../repository/weather_fetch.dart';
import '../../../repository/wind_fetch.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(const HomeState(
          isLoad: false,
        )) {
    init();
  }

  OpenWeatherModel? openWeatherModel;
  WeatherModel? weatherModel;
  MainModel? mainModel;
  WindModel? windModel;

  Future<void> fetchWeather() async {
    WeatherFetch weatherFetch = WeatherFetch();
    weatherModel = await weatherFetch.fetchData(ApiUrl.apiUrl);
  }

  Future<void> fetchOpenWeather() async {
    OpenWeatherFetch openWeatherFetch = OpenWeatherFetch();
    openWeatherModel = await openWeatherFetch.fetchData(ApiUrl.apiUrl);
  }

  Future<void> fetchWind() async {
    WindFetch windFetch = WindFetch();
    windModel = await windFetch.fetchData(ApiUrl.apiUrl);
  }

  Future<void> fetchMain() async {
    MainFetch mainFetch = MainFetch();
    mainModel = await mainFetch.fetchData(ApiUrl.apiUrl);
  }

  Future<void> init() async {
    emit(state.copyWith(isLoad: false));
    await fetchMain();
    await fetchOpenWeather();
    await fetchWeather();
    await fetchWind();
    emit(state.copyWith(isLoad: true));
  }
}
