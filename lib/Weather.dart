import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sensors_system/WeatherDay.dart';

class Weather extends StatelessWidget {

  final List<String> listAvgTempDay;
  final List<String> listAvgTempNight;
  final List<String> listHumidity;
  final List<String> listDewPoint;
  final List<String> listRain;
  final List<String> listWeatherMain;
  final List<String> listWeatherIcon;

  const Weather({Key key, this.listAvgTempDay, this.listAvgTempNight, this.listHumidity, this.listDewPoint, this.listRain, this.listWeatherMain, this.listWeatherIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WeatherDay(avgDay: listAvgTempDay[0],avgNight: listAvgTempNight[0],rain: listRain[0],description: listWeatherMain[0],dewPoint: listDewPoint[0],humidity: listHumidity[0],icon: listWeatherIcon[0],width: 100),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WeatherDay(avgDay: listAvgTempDay[1],avgNight: listAvgTempNight[1],rain: listRain[1],description: listWeatherMain[1],dewPoint: listDewPoint[1],humidity: listHumidity[1],icon: listWeatherIcon[1]),
              WeatherDay(avgDay: listAvgTempDay[2],avgNight: listAvgTempNight[2],rain: listRain[2],description: listWeatherMain[2],dewPoint: listDewPoint[2],humidity: listHumidity[2],icon: listWeatherIcon[2]),
              WeatherDay(avgDay: listAvgTempDay[3],avgNight: listAvgTempNight[3],rain: listRain[3],description: listWeatherMain[3],dewPoint: listDewPoint[3],humidity: listHumidity[3],icon: listWeatherIcon[3]),
              WeatherDay(avgDay: listAvgTempDay[4],avgNight: listAvgTempNight[4],rain: listRain[4],description: listWeatherMain[4],dewPoint: listDewPoint[4],humidity: listHumidity[4],icon: listWeatherIcon[4]),
              WeatherDay(avgDay: listAvgTempDay[5],avgNight: listAvgTempNight[5],rain: listRain[5],description: listWeatherMain[5],dewPoint: listDewPoint[5],humidity: listHumidity[5],icon: listWeatherIcon[5]),
              WeatherDay(avgDay: listAvgTempDay[6],avgNight: listAvgTempNight[6],rain: listRain[6],description: listWeatherMain[6],dewPoint: listDewPoint[6],humidity: listHumidity[6],icon: listWeatherIcon[6]),
              WeatherDay(avgDay: listAvgTempDay[7],avgNight: listAvgTempNight[7],rain: listRain[7],description: listWeatherMain[7],dewPoint: listDewPoint[7],humidity: listHumidity[7],icon: listWeatherIcon[7]),
        ]),
      ],
    );
  }
}
