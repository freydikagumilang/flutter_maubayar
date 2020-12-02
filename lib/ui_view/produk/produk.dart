import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maubayar/bloc/blocproduk.dart';
import 'package:maubayar/fintness_app_theme.dart';
import 'package:maubayar/models/produkmodel.dart';
import 'package:maubayar/ui_view/produk/input_produk.dart';
import 'package:maubayar/ui_view/template/frxappbar.dart';
import 'package:intl/intl.dart';

class Produk extends StatefulWidget {
  @override
  _ProdukState createState() => _ProdukState();
}

class _ProdukState extends State<Produk> {
  // var NumFormat = new NumberFormat.simpleCurrency(locale: "id",decimalDigits: 0);
  List<produk> listprod;

  @override
  Widget build(BuildContext context) {
    TextEditingController txtcari = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => Getproduk(listprod),
      child: Scaffold(
        backgroundColor: FitnessAppTheme.tosca,
        appBar: FrxAppBar("Produks"),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 30,
            color: FitnessAppTheme.darkText,
          ),
          backgroundColor: FitnessAppTheme.yellow,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => InputProduk()));
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
                    Produklist(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Produklist extends StatefulWidget {
  @override
  _ProduklistState createState() => _ProduklistState();
}

class _ProduklistState extends State<Produklist> {
  var NumFormat = new NumberFormat.compact(locale: "id");

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      Getproduk bloc = BlocProvider.of<Getproduk>(context);
      bloc.add("");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: FitnessAppTheme.white,
      child: BlocBuilder<Getproduk, List<produk>>(
          builder: (context, dataprod) => DataTable(
              dataRowHeight: 70,
              showBottomBorder: true,
              columns: [
                DataColumn(label: Text("Nama", style: TextStyle(fontSize: 20))),
                DataColumn(
                    label: Text("Harga", style: TextStyle(fontSize: 20))),
              ],
              rows: List<DataRow>.generate(
                ((dataprod == null) ? 0 : dataprod.length),
                (index) => DataRow(
                    color: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected))
                        return FitnessAppTheme.nearlyBlue;
                      // Even rows will have a grey color.
                      if (index % 2 == 0)
                        return FitnessAppTheme.nearlyBlack.withOpacity(0.1);
                      return null;
                    }),
                    cells: [
                      DataCell(Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InputProduk(edit_prod: dataprod[index],)));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Text(dataprod[index].prod_nama,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 20)),
                              ),
                              Padding(
                                padding: EdgeInsets.all(3),
                              ),
                              Text(
                                (dataprod[index].kat_nama!=null)?dataprod[index].kat_nama:"",
                                style: TextStyle(
                                    fontSize: 14, color: FitnessAppTheme.grey),
                              )
                            ],
                          ),
                        ),
                      )),
                      DataCell(Row(
                        children: [
                          Text(
                              NumFormat.format(dataprod[index].prod_price)
                                  .toString(),
                              style: TextStyle(fontSize: 23)),
                        ],
                      )),
                    ]),
              ))),
    );
  }
}
