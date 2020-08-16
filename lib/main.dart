import 'package:flutter/material.dart';
import 'package:sensors_system/ChartScreen.dart';
import 'package:sensors_system/MapScreen.dart';
import 'package:sensors_system/StatisticScreen.dart';
import 'package:sensors_system/customDrawer.dart';
import 'package:sensors_system/informationScreen.dart';
import 'package:sensors_system/customDrawer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('en', 'GB'),
          const Locale('ru', 'RU'),
        ],
      title: 'SensorSystem',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: InformationScreen()
    );
  }
}

