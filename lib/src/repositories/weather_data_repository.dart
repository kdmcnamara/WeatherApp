import 'package:meta/meta.dart';
import '../api/weather_api.dart';
import '../models/city_weather_data_model.dart';

class WeatherDataRepository {
  final WeatherApi weatherApi;

  WeatherDataRepository({@required this.weatherApi})
      : assert(weatherApi != null);

  Future<CityWeatherDataModel> fetchWeather(
      String city, String lat, String lon) async {
    final cityWeatherData = await this.weatherApi.fetchWeather(city, lat, lon);
    return cityWeatherData;
  }
}
