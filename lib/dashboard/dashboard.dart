import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:maubayar/bloc/blockas.dart';
import 'package:maubayar/dashboard/dashboardchart.dart';
import 'package:maubayar/fintness_app_theme.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maubayar/global_var.dart';
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DateTime selectedDate = DateTime.now();
  var formatter = new DateFormat.yMMMMd();
  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    PageController _chartPage = PageController(initialPage: 1);
    return Container(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      body: MultiBlocProvider(
        providers: [
          BlocProvider<GetDateSaldo>(create: (context) => GetDateSaldo(0.0)),
        ],
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 40, 20, 10),
          color: FitnessAppTheme.tosca,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              GestureDetector(
                onTap: () async {
                  final DateTime picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate, // Refer step 1
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2025),
                    cancelText: "Batal",
                    confirmText: "Pilih",
                  );
                  if (picked != null && picked != selectedDate)
                    setState(() {
                      selectedDate = picked;
                    });
                },
                child: Text(
                  "${formatter.format(selectedDate)}",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: FitnessAppTheme.white),
                ),
              ),
              CashBalance(),
              AllChart()
            ],
          ),
        ),
      ),
    ));
  }
}

class CashBalance extends StatefulWidget {
  @override
  _CashBalanceState createState() => _CashBalanceState();
}

class _CashBalanceState extends State<CashBalance> {
  var NumCompact = new NumberFormat.compact(locale: "id");
  var NumDec = new NumberFormat.decimalPattern("id");
  List<int> todayRange  = [global_var.unixtime_today,global_var.unixtime_today];
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      GetDateSaldo bloc = BlocProvider.of<GetDateSaldo>(context);
      bloc.add(todayRange);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: BlocBuilder<GetDateSaldo, double>(
        builder: (context, dt_saldo) =>Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 3,
          color: FitnessAppTheme.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Saldo Kas",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "SFProDisplay",
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Text(
                  NumDec.format(dt_saldo),
                  style: TextStyle(
                    fontSize: 40.0,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_drop_up,
                      color: FitnessAppTheme.greentext,
                      size: 40,
                    ),
                    Text(
                      NumDec.format(320000),
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
