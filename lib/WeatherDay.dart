import 'package:flutter/material.dart';

class WeatherDay extends StatelessWidget {

  final String avgDay;
  final String avgNight;
  final String humidity;
  final String dewPoint;
  final String rain;
  final String description;
  final String icon;
  final double width;

  const WeatherDay({Key key, this.avgDay, this.avgNight, this.humidity, this.dewPoint, this.rain, this.description, this.icon, this.width=50}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('weatherImage/${this.icon}.png', width: width),
        Text(this.description,style: TextStyle(fontSize: 10.0,),textAlign: TextAlign.center,),
        Text(this.avgDay+"°C"),
        Text(this.avgNight+"°C"),
        Text(this.humidity+"%"),
        Text(this.dewPoint+"°C"),
        Text(this.rain+"мм"),
      ],
    );
  }


}