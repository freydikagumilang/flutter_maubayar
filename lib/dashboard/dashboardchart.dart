import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:maubayar/fintness_app_theme.dart';

class AllChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: ListView(
        // This next line does the trick.
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          DashboardChart(),
          ItemPieChart(),
        ],
      ),
    );
  }
}

class DashboardChart extends StatefulWidget {
  @override
  _DashboardChartState createState() => _DashboardChartState();
}

class _DashboardChartState extends State<DashboardChart> {
  @override
  Widget build(BuildContext context) {
    var data = [
      SalesData("21 Oct", 40000.0, Colors.tealAccent[700]),
      SalesData("22 Oct", 25000.0, Colors.red),
      SalesData("23 Oct", 19000.0, Colors.red),
      SalesData("24 Oct", 35000.0, Colors.amber),
      SalesData("25 Oct", 70000.0, Colors.tealAccent[700]),
      SalesData("26 Oct", 50000.0, Colors.amber),
      SalesData("27 Oct", 99000.0, Colors.tealAccent[700])
    ];

    var series = [
      charts.Series(
          domainFn: (SalesData sales, _) => sales.date,
          measureFn: (SalesData sales, _) => sales.amount,
          colorFn: (SalesData sales, _) => sales.clr,
          id: 'lastweek',
          data: data)
    ];

    var mychart = charts.BarChart(series);
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Card(
          color: FitnessAppTheme.white,
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 8, 0, 8),
            child: Column(
              children: <Widget>[
                new Text(
                  "Penjualan 7 Hari",
                  style: new TextStyle(fontSize: 18),
                ),
                new SizedBox(
                  height: 300.0,
                  child: mychart,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SalesData {
  String date;
  double amount;
  final charts.Color clr;
  SalesData(this.date, this.amount, Color clr)
      : this.clr =
            charts.Color(r: clr.red, g: clr.green, b: clr.blue, a: clr.alpha);
}

class ItemPieChart extends StatefulWidget {
  @override
  _ItemStatePieChart createState() => _ItemStatePieChart();
}

class _ItemStatePieChart extends State<ItemPieChart> {
  @override
  Widget build(BuildContext context) {
    var data = [
      SalesItemData("Eyelash Ext Natural", 80000.0, Colors.amber),
      SalesItemData("Eyelash Ext Clasic", 250000.0, Colors.tealAccent[700]),
      SalesItemData("Eyelash Ext Volume", 150000.0, Colors.blue[700]),
      SalesItemData("Retouch", 50000.0, Colors.red),
      SalesItemData("Remove", 50000.0, Colors.yellow),
    ];
    var series = [
      charts.Series(
          domainFn: (SalesItemData sales, _) => sales.itemName,
          measureFn: (SalesItemData sales, _) => sales.amount,
          colorFn: (SalesItemData sales, _) => sales.clr,
          id: 'peritem',
          data: data,
          labelAccessorFn: (SalesItemData sales, _) =>
              '${sales.itemName} \n Rp. ${sales.amount}')
    ];

    var mychart = charts.PieChart(
      series,
      defaultRenderer: charts.ArcRendererConfig(
          arcRendererDecorators: [charts.ArcLabelDecorator()]),
    );
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: FitnessAppTheme.white,
          elevation: 3,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                new Text(
                  "Per Item",
                  style: new TextStyle(fontSize: 18),
                ),
                new SizedBox(
                  height: 300.0,
                  child: mychart,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SalesItemData {
  String itemName;
  double amount;
  final charts.Color clr;
  SalesItemData(this.itemName, this.amount, Color clr)
      : this.clr =
            charts.Color(r: clr.red, g: clr.green, b: clr.blue, a: clr.alpha);
}
