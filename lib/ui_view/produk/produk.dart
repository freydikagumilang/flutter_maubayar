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
    
    return MultiBlocProvider(
      providers: [
        BlocProvider<Getproduk>(create: (context) => Getproduk(listprod)),
        BlocProvider<Deleteproduk>(create: (context) => Deleteproduk(0)),
      ],
      child: Scaffold(
        backgroundColor: FitnessAppTheme.tosca,
        appBar: FrxAppBar("Item/Layanan"),
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
          child: Produklist()
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
  TextEditingController txtcari = TextEditingController();

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
    Getproduk bloc = BlocProvider.of<Getproduk>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
              onChanged: (val) {
                Future.delayed(Duration(milliseconds: 500), () {
                  bloc.add(val);
                });
              },
            )),
        Expanded(
          child: ListView(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Card(
                  color: FitnessAppTheme.white,
                  child: BlocBuilder<Getproduk, List<produk>>(
                      builder: (context, dataprod) => DataTable(
                          dataRowHeight: 70,
                          showBottomBorder: true,
                          columns: [
                            DataColumn(
                                label: Text("Nama",
                                    style: TextStyle(fontSize: 20))),
                            DataColumn(
                                label: Text("Harga",
                                    style: TextStyle(fontSize: 20))),
                            DataColumn(
                              label: Icon(
                                Icons.delete_forever,
                                size: 30,
                                color: FitnessAppTheme.redtext,
                              ),
                            ),
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
                                    return FitnessAppTheme.nearlyBlack
                                        .withOpacity(0.1);
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
                                                builder: (context) =>
                                                    InputProduk(
                                                      edit_prod:
                                                          dataprod[index],
                                                    )));
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.45,
                                            child: Text(
                                                dataprod[index].prod_nama,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 20)),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(3),
                                          ),
                                          Text(
                                            (dataprod[index].kat_nama != null)
                                                ? dataprod[index].kat_nama
                                                : "",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: FitnessAppTheme.grey),
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                                  DataCell(
                                    Text(
                                        NumFormat.format(
                                                dataprod[index].prod_price)
                                            .toString(),
                                        style: TextStyle(fontSize: 23)),
                                  ),
                                  DataCell(
                                    GestureDetector(
                                        onTap: () async {
                                          AlertDialog delDialog = AlertDialog(
                                            title: Text("Hapus Produk !"),
                                            content: DeleteConfirmation(
                                                dataprod[index].prod_nama,
                                                dataprod[index].prod_id),
                                          );
                                          final del = await showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return BlocProvider<
                                                    Deleteproduk>.value(
                                                  value: Deleteproduk(0),
                                                  child: delDialog,
                                                );
                                              });
                                          if (del) {
                                            Getproduk bloc =
                                                BlocProvider.of<Getproduk>(
                                                    context);
                                            bloc.add("");
                                          }
                                        },
                                        child: Icon(
                                          Icons.delete_forever,
                                          size: 30,
                                          color: FitnessAppTheme.redtext,
                                        )),
                                  ),
                                ]),
                          ))),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DeleteConfirmation extends StatefulWidget {
  final int idProd;
  final String namaProd;
  DeleteConfirmation(this.namaProd, this.idProd);
  @override
  _DeleteConfirmationState createState() => _DeleteConfirmationState();
}

class _DeleteConfirmationState extends State<DeleteConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Anda yakin ingin menghapus Produk ${widget.namaProd} ?"),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  color: FitnessAppTheme.tosca,
                  child: Text(
                    "Tidak",
                    style:
                        TextStyle(fontSize: 18.0, color: FitnessAppTheme.white),
                  )),
              FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: FitnessAppTheme.redtext,
                  onPressed: () {
                    Deleteproduk remover =
                        BlocProvider.of<Deleteproduk>(context);
                    remover.add(widget.idProd);
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    "Ya, Hapus",
                    style:
                        TextStyle(fontSize: 18.0, color: FitnessAppTheme.white),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
