import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import './current.dart';
import './hourly.dart';
import './daily.dart';

class CityWeatherDataModel {
  var name;
  var lat;
  var lon;
  var timezone;
  var timezone_offset;
  Current current;
  List<Hourly> hourly;
  List<Daily> daily;

  factory CityWeatherDataModel(
      {var name,
      var lat,
      var lon,
      var timezone,
      var timezone_offset,
      Current current,
      List<Hourly> hourly,
      List<Daily> daily}) {
    return _cache.putIfAbsent(
        lat.toString(),
        () => CityWeatherDataModel._internal(
            name, lat, lon, timezone, timezone_offset, current, hourly, daily));
  }

  static final Map<String, CityWeatherDataModel> _cache =
      <String, CityWeatherDataModel>{};

  CityWeatherDataModel._internal(this.name, this.lat, this.lon, this.timezone,
      this.timezone_offset, this.current, this.hourly, this.daily);

  /*
  CityWeatherDataModel(
      {this.name,
      this.lat,
      this.lon,
      this.timezone,
      this.timezone_offset,
      this.current,
      this.hourly,
      this.daily});


  CityWeatherDataModel.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson['name'] != null) {
      name = parsedJson['name'];
    }
    lat = parsedJson['lat'];
    lon = parsedJson['lon'];
    timezone = parsedJson['timezone'];
    timezone_offset = parsedJson['timezone_offset'];
    current = Current.fromJson(parsedJson['current']);
    hourly = new List<Hourly>();
    daily = new List<Daily>();
    for (final item in parsedJson['hourly']) {
      hourly.add(Hourly.fromJson(item));
    }

    for (final item in parsedJson['daily']) {
      daily.add(Daily.fromJson(item));
    }
  }
*/
  factory CityWeatherDataModel.fromJson(Map<String, dynamic> json) {
    return CityWeatherDataModel(
        name: json['name'],
        lat: json['lat'],
        lon: json['lon'],
        timezone: json['timezone'],
        timezone_offset: json['timezone_offset'],
        current: Current.fromJson(json['current']),
        hourly: Hourly.listFromJson(json),
        daily: Daily.listFromJson(json));
  }

  Map<String, dynamic> toJson() => {
        "name": this.name,
        "lat": this.lat,
        "lon": this.lon,
        "timezone": this.timezone,
        "timezone_offset": this.timezone_offset,
        "current": this.current.toJson(),
        "hourly": this.hourly.map((c) => c.toJson()).toList(),
        "daily": this.daily.map((c) => c.toJson()).toList(),
      };

  IconData getIconData() {
    switch (this.current.weather.icon) {
      case '01d':
        return WeatherIcons.day_sunny; //IconData(0xf00d);
      case '01n':
        return WeatherIcons.night_clear; //IconData(0xf02e);
      case '02d':
        return WeatherIcons.day_cloudy; //IconData(0xf002);
      case '02n':
        return WeatherIcons.night_cloudy; //IconData(0xf081);
      case '03d':
        return WeatherIcons.cloud; //IconData(0xf07d);
      case '03n':
        return WeatherIcons.cloud; //IconData(0xf07d);
      case '04d':
        return WeatherIcons.night_partly_cloudy; //IconData(0xf080);
      case '04n':
        return WeatherIcons.night_partly_cloudy; //IconData(0xf080);
      case '09d':
        return WeatherIcons.showers; //IconData(0xf009);
      case '09n':
        return WeatherIcons.showers; //IconData(0xf029);
      case '10d':
        return WeatherIcons.day_rain; //IconData(0xf008);
      case '10n':
        return WeatherIcons.night_rain; //IconData(0xf028);
      case '11d':
        return WeatherIcons.thunderstorm; //IconData(0xf010);
      case '11n':
        return WeatherIcons.thunderstorm; //IconData(0xf03b);
      case '13d':
        return WeatherIcons.snow; //IconData(0xf00a);
      case '13n':
        return WeatherIcons.snow; //IconData(0xf02a);
      case '50d':
        return WeatherIcons.sprinkle; //IconData(0xf003);
      case '50n':
        return WeatherIcons.sprinkle; //IconData(0xf04a);
      default:
        return WeatherIcons.day_sunny; //IconData(0xf00d);
    }
  }

