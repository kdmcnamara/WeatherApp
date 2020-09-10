import './temp.dart';
import './feels_like.dart';
import './weather.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class Daily {
  var dt;
  var sunrise;
  var sunset;
  Temp temp;
  FeelsLike feels_like;
  var pressure;
  var humidity;
  var dew_point;
  var wind_speed;
  var wind_deg;
  Weather weather;

  factory Daily(
      {var dt,
      var sunrise,
      var sunset,
      var temp,
      var feels_like,
      var pressure,
      var humidity,
      var dew_point,
      var wind_speed,
      var wind_deg,
      Weather weather}) {
    return _cache.putIfAbsent(
        temp.toString(),
        () => Daily._internal(dt, sunrise, sunset, temp, feels_like, pressure,
            humidity, dew_point, wind_speed, wind_deg, weather));
  }

  static final Map<String, Daily> _cache = <String, Daily>{};

  Daily._internal(
      this.dt,
      this.sunrise,
      this.sunset,
      this.temp,
      this.feels_like,
      this.pressure,
      this.humidity,
      this.dew_point,
      this.wind_speed,
      this.wind_deg,
      this.weather);
/*
  Daily(
      {this.dt,
      this.sunrise,
      this.sunset,
      this.temp,
      this.feels_like,
      this.pressure,
      this.humidity,
      this.dew_point,
      this.wind_speed,
      this.wind_deg,
      this.weather});

  Daily.fromJson(Map<String, dynamic> parsedJson) {
    dt = parsedJson['dt'];
    sunrise = parsedJson['sunrise'];
    sunset = parsedJson['sunset'];
    temp = Temp.fromJson(parsedJson['temp']);
    feels_like = FeelsLike.fromJson(parsedJson['feels_like']);
    pressure = parsedJson['pressure'];
    humidity = parsedJson['humidity'];
    dew_point = parsedJson['dew_point'];
    wind_speed = parsedJson['wind_speed'];
    wind_deg = parsedJson['wind_deg'];
    weather = Weather.fromJson(parsedJson['weather'][0]);
  }
*/

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
        dt: json['dt'],
        sunrise: json['sunrise'],
        sunset: json['sunset'],
        temp: Temp.fromJson(json['temp']),
        feels_like: FeelsLike.fromJson(json['feels_like']),
        pressure: json['pressure'],
        humidity: json['humidity'],
        dew_point: json['dew_point'],
        wind_speed: json['wind_speed'],
        wind_deg: json['wind_deg'],
        weather: Weather.fromJson(json['weather'][0]));
  }
  static listFromJson(Map<String, dynamic> json) {
    List<Daily> list = new List<Daily>();
    for (final item in json['daily']) {
      list.add(Daily.fromJson(item));
    }
    return list;
  }

  Map<String, dynamic> toJson() => {
        "dt": this.dt,
        "sunrise": this.sunrise,
        "sunset": this.sunset,
        "temp": this.temp.toJson(),
        "feels_like": this.feels_like.toJson(),
        "pressure": this.pressure,
        "humidity": this.humidity,
        "dew_point": this.dew_point,
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
