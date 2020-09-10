import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapi/src/blocs/weather_bloc.dart';
import 'package:flutter/material.dart';
import '../blocs/weather_event.dart';
import '../blocs/weather_state.dart';
import '../widgets/weather_result.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/city_weather_data_model.dart';
import '../prefs/shared_preferences.dart';

class WeatherWidget extends StatelessWidget {
  final WeatherBloc weatherBloc;

  const WeatherWidget({Key key, this.weatherBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherEvent, WeatherState>(
      bloc: weatherBloc,
      builder: (context, WeatherState state) {
        if (state is WeatherStateEmpty) {
          return Center(
            child: Text(
              'No weather data to display.',
              style: GoogleFonts.lato(
                textStyle: TextStyle(color: Colors.black, letterSpacing: .5),
              ),
            ),
          );
        }
        if (state is WeatherStateError) {
          return Text(state.error);
        }
        if (state is WeatherStateLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is WeatherStateSuccess) {
          return WeatherResult(weather: state.weather);
        }
      },
    );
  }

  CityWeatherDataModel loadSharedPrefs() {
    try {
      print('START');
      final prefs = SharedPrefs();
      CityWeatherDataModel weather = prefs.load('weather');
      return weather;
    } catch (Exception) {
      return null;
    }
  }
}
