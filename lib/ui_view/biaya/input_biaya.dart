import 'package:flutter/material.dart';
import 'package:maubayar/fintness_app_theme.dart';
import 'package:maubayar/main.dart';
import 'package:maubayar/ui_view/template/frxappbar.dart';
import 'package:intl/intl.dart';

class InputBiaya extends StatefulWidget {
  @override
  _InputBiayaState createState() => _InputBiayaState();
}

class _InputBiayaState extends State<InputBiaya> {
  DateTime selectedDate = DateTime.now();
  var formatter = new DateFormat.yMMMMd();
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
        backgroundColor: FitnessAppTheme.tosca,
        appBar: FrxAppBar("Kas", backroute: "/dashboard"),
        body: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: FitnessAppTheme.white),
                ),
              ),
              Wrap(
                runSpacing: 1.0,
                spacing: 5.0,
                children: [
                  RaisedButton(
                    onPressed: () {},
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: FitnessAppTheme.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Tambah Data",
                          style: TextStyle(
                              color: FitnessAppTheme.tosca, fontSize: 18)),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: FitnessAppTheme.redtext,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Biaya",
                          style: TextStyle(
                              color: FitnessAppTheme.white, fontSize: 18)),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: FitnessAppTheme.yellow,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Pendapatan",
                          style: TextStyle(
                              color: FitnessAppTheme.white, fontSize: 18)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
