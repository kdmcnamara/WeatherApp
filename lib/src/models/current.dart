import './weather.dart';

class Current {
  var dt;
  var sunrise;
  var sunset;
  var temp;
  var feels_like;
  var pressure;
  var humidity;
  var dew_point;
  var uvi;
  var clouds;
  var visibility;
  var wind_speed;
  var wind_deg;
  Weather weather;

  factory Current(
      {var dt,
      var sunrise,
      var sunset,
      var temp,
      var feels_like,
      var pressure,
      var humidity,
      var dew_point,
      var uvi,
      var clouds,
      var visibility,
      var wind_speed,
      var wind_deg,
      Weather weather}) {
    return _cache.putIfAbsent(
        temp.toString(),
        () => Current._internal(
            dt: dt,
            sunrise: sunrise,
            sunset: sunset,
            temp: temp,
            feels_like: feels_like,
            pressure: pressure,
            humidity: humidity,
            dew_point: dew_point,
            uvi: uvi,
            clouds: clouds,
            visibility: visibility,
            wind_speed: wind_speed,
            wind_deg: wind_deg,
            weather: weather));
  }

  static final Map<String, Current> _cache = <String, Current>{};

  Current._internal(
      {this.dt,
      this.sunrise,
      this.sunset,
      this.temp,
      this.feels_like,
      this.pressure,
      this.humidity,
      this.dew_point,
      this.uvi,
      this.clouds,
      this.visibility,
      this.wind_speed,
      this.wind_deg,
      this.weather});
/*
  Current(
      {this.dt,
      this.sunrise,
      this.sunset,
      this.temp,
      this.feels_like,
      this.pressure,
      this.humidity,
      this.dew_point,
      this.uvi,
      this.clouds,
      this.visibility,
      this.wind_speed,
      this.wind_deg,
      this.weather});


  Current.fromJson(Map<String, dynamic> parsedJson) {
    dt = parsedJson['dt'];
    sunrise = parsedJson['sunrise'];
    sunset = parsedJson['sunset'];
    temp = parsedJson['temp'];
    feels_like = parsedJson['feels_like'];
    pressure = parsedJson['pressure'];
    humidity = parsedJson['humidity'];
    dew_point = parsedJson['dew_point'];
    uvi = parsedJson['uvi'];
    clouds = parsedJson['clouds'];
    visibility = parsedJson['visibility'];
    wind_speed = parsedJson['wind_speed'];
    wind_deg = parsedJson['wind_deg'];
    weather = Weather.fromJson(parsedJson['weather'][0]);
  }
*/

  factory Current.fromJson(Map<String, dynamic> json) {
    print('beforeCurr');
    return Current(
        dt: json['dt'],
        sunrise: json['sunrise'],
        sunset: json['sunset'],
        temp: json['temp'],
        feels_like: json['feels_like'],
        pressure: json['pressure'],
        humidity: json['humidity'],
        dew_point: json['dew_point'],
        wind_speed: json['wind_speed'],
        wind_deg: json['wind_deg'],
        weather: Weather.fromJson(json['weather'][0]));
  }

  Map<String, dynamic> toJson() => {
        "dt": this.dt,
        "sunrise": this.sunrise,
        "sunset": this.sunset,
        "temp": this.temp,
        "feels_like": this.sunset,
        "pressure": this.pressure,
        "humidity": this.humidity,
        "dew_point": this.dew_point,
        "uvi": this.uvi,
        "clouds": this.clouds,
        "visibility": this.visibility,
        "wind_speed": this.wind_speed,
        "wind_deg": this.wind_deg,
        "weather": [this.weather.toJson()],
      };
}
