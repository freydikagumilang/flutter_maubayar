import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:maubayar/bloc/blockas.dart';
import 'package:maubayar/dashboard/dashboardchart.dart';
import 'package:maubayar/fintness_app_theme.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maubayar/global_var.dart';
import 'package:maubayar/models/kasmodel.dart';

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
    List<bukukas> _initbk;
    PageController _chartPage = PageController(initialPage: 1);
    return Container(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      body: MultiBlocProvider(
        providers: [
          BlocProvider<GetDateSaldo>(
              create: (context) => GetDateSaldo(_initbk)),
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
  List<int> todayRange = [
    global_var.unixtime_yesterday,
    global_var.unixtime_today
  ];
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
      child: BlocBuilder<GetDateSaldo, List<bukukas>>(
        builder: (context, dt_saldo) {
          double _growth = ((dt_saldo != null)
              ? ((dt_saldo[0].bukukas_created_at ==
                      global_var.unixtime_yesterday)
                  ? (((dt_saldo.length > 1) ? dt_saldo[1].bukukas_tunai : 0) -
                      dt_saldo[0].bukukas_tunai)
                  : dt_saldo[0].bukukas_tunai)
              : 0);

          return Card(
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
                    NumDec.format((dt_saldo != null)
                        ? ((dt_saldo[0].bukukas_created_at ==
                                global_var.unixtime_today)
                            ? dt_saldo[0].bukukas_tunai
                            : (dt_saldo.length > 1)
                                ? dt_saldo[1].bukukas_tunai
                                : 0)
                        : 0),
                    style: TextStyle(
                      fontSize: 40.0,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        (_growth > 0)
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        color: (_growth > 0)
                            ? FitnessAppTheme.greentext
                            : FitnessAppTheme.redtext,
                        size: 40,
                      ),
                      Text(
                        ((_growth > 0)?"Naik ":"Turun ")+NumDec.format(_growth.abs()),
                        style: TextStyle(
                          fontSize: 18.0,
                          color: (_growth > 0)
                            ? FitnessAppTheme.greentext
                            : FitnessAppTheme.redtext,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
