import 'package:flutter/material.dart';
import 'package:sensors_system/Chart.dart';

class SelectedChart extends StatelessWidget {
  final title;

  SelectedChart({this.title});

  @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('График датчика №$title')),
      body: Center(
          child:loadChart(title)
      )
    );
  }
}