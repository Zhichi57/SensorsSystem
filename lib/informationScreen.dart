import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

import 'customDrawer.dart';
import 'GeoSensors.dart';
import 'Weather.dart';

class InformationScreen extends StatefulWidget{

  @override
  InformationScreenState createState() => new InformationScreenState();
}

class InformationScreenState extends State<InformationScreen>{

  static final url='https://datchiki.duckdns.org/parsing/info.php';

    String parseData='';

  Future<String> fetchHTML(String url) async {
    final response = await http.get(url);

    if (response.statusCode == 200)
      return response.body;
    else throw Exception('Failed');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Информация"),
      ),
      body: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           FutureBuilder<String>(
             future: fetchHTML('https://datchiki.duckdns.org/parsing/info.php'),
             builder: (context, snapshot){
               if (snapshot.hasData) {
                 //Your downloaded page
                 parseData = snapshot.data;
                 var doc=parse(parseData);
                 var location;
                 var data;
                 var numberGeo = doc.getElementsByClassName('geo').length;

                  for (int i = 0; i <= numberGeo-1; i++) {
                     location = doc
                        .getElementsByClassName('location')[i]
                        .text
                        .substring(1);

                     data=doc.getElementsByClassName('data_loc')[i].text.substring(1);

                    var latitude = double.parse(location.substring(0, 10));
                    var longitude = double.parse(location.substring(11));

                    if (geoList.length<=numberGeo-1) {
                      geoList.add(new LatLng(latitude, longitude));
                      geoData.add(data);
                    }
                  }

          
                 var parsingLastDate = doc.getElementsByClassName('last_data')[0].text.substring(5);
                 var lastDate=DateFormat("yyyy-MM-dd").parse(parsingLastDate);
                 var formattedLastDate=DateFormat("dd.MM.yyyy").format(lastDate);

                 var parsingNumber=doc.getElementsByClassName('number')[0].text.substring(5);

                // print(snapshot.data);

                 var listAvgTempDay=List<String>();
                var listAvgTempNight=List<String>();
                var listHumidity=List<String>();
                var listDewPoint=List<String>();
                var listRain=List<String>();
                var listWeatherDescription=List<String>();
                var listWeatherIcon=List<String>();


                for (int i=0;i<=7; i++){
                   listAvgTempDay.add(doc.getElementsByClassName('daily_temp_day')[i].text);
                   listAvgTempNight.add(doc.getElementsByClassName('daily_temp_night')[i].text);
                   listHumidity.add(doc.getElementsByClassName('daily_humidity')[i].text);
                   listDewPoint.add(doc.getElementsByClassName('daily_dew_point')[i].text);
                   listRain.add(doc.getElementsByClassName('daily_rain')[i].text);
                   listWeatherDescription.add(doc.getElementsByClassName('daily_weather_description')[i].text[0].toUpperCase()+
                       doc.getElementsByClassName('daily_weather_description')[i].text.replaceAll(" ", "\n").substring(1));
                   listWeatherIcon.add(doc.getElementsByClassName('daily_weather_icon')[i].text);
                 }


                 return Column(
                   children: [
                     Text ("Колличсество всех показаний: $parsingNumber \n Дата последнего снятия показаний: $formattedLastDate", textAlign: TextAlign.center),
                     Divider(height: 20,),
                     Weather(listAvgTempDay: listAvgTempDay,listAvgTempNight: listAvgTempNight,listHumidity:
                 listHumidity,listDewPoint: listDewPoint,listRain: listRain,
                     listWeatherIcon: listWeatherIcon,listWeatherMain: listWeatherDescription)
                   ],
                 );
               }
               else if (snapshot.hasError)
                 return Text('Ошибка загрузки');

               return Container(
                 child: SizedBox(
                   child: CircularProgressIndicator(),
                   width: 60,
                   height: 60,
                 ),
               );
             },
           ),
         ],
       ),
      ),
      drawer: CustomDrawer(
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

  }

}

