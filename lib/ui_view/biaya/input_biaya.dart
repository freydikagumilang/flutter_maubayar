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
        appBar: FrxAppBar("Biaya", backroute: "/dashboard"),
        body: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                      color: FitnessAppTheme.white),
                ),
              ),
              Card(
                color: FitnessAppTheme.yellow,
                child: Text("500K"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
