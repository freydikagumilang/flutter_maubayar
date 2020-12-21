import 'package:flutter/material.dart';
import 'package:maubayar/fintness_app_theme.dart';
import 'package:maubayar/main.dart';
import 'package:maubayar/ui_view/template/frxappbar.dart';

class SysConfig extends StatefulWidget {
  @override
  _SysConfigState createState() => _SysConfigState();
}

class _SysConfigState extends State<SysConfig> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        onWillPop:
        () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyApp(
                        tab_id: 0,
                      )));
        };
      },
      child: Scaffold(
        backgroundColor: FitnessAppTheme.tosca,
        appBar: FrxAppBar("Pengaturan", backroute: "/dashboard"),
        body: Container(
          child: ListView(
            children: ListTile.divideTiles(
                context: context,
                color: FitnessAppTheme.white,
                tiles: [
                  ListTile(
                    onTap: (){
                      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (BuildContext context) => CompanyConfig()));
                    },
                    leading: Icon(
                      Icons.business,
                      color: FitnessAppTheme.white,
                      size: 35,
                    ),
                    title: Text(
                      "Profil Usaha",
                      style:
                          TextStyle(color: FitnessAppTheme.white, fontSize: 20),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: FitnessAppTheme.white,
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.print,
                      color: FitnessAppTheme.white,
                      size: 35,
                    ),
                    title: Text(
                      "Printer",
                      style:
                          TextStyle(color: FitnessAppTheme.white, fontSize: 20),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: FitnessAppTheme.white,
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.dns,
                      color: FitnessAppTheme.white,
                      size: 35,
                    ),
                    title: Text(
                      "Database",
                      style:
                          TextStyle(color: FitnessAppTheme.white, fontSize: 20),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: FitnessAppTheme.white,
                    ),
                  )
                ]).toList(),
          ),
        ),
      ),
    );
  }
}

class CompanyConfig extends StatefulWidget {
  @override
  _CompanyConfigState createState() => _CompanyConfigState();
}

class _CompanyConfigState extends State<CompanyConfig> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyApp(
                      tab_id: 0,
                    )));
      },
      child: Scaffold(
        appBar: FrxAppBar(
          "Profil Bisnis",
          backroute: "/sysconfig",
        ),
      ),
    );
  }
}
