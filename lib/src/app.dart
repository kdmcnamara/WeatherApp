import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'models/city_weather_data_model.dart';
import 'dart:convert';
import 'screens/home_screen.dart';

class App extends StatefulWidget {
  createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int counter = 0;
  CityWeatherDataModel cityData;

  void fetchWeather() async {
    var res = await get(
        'http://api.openweathermap.org/data/2.5/weather?id=5263045&appid=ac771b64efb985eaa8cdbe2e59cf74ee');
    var cityWeatherDataModel =
        CityWeatherDataModel.fromJson(json.decode(res.body));
    setState(() {
      cityData = cityWeatherDataModel;
    });
  }

  Widget build(context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
