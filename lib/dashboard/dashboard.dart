import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:maubayar/dashboard/dashboardchart.dart';
import 'package:maubayar/fintness_app_theme.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  
  @override
  Widget build(BuildContext context) {
    PageController _chartPage = PageController(
      initialPage: 1
    );
    return Container(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: FitnessAppTheme.tosca,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CashBalance(),
            Divider(
              height: 20,
              thickness: 2,
              indent: 20,
              endIndent: 20,
              color: FitnessAppTheme.grey.withOpacity(0.1),
            ),
            // Expanded(child: AllChart()),
            AllChart()
          ],
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8,30,8,0),
      child: Card(
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
                "RP 5.000.000",
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
                    "RP 5.000.000",
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
    );
  }
}
