/// Timeseries chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  static String selectedSensor='';


  TimeSeriesChart(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory TimeSeriesChart.withData() {
    return new TimeSeriesChart(
      _createData(),
      // Disable animations for image tests.
      animate: true,
    );
  }


  @override
  Widget build(BuildContext context) {

    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );


  }


  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createData() {

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: TimeSeriesSales.listForChart,
      )
    ];
  }
}

Widget loadChart(String idSensor){

  TimeSeriesSales.listForChart.clear();
  String parseData = '';

  var parsingNowDate=DateFormat("yyyy-MM-dd").format(new DateTime.now());
  var parsingStartDate=DateFormat("yyyy-MM-dd").format((new DateTime.now().subtract(new Duration(days: 14))));

  print("Начальная дата: $parsingStartDate Конечная дата: $parsingNowDate");

  return FutureBuilder<String>(
    future: fetchHTML(
        'https://datchiki.duckdns.org/parsing/info.php?date_start=$parsingStartDate&date_end=$parsingNowDate&id=$idSensor'),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        parseData = snapshot.data;
        var doc = parse(parseData);

        var numberDate = doc.getElementsByClassName('period').length;



        for (int i = 0; i <= numberDate-1; i++) {
          DateTime date = DateFormat("yyyy-MM-dd").parse(doc.getElementsByClassName("date")[i].text.substring(1));
          TimeSeriesSales.listForChart.add(new TimeSeriesSales(new DateTime(date.year, date.month, date.day),int.parse(doc.getElementsByClassName("data")[i].text)));

        }

        //print("Исходные данные: ${DateFormat("yyyy-MM-dd").format(DateFormat("yyyy-MM-dd").parse(doc.getElementsByClassName("date")[0].text.substring(1)))}");
        //print("Данные ${TimeSeriesSales.listForChart.first.time}");
        //print(TimeSeriesSales.listForChart.length);
        //print(snapshot.data);
        return TimeSeriesChart.withData();
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
  );
}


/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
  static List<TimeSeriesSales> listForChart=[];

}

Future<String> fetchHTML(String url) async {
  final response = await http.get(url);

  if (response.statusCode == 200)
    return response.body;
  else
    throw Exception('Failed');
}




