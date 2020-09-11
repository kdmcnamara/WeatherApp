import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapi/src/blocs/weather_bloc.dart';
import 'package:weatherapi/src/blocs/weather_event.dart';
import 'package:weatherapi/src/repositories/weather_data_repository.dart';
import '../models/city_weather_data_model.dart';
import 'package:google_fonts/google_fonts.dart';
import '../api/weather_api.dart';
import '../api/api_keys.dart';
import '../api/api_cities.dart';
import 'package:dio/dio.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/weather_widget.dart';
import '../prefs/shared_preferences.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  final WeatherDataRepository weatherRepository =
      WeatherDataRepository(weatherApi: WeatherApi(dio: new Dio()));

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  SharedPrefs prefs = SharedPrefs();
  WeatherBloc weatherBloc;
  int _currentIndex = 0;
  CityWeatherDataModel cityData;
  List<CityWeatherDataModel> cityDataForecastHourly;
  List<CityWeatherDataModel> cityDataForecastDaily;
  final cities = ['Milwaukee', 'Minneapolis', 'Prescott'];
  ApiCity city = new ApiCity();

  @override
  void initState() {
    super.initState();
    weatherBloc = WeatherBloc(weatherRepository: widget.weatherRepository);
    loadSharedPrefs();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: WeatherWidget(weatherBloc: this.weatherBloc), //container,
      appBar: AppBar(
        backgroundColor: Color(0xE5E5E5),
        elevation: 0.0,
        title: Text(
          'Weather Forecast',
          style: GoogleFonts.lato(
            textStyle: TextStyle(color: Colors.black, letterSpacing: .5),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        weatherBloc: this.weatherBloc,
      ),
    );
  }

  void fetchWeather() async {
    weatherBloc
        .dispatch(FetchWeather(city: city.city, lat: city.lat, lon: city.lon));
  }

  void loadSharedPrefs() async {
    try {
      final prefs = SharedPrefs();
      CityWeatherDataModel weather =
          CityWeatherDataModel.fromJson(await prefs.load('weather'));

      // Get previously stored weather
      //weatherBloc.dispatch(GetWeatherFromPrefs(weather: weather));

      // Use persisted data to get current weather of last viewed city
      weatherBloc.dispatch(FetchWeather(
          city: weather.name.toString(),
          lat: weather.lat.toString(),
          lon: weather.lon.toString()));
    } catch (Exception) {
      return null;
    }
  }
}
