import 'package:equatable/equatable.dart';
import 'package:weatherapi/src/models/city_weather_data_model.dart';

abstract class WeatherEvent extends Equatable {
  WeatherEvent([List props = const []]) : super(props);
}

class FetchWeather extends WeatherEvent {
  final String city;
  final String lat;
  final String lon;

  FetchWeather({this.city, this.lat, this.lon})
      : assert(city != null),
        assert(lat != null),
        assert(lon != null),
        super([lat, lon]);
}

class GetWeatherFromPrefs extends WeatherEvent {
  final CityWeatherDataModel weather;

  GetWeatherFromPrefs({this.weather})
      : assert(weather != null),
        super([weather]);
}
