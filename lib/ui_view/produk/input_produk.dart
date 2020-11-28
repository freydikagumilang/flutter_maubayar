import 'package:flutter/material.dart';
import 'package:maubayar/fintness_app_theme.dart';
import 'package:maubayar/ui_view/template/frxappbar.dart';

class InputProduk extends StatefulWidget {
  @override
  _InputProdukState createState() => _InputProdukState();
}

class _InputProdukState extends State<InputProduk> {
  TextEditingController txtNamaProduk = TextEditingController();
  TextEditingController txtHarga = TextEditingController();
  TextEditingController txtmodal = TextEditingController();
  TextEditingController txtbarcode = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FitnessAppTheme.tosca,
      appBar: FrxAppBar("Input Produk"),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                    controller: txtbarcode,
                    decoration: InputDecoration(
                        labelText: 'Barcode Produk',
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: FitnessAppTheme.tosca)))),
                  TextFormField(
                    controller: txtNamaProduk,
                    decoration: InputDecoration(
                        labelText: 'Nama Produk',
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: FitnessAppTheme.tosca)))),

              ],
            ),
          ),
        ),
      ),
      
    );
  }
}