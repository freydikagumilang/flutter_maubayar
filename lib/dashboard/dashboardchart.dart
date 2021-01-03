import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maubayar/bloc/blockasir.dart';
import 'package:maubayar/fintness_app_theme.dart';
import 'package:intl/intl.dart';
import 'package:maubayar/models/kasirmodel.dart';
import 'package:maubayar/global_var.dart';

class AllChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<salesperday> _initsalesday;
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetLast7DaysSale>(
            create: (context) => GetLast7DaysSale(_initsalesday))
      ],
      child: Container(
        height: 250,
        child: ListView(
          // This next line does the trick.
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            DashboardChart(),
            ItemPieChart(),
          ],
        ),
      ),
    );
  }
}

class DashboardChart extends StatefulWidget {
  @override
  _DashboardChartState createState() => _DashboardChartState();
}

class _DashboardChartState extends State<DashboardChart> {
  var NumCompact = new NumberFormat.compact(locale: "id");
  DateFormat dtformater = DateFormat('dd MMM');
  var series;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      GetLast7DaysSale bloc = BlocProvider.of<GetLast7DaysSale>(context);
      bloc.add(global_var.unixtime_today);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
        child: Card(
          color: FitnessAppTheme.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Column(
              children: <Widget>[
                new Text(
                  "Penjualan 7 Hari",
                  style: new TextStyle(fontSize: 18),
                ),
                BlocBuilder<GetLast7DaysSale, List<salesperday>>(
                    builder: (context, dt) {
                  // var data = [
                  //   SalesData("21 Oct", 40000.0, Colors.tealAccent[700]),
                  //   SalesData("22 Oct", 25000.0, Colors.red),
                  //   SalesData("23 Oct", 19000.0, Colors.red),
                  //   SalesData("24 Oct", 35000.0, Colors.amber),
                  //   SalesData("25 Oct", 70000.0, Colors.tealAccent[700]),
                  //   SalesData("26 Oct", 50000.0, Colors.amber),
                  //   SalesData("27 Oct", 99000.0, Colors.tealAccent[700])
                  // ];
                  
                  List<SalesData> listdata=[];
                  var datachart;
                  var mychart;
                  Color _clr = Colors.tealAccent[700];
                  int _flg=0;
                  if (dt != null) {
                    for (var i = 0; i < dt.length; i++) {
                      // print("date $i:" + dtformater.format(DateTime.fromMillisecondsSinceEpoch(dt[i].saledate)));
                      // // print("date $i:" + dt[i].saledate.toString());
                      // print("total $i:" + dt[i].saletotal.toString());
                      
                      listdata.add(SalesData(dtformater.format(DateTime.fromMillisecondsSinceEpoch(dt[i].saledate)),
                          dt[i].saletotal,_clr ));
                      if(_flg==0){
                        _flg=1;
                        _clr = Colors.red;
                      }else if(_flg==1){
                        _flg=2;
                        _clr = Colors.amber;
                      }else{
                        _flg=0;
                        _clr = Colors.tealAccent[700];
                      }
                    }
                    datachart = listdata;
                    var series = [
                      charts.Series(
                        domainFn: (SalesData sales, _) => sales.date,
                        measureFn: (SalesData sales, _) => sales.amount,
                        colorFn: (SalesData sales, _) => sales.clr,
                        id: 'lastweek',
                        data: datachart,
                      )
                    ];
                    mychart = charts.BarChart(
                      series,
                      primaryMeasureAxis: new charts.NumericAxisSpec(
                          renderSpec: new charts.NoneRenderSpec()),
                      // domainAxis: new charts.OrdinalAxisSpec(
                      //     showAxisLine: true, renderSpec: new charts.NoneRenderSpec()),
                    );
                  }

                  return SizedBox(
                    height: 180.0,
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: mychart,
                  );
                }),
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
      width: MediaQuery.of(context).size.width / 1.1,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
        child: Card(
          color: FitnessAppTheme.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                new Text(
                  "Per Item",
                  style: new TextStyle(fontSize: 18),
                ),
                new SizedBox(
                  height: 180.0,
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
