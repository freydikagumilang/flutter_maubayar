import 'package:flutter/material.dart';
import 'package:maubayar/fintness_app_theme.dart';


class FrxAppBar extends StatefulWidget implements PreferredSizeWidget{
  final String mytitle;
  FrxAppBar(this.mytitle,{Key key}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);
  
  @override
    final Size preferredSize; // default is 56.0
  @override
  _FrxAppBarState createState() => _FrxAppBarState();
}

class _FrxAppBarState extends State<FrxAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: FitnessAppTheme.tosca,
        elevation: 0,
        title: Text(
          widget.mytitle,
          style: TextStyle(fontSize: 25, color: FitnessAppTheme.white),
        ));
  }
}
