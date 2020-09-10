import 'package:flutter/material.dart';
import 'package:weatherapi/src/models/city_weather_data_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../prefs/shared_preferences.dart';

class WeatherResult extends StatelessWidget {
  CityWeatherDataModel weather;
  SharedPrefs prefs = SharedPrefs();

  WeatherResult({Key key, this.weather}) : super(key: key);

  @override
  Widget build(context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE d MMM').format(now);
    return Container(
      color: weather.getBackgroundColorMain(),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    formattedDate,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${weather.name}',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      color: Colors.white, letterSpacing: .5, fontSize: 22),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(50, 0, 20, 0),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Text(
                      '${fromK(weather.current.temp)}\u00B0',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            color: Colors.white,
                            letterSpacing: .5,
                            fontSize: 32),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(25, 5, 5, 5),
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.keyboard_arrow_up,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(25, 5, 5, 5),
                        padding: EdgeInsets.all(5),
                        child: Text(
                          '${fromK(weather.daily[0].temp.min)}\u00B0',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        padding: EdgeInsets.all(5),
                        child: Text(
                          '${fromK(weather.daily[0].temp.max)}\u00B0',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 125,
                    height: 125,
                    margin: EdgeInsets.fromLTRB(75, 20, 20, 20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 2, color: Colors.white),
                      color: weather.getBackgroundColorSecondary(),
                    ),
                    child: Icon(
                      weather.getIconData(),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            color: weather.getBackgroundColorSecondary(),
            height: 1,
            thickness: 0.5,
            indent: 10,
            endIndent: 10,
          ),
          Container(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: this.weather.hourly.length,
              separatorBuilder: (context, index) => Divider(
                height: 100,
                color: Colors.white,
              ),
              padding: EdgeInsets.only(left: 10, right: 10),
              itemBuilder: (context, index) {
                final item = this.weather.hourly[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Text(
                            DateFormat('ha').format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    item.dt * 1000)),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Icon(
                            item.getIconData(),
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(7, 0, 0, 0),
                          child: Text(
                            '${fromK(item.temp)}\u00B0',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(
            color: weather.getBackgroundColorSecondary(),
            height: 1,
            thickness: 0.5,
            indent: 10,
            endIndent: 10,
          ),
          Expanded(
              child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: this.weather.daily.length,
            itemBuilder: (context, index) {
              final item = this.weather.daily[index];
              return Container(
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        DateFormat('EE').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                item.dt * 1000)),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(
                        item.getIconData(),
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 100, top: 10),
                      child: Text(
                        '${fromK(item.temp.day)}\u00B0',
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            '${fromK(item.temp.min)}\u00B0',
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10.0,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          child: Text(
                            '${fromK(item.temp.max)}\u00B0',
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10.0,
                                color: Colors.white),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ))
        ],
      ),
    );
  }

  fromK(k) {
    return (1.8 * (k - 273) + 32).round();
  }

  loadSharedPrefs() async {
    try {
      this.weather = CityWeatherDataModel.fromJson(await prefs.load('weather'));
    } catch (Excepetion) {}
  }
}
