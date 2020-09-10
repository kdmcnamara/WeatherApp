import 'package:flutter/material.dart';
import 'package:weatherapi/src/blocs/weather_bloc.dart';
import '../api/api_cities.dart';
import '../api/weather_api.dart';
import '../models/city_weather_data_model.dart';
import 'package:weatherapi/src/blocs/weather_event.dart';

class NavigationBar extends StatefulWidget {
  final WeatherBloc weatherBloc;

  NavigationBar({Key key, this.weatherBloc}) : super(key: key);

  @override
  State<NavigationBar> createState() => NavigationBarState();
}

class NavigationBarState extends State<NavigationBar> {
  WeatherBloc get weatherBloc => widget.weatherBloc;

  int _currentIndex = 0;
  final cities = ['Milwaukee', 'Minneapolis', 'Prescott'];
  ApiCity city = new ApiCity();

  Widget build(context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
          if (index == 0) {
            city.city = ApiCity.Milwaukee;
            city.lat = ApiCity.MilwaukeeLat;
            city.lon = ApiCity.MilwaukeeLon;
          } else if (index == 1) {
            city.city = ApiCity.Minneapolis;
            city.lat = ApiCity.MinneapolisLat;
            city.lon = ApiCity.MinneapolisLon;
          } else if (index == 2) {
            city.city = ApiCity.Prescott;
            city.lat = ApiCity.PrescottLat;
            city.lon = ApiCity.PrescottLon;
          }
          fetchWeather();
        });
      },
      items: cities.map((String destination) {
        return BottomNavigationBarItem(
            icon: Icon(Icons.radio_button_unchecked),
            backgroundColor: Colors.blue,
            title: Text(destination));
      }).toList(),
    );
  }

  void fetchWeather() async {
    weatherBloc
        .dispatch(FetchWeather(city: city.city, lat: city.lat, lon: city.lon));
  }
}
