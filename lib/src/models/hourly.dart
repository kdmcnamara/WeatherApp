import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import './weather.dart';

class Hourly {
  var dt;
  var temp;
  var feels_like;
  var pressure;
  var humidity;
  var dew_point;
  var clouds;
  var visibility;
  var wind_speed;
  var wind_deg;
  Weather weather;
/*
  Hourly(
      {this.dt,
      this.temp,
      this.feels_like,
      this.pressure,
      this.humidity,
      this.dew_point,
      this.clouds,
      this.visibility,
      this.wind_speed,
      this.wind_deg,
      this.weather});
*/

  factory Hourly(
      {var dt,
      var temp,
      var feels_like,
      var pressure,
      var humidity,
      var dew_point,
      var clouds,
      var visibility,
      var wind_speed,
      var wind_deg,
      Weather weather}) {
    return _cache.putIfAbsent(
        temp.toString(),
        () => Hourly._internal(dt, temp, feels_like, pressure, humidity,
            dew_point, clouds, visibility, wind_speed, wind_deg, weather));
  }

  static final Map<String, Hourly> _cache = <String, Hourly>{};

  Hourly._internal(
      this.dt,
      this.temp,
      this.feels_like,
      this.pressure,
      this.humidity,
      this.dew_point,
      this.clouds,
      this.visibility,
      this.wind_speed,
      this.wind_deg,
      this.weather);

  /*
  Hourly.fromJson(Map<String, dynamic> parsedJson) {
    dt = parsedJson['dt'];
    temp = parsedJson['temp'];
    feels_like = parsedJson['feels_like'];
    pressure = parsedJson['pressure'];
    humidity = parsedJson['humidity'];
    dew_point = parsedJson['dew_point'];
    clouds = parsedJson['clouds'];
    visibility = parsedJson['visibility'];
    wind_speed = parsedJson['wind_speed'];
    wind_deg = parsedJson['wind_deg'];
    weather = Weather.fromJson(parsedJson['weather'][0]);
  }
  */

  factory Hourly.fromJson(Map<String, dynamic> json) {
    return Hourly(
        dt: json['dt'],
        temp: json['temp'],
        feels_like: json['feels_like'],
        pressure: json['pressure'],
        humidity: json['humidity'],
        dew_point: json['dew_point'],
        clouds: json['clouds'],
        visibility: json['visibility'],
        wind_speed: json['wind_speed'],
        wind_deg: json['wind_deg'],
        weather: Weather.fromJson(json['weather'][0]));
  }

  static listFromJson(Map<String, dynamic> json) {
    List<Hourly> list = new List<Hourly>();
    for (final item in json['hourly']) {
      Hourly hourly = Hourly.fromJson(item);
      list.add(hourly);
    }
    return list;
  }

  Map<String, dynamic> toJson() => {
        "dt": this.dt,
        "temp": this.temp,
        "feels_like": this.feels_like,
        "pressure": this.pressure,
        "humidity": this.humidity,
        "dew_point": this.dew_point,
        "clouds": this.clouds,
        "visibility": this.visibility,
        "wind_speed": this.wind_speed,
        "wind_deg": this.wind_deg,
        "weather": [this.weather.toJson()],
      };

  IconData getIconData() {
    switch (this.weather.icon) {
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
}