  Color getBackgroundColorMain() {
    switch (this.current.weather.icon) {
      case '01d':
        return Color.fromRGBO(235, 166, 31, 1); //IconData(0xf00d);
      case '01n':
        return Color.fromRGBO(36, 45, 105, 1); //IconData(0xf02e);
      case '02d':
        return Color.fromRGBO(157, 171, 188, 1); //IconData(0xf002);
      case '02n':
        return Color.fromRGBO(157, 171, 188, 1); //IconData(0xf081);
      case '03d':
        return Color.fromRGBO(157, 171, 188, 1); //IconData(0xf07d);
      case '03n':
        return Color.fromRGBO(157, 171, 188, 1); //IconData(0xf07d);
      case '04d':
        return Color.fromRGBO(165, 176, 192, 1); //IconData(0xf080);
      case '04n':
        return Color.fromRGBO(165, 176, 192, 1); //IconData(0xf080);
      case '09d':
        return Color.fromRGBO(61, 110, 186, 1); //IconData(0xf009);
      case '09n':
        return Color.fromRGBO(61, 110, 186, 1); //IconData(0xf029);
      case '10d':
        return Color.fromRGBO(61, 110, 186, 1); //IconData(0xf008);
      case '10n':
        return Color.fromRGBO(61, 110, 186, 1); //IconData(0xf028);
      case '11d':
        return Color.fromRGBO(95, 102, 130, 1); //IconData(0xf010);
      case '11n':
        return Color.fromRGBO(95, 102, 130, 1); //IconData(0xf03b);
      case '13d':
        return Color.fromRGBO(165, 176, 192, 1); //IconData(0xf00a);
      case '13n':
        return Color.fromRGBO(165, 176, 192, 1); //IconData(0xf02a);
      case '50d':
        return Color.fromRGBO(61, 110, 186, 1); //IconData(0xf003);
      case '50n':
        return Color.fromRGBO(61, 110, 186, 1); //IconData(0xf04a);
      default:
        return Color.fromRGBO(235, 166, 31, 1); //IconData(0xf00d);
    }
  }

  Color getBackgroundColorSecondary() {
    switch (this.current.weather.icon) {
      case '01d':
        return Color.fromRGBO(255, 200, 91, 1); //IconData(0xf00d);
      case '01n':
        return Color.fromRGBO(79, 86, 135, 1); //IconData(0xf02e);
      case '02d':
        return Color.fromRGBO(187, 200, 209, 1); //IconData(0xf002);
      case '02n':
        return Color.fromRGBO(187, 200, 209, 1); //IconData(0xf081);
      case '03d':
        return Color.fromRGBO(187, 200, 209, 1); //IconData(0xf07d);
      case '03n':
        return Color.fromRGBO(187, 200, 209, 1); //IconData(0xf07d);
      case '04d':
        return Color.fromRGBO(187, 200, 209, 1); //IconData(0xf080);
      case '04n':
        return Color.fromRGBO(187, 200, 209, 1); //IconData(0xf080);
      case '09d':
        return Color.fromRGBO(99, 139, 199, 1); //IconData(0xf009);
      case '09n':
        return Color.fromRGBO(99, 139, 199, 1); //IconData(0xf029);
      case '10d':
        return Color.fromRGBO(99, 139, 199, 1); //IconData(0xf008);
      case '10n':
        return Color.fromRGBO(99, 139, 199, 1); //IconData(0xf028);
      case '11d':
        return Color.fromRGBO(147, 155, 176, 1); //IconData(0xf010);
      case '11n':
        return Color.fromRGBO(147, 155, 176, 1); //IconData(0xf03b);
      case '13d':
        return Color.fromRGBO(187, 200, 209, 1); //IconData(0xf00a);
      case '13n':
        return Color.fromRGBO(187, 200, 209, 1); //IconData(0xf02a);
      case '50d':
        return Color.fromRGBO(99, 139, 199, 1); //IconData(0xf003);
      case '50n':
        return Color.fromRGBO(99, 139, 199, 1); //IconData(0xf04a);
      default:
        return Color.fromRGBO(255, 200, 91, 1); //IconData(0xf00d);
    }
  }
}
