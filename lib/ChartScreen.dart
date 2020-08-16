import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:sensors_system/MapScreen.dart';
import 'package:sensors_system/SelectedChart.dart';
import 'Chart.dart';

import 'customDrawer.dart';


class ChartScreen extends StatefulWidget{

  @override
  ChartScreenState createState() => new ChartScreenState();
}

class ChartScreenState extends State<ChartScreen> {

  List sensors = [];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentSensors;

  @override
  void initState() {
    for (int i = 1; i <= 100; i++) {
      sensors.add(i.toString());
    }
    _dropDownMenuItems = getDropDownMenuItems();
    _currentSensors = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String sensor in sensors) {
      items.add(new DropdownMenuItem(
          value: sensor,
          child: new Text(sensor)
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("График"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text("Отобразить график за последние 14 дней \n\nНомер датчика ",
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: DropdownButton(
              value: _currentSensors,
              items: _dropDownMenuItems,
              onChanged: changedDropDownItem,
            ),
          ),
          Container(
            alignment: Alignment.center,
          child: FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            child: Text(
              "Показать график"
            ), onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SelectedChart(title: '$_currentSensors',)));
          },
          )
        ),
        ],
      ),
      drawer: CustomDrawer(
      ),
    );
  }

  void changedDropDownItem(String selectedSensor) {
    setState(() {
      _currentSensors = selectedSensor;
    });
  }
}

