import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class SensorStatistic extends StatefulWidget {
  final title;
  final idSensor;

  const SensorStatistic({Key key, this.title, this.idSensor}) : super(key: key);

  SensorStatisticState createState() => new SensorStatisticState();
}

class SensorStatisticState extends State<SensorStatistic> {

  String parseData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Статиcтика по датчику №${widget.title}"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: FutureBuilder<String>(
            future: fetchHTML(
                'https://datchiki.duckdns.org/parsing/info.php?stat_id=${widget.idSensor}'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                parseData = snapshot.data;
                var doc = parse(parseData);

                var numberSensors = doc.getElementsByClassName('stat_id').length;

                if (numberSensors == 0) {
                  Sensors.listSensors
                      .add(new Sensors(date: "Нет данных", data: "Нет данных"));
                }

                var formattedDate='';

                for (int i = 0; i <= numberSensors - 1; i++) {
                  Sensors.listSensors.add(new Sensors(
                      date: formattedDate=DateFormat("dd.MM.yyyy").format(DateFormat("yyyy-MM-dd").parse(doc.getElementsByClassName("date")[i].text)),
                      data: doc.getElementsByClassName("data")[i].text));
                }

                print(Sensors.listSensors.length);
                //print(snapshot.data);
                return DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                        label: Text(
                          "Дата",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        )),
                    DataColumn(
                        label: Text(
                          "Показание",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        )),
                  ],
                  rows: Sensors.listSensors
                      .map((sen) => DataRow(cells: [
                    DataCell(
                      Text(sen.date),
                    ),
                    DataCell(
                      Text(sen.data),
                    ),
                  ]))
                      .toList(),
                );
              } else if (snapshot.hasError) return Text('Ошибка загрузки');

              return Container(
                margin: new EdgeInsets.all(100.0),
                alignment: Alignment.center,
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Sensors.listSensors.clear();
    super.dispose();
  }

  Future<String> fetchHTML(String url) async {
    final response = await http.get(url);

    if (response.statusCode == 200)
      return response.body;
    else
      throw Exception('Failed');
  }
}

class Sensors {
  String date;
  String data;

  Sensors({this.date, this.data});
  static List<Sensors> listSensors = [];
}

