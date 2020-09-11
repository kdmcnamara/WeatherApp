import 'dart:async';
import 'dart:convert';
import 'package:weatherapi/src/blocs/weather_event.dart';
import 'package:weatherapi/src/blocs/weather_state.dart';
import 'package:weatherapi/src/models/city_weather_data_model.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weatherapi/src/repositories/weather_data_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../prefs/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherDataRepository weatherRepository;
  SharedPrefs pref = SharedPrefs();

  WeatherBloc({@required this.weatherRepository});

  @override
  void onTransition(Transition<WeatherEvent, WeatherState> transition) {
    print(transition.toString());
  }

  @override
  WeatherState get initialState => WeatherStateEmpty();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherState currentState,
    WeatherEvent event,
  ) async* {
    if (event is FetchWeather) {
      final String city = event.city;
      final String lat = event.lat;
      final String lon = event.lon;
      if (lat.isEmpty || lon.isEmpty) {
        yield WeatherStateEmpty();
      } else {
        yield WeatherStateLoading();
        try {
          final result = await weatherRepository.fetchWeather(city, lat, lon);
          yield WeatherStateSuccess(result);
          saveSharedPrefs(result);
        } catch (error) {
          yield WeatherStateError('Error fetching city weather data.');
        }
      }
    }

    if (event is GetWeatherFromPrefs) {
      final weather = event.weather;
      if (weather == null) {
        yield WeatherStateEmpty();
      } else {
        yield WeatherStateLoading();
        try {
          yield WeatherStateSuccess(weather);
          saveSharedPrefs(weather);
        } catch (error) {
          yield WeatherStateError('Error fetching city weather data.');
        }
      }
    }
  }

  saveSharedPrefs(CityWeatherDataModel weather) async {
    final prefs = SharedPrefs();
    try {
      prefs.write('weather', weather.toJson());
    } catch (Excepetion) {
      print('Write on Shared Preferences failed');
    }
  }

  Future<CityWeatherDataModel> loadSharedPrefs() async {
    try {
      final prefs = SharedPrefs();
      CityWeatherDataModel weather = prefs.load('weather');
      return weather;
    } catch (Exception) {
      return null;
    }
  }
}
