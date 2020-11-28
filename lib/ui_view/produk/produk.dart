import 'package:flutter/material.dart';
import 'package:maubayar/fintness_app_theme.dart';
import 'package:maubayar/ui_view/produk/input_produk.dart';
import 'package:maubayar/ui_view/template/frxappbar.dart';
import 'package:intl/intl.dart';

class Produk extends StatefulWidget {
  @override
  _ProdukState createState() => _ProdukState();
}

class _ProdukState extends State<Produk> {
  // var NumFormat = new NumberFormat.simpleCurrency(locale: "id",decimalDigits: 0);
  var NumFormat = new NumberFormat.compact(locale: "id");
  @override
  Widget build(BuildContext context) {
    TextEditingController txtcari = TextEditingController();
    return Scaffold(
      backgroundColor: FitnessAppTheme.tosca,
      appBar: FrxAppBar("Produk"),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 30,
          color: FitnessAppTheme.darkText,
        ),
        backgroundColor: FitnessAppTheme.yellow,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => InputProduk()));
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: FitnessAppTheme.white,
              child: TextFormField(
                controller: txtcari,
                style: TextStyle(fontSize: 20.0, color: Colors.black),
                decoration: InputDecoration(
                    hintText: "Cari Produk",
                    prefixIcon: Icon(
                      Icons.search,
                      color: FitnessAppTheme.tosca,
                    )),
                onChanged: (val) {},
              )),
            Expanded(
              child: ListView(
                children: [
                  Card(
                    color: FitnessAppTheme.white,
                    child: DataTable(
                      dataRowHeight: 70,
                      showBottomBorder: true,
                      columns: [
                        DataColumn(
                            label: Text("Nama", style: TextStyle(fontSize: 20))),
                        DataColumn(
                            label: Text("Harga", style: TextStyle(fontSize: 20))),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.45,
                                  child: Text("Eyelash Volume",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 20)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(3),
                                ),
                                Text(
                                  "Eyelash",
                                  style: TextStyle(
                                      fontSize: 14, color: FitnessAppTheme.grey),
                                )
                              ],
                            ),
                          )),
                          DataCell(Row(
                            children: [
                              Text(NumFormat.format(152500).toString(),
                                  style: TextStyle(fontSize: 23)),
                            ],
                          )),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
