import 'package:equatable/equatable.dart';
import 'package:weatherapi/src/models/city_weather_data_model.dart';

abstract class WeatherState extends Equatable {
  WeatherState([List props = const []]) : super(props);
}

class WeatherStateEmpty extends WeatherState {
  @override
  String toString() => 'WeatherStateEmpty';
}

class WeatherStateLoading extends WeatherState {
  @override
  String toString() => 'WeatherStateLoading';
}

class WeatherStateSuccess extends WeatherState {
  final CityWeatherDataModel weather;

  WeatherStateSuccess(this.weather) : super([weather]);

  @override
  String toString() => 'WeatherStateSuccess { weather: ${weather.toString()}}';
}

class WeatherStateError extends WeatherState {
  final String error;

  WeatherStateError(this.error) : super([error]);

  @override
  String toString() => 'WeatherStateError';
}
