import '../models/city_weather_data_model.dart';
import 'dart:convert';
import 'api_keys.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class WeatherApi {
  static String owmUrl = 'http://api.openweathermap.org';
  final Dio dio;

  WeatherApi({@required this.dio}) : assert(dio != null);

  Future<CityWeatherDataModel> fetchWeather(
      String city, String lat, String lon) async {
    Response res;
    res = await this.dio.get(
        '$owmUrl/data/2.5/onecall?lat=$lat&lon=$lon&appid=${ApiKey.OPEN_WEATHER_MAP}');
    final cityWeatherDataModel = CityWeatherDataModel.fromJson(res.data);
    cityWeatherDataModel.name = city;
    if (res.statusCode != 200) {
      throw Exception("unable to fetch weather data");
    }

    return cityWeatherDataModel;
  }
}
