import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:sensors_system/DayStatistic.dart';
import 'package:intl/intl.dart';
import 'package:sensors_system/SensorStatistic.dart';

import 'customDrawer.dart';

class StatisticScreen extends StatefulWidget {
  StatisticScreenState createState() => new StatisticScreenState();
}

class StatisticScreenState extends State<StatisticScreen> {
  List sensors = [];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentSensors;

  var finalDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Статиcтика"),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              alignment: Alignment.center,
              child: FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                child: Text("Выбрать день для отчёта"),
                onPressed: () {
                  callDatePicker();
                },
              )),
          Container(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  alignment: Alignment.center,
                  child: FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    child: Text("Отобразить статистику"),
                    onPressed: () {
                      selectSensor(context);
                    },
                  ))
            ]),
          )
        ]),
      ),
      drawer: CustomDrawer(),
    );
  }

  @override
  void initState() {
    for (int i = 1; i <= 100; i++) {
      sensors.add(i.toString());
    }
    _dropDownMenuItems = getDropDownMenuItems();
    _currentSensors = _dropDownMenuItems[0].value;
    super.initState();
  }

  void callDatePicker() async {
    var selectedDate = await getDate(context);
    setState(() {
      finalDate = selectedDate;
      var formattedTitleDate = DateFormat("dd.MM.yyyy").format(finalDate);
      var formattedDate = DateFormat("yyyy-MM-dd").format(finalDate);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DayStatistic(
                    title: formattedTitleDate,
                    date: formattedDate,
                  )));
    });
  }

  Future<DateTime> getDate(BuildContext context) {
    return showRoundedDatePicker(
      context: context,
      // customWeekDays: ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"],
      locale: const Locale('ru', 'RU'),
      era: EraMode.CHRIST_YEAR,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      borderRadius: 16,
    );
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String sensor in sensors) {
      items.add(new DropdownMenuItem(value: sensor, child: new Text(sensor)));
    }
    return items;
  }

  void changedDropDownItem(String selectedSensor) {

    setState(() {
      _currentSensors = selectedSensor;
    });
  }

  Future<void> selectSensor(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text('Выбрать номер датчика'),
              content:
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 40,
                  child:
                  DropdownButton(
                    value: _currentSensors,
                    items: _dropDownMenuItems,
                    onChanged: (selectedSensor)
                    {
                      setState(() {
                        _currentSensors = selectedSensor;
                      });
                    },
                  ),
                ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ок'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SensorStatistic(
                              title: _currentSensors,
                              idSensor: _currentSensors,
                            )));
                    print(_currentSensors);
                  },
                ),
              ],
            );
          });
        });
  }


}
