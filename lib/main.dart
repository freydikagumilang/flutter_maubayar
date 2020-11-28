import 'package:flutter/material.dart';
import 'package:maubayar/homescreen.dart';
import 'package:maubayar/models/produkmodel.dart';
import 'package:maubayar/ui_view/masterdata/kapster.dart';
import 'package:maubayar/ui_view/masterdata/pelanggan.dart';
import 'package:maubayar/ui_view/produk/produk.dart';
import 'package:maubayar/ui_view/produk/kategori.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String,WidgetBuilder>{
          '/kategori':(context)=> new Kategori(),//Kategori(),
          '/produk':(context)=> new Produk(),//Produk(),
          '/pelanggan':(context)=> new Pelanggan(),
          '/kapster':(context)=> new Kapster(),
        },
      home: HomeScreen(),
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