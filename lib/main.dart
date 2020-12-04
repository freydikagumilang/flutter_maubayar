import 'package:flutter/material.dart';
import 'package:maubayar/dashboard/dashboard.dart';
import 'package:maubayar/homescreen.dart';
import 'package:maubayar/masterdata.dart';
import 'package:maubayar/models/produkmodel.dart';
import 'package:maubayar/ui_view/masterdata/kapster.dart';
import 'package:maubayar/ui_view/masterdata/pelanggan.dart';
import 'package:maubayar/ui_view/produk/produk.dart';
import 'package:maubayar/ui_view/produk/kategori.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final int tab_id;
  MyApp({this.tab_id=0});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async=>false,
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: <String,WidgetBuilder>{
            '/dashboard':(context)=> new MyApp(tab_id: 2),//Kategori(),
            '/masterdata':(context)=> new MyApp(tab_id: 1,),//Kategori(),
            '/kategori':(context)=> new Kategori(),//Kategori(),
            '/produk':(context)=> new Produk(),//Produk(),
            '/pelanggan':(context)=> new Pelanggan(),
            '/kapster':(context)=> new Kapster(),
          },
        home: HomeScreen(tab_id: tab_id,),
      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}