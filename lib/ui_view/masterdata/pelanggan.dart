import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maubayar/bloc/blocpelanggan.dart';
import 'package:maubayar/fintness_app_theme.dart';
import 'package:maubayar/main.dart';
import 'package:maubayar/models/pelangganmodel.dart';
import 'package:maubayar/ui_view/masterdata/input_pelanggan.dart';
import 'package:maubayar/ui_view/template/frxappbar.dart';

class Pelanggan extends StatefulWidget {
  @override
  _PelangganState createState() => _PelangganState();
}

class _PelangganState extends State<Pelanggan> {
  List<pelanggan> listplg;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyApp(tab_id: 1,)));
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<Getpelanggan>(
              create: (context) => Getpelanggan(listplg)),
          BlocProvider<Deletepelanggan>(
              create: (context) => Deletepelanggan(0)),
        ],
        child: Scaffold(
          backgroundColor: FitnessAppTheme.tosca,
          appBar: FrxAppBar("Pelanggan", backroute: "/masterdata"),
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
              size: 30,
              color: FitnessAppTheme.darkText,
            ),
            backgroundColor: FitnessAppTheme.yellow,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InputPelanggan()));
            },
          ),
          body: Padding(
              padding: const EdgeInsets.all(5.0), child: Pelangganlist()),
        ),
      ),
    );
  }
}

class Pelangganlist extends StatefulWidget {
  @override
  _PelangganlistState createState() => _PelangganlistState();
}

class _PelangganlistState extends State<Pelangganlist> {
  TextEditingController txtcari = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      Getpelanggan bloc = BlocProvider.of<Getpelanggan>(context);
      bloc.add("");
    });
  }

  @override
  Widget build(BuildContext context) {
    Getpelanggan bloc = BlocProvider.of<Getpelanggan>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
            color: FitnessAppTheme.white,
            child: TextFormField(
              controller: txtcari,
              style: TextStyle(fontSize: 20.0, color: Colors.black),
              decoration: InputDecoration(
                  hintText: "Cari Nama / No.HP Pelanggan ",
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
                  child: BlocBuilder<Getpelanggan, List<pelanggan>>(
                      builder: (context, dataplg) => DataTable(
                            dataRowHeight: 70,
                            showBottomBorder: true,
                            columns: [
                              DataColumn(
                                  label: Text("Nama",
                                      style: TextStyle(fontSize: 20))),
                              DataColumn(
                                  label: Text("HP",
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
                              ((dataplg == null) ? 0 : dataplg.length),
                              (index) => DataRow(
                                  color:
                                      MaterialStateProperty.resolveWith<Color>(
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
                                                      InputPelanggan(
                                                        editPlg: dataplg[index],
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
                                                  dataplg[index].pelanggan_nama,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      TextStyle(fontSize: 20)),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(3),
                                            ),
                                            Text(
                                              (dataplg[index]
                                                          .pelanggan_alamat !=
                                                      null)
                                                  ? dataplg[index]
                                                      .pelanggan_alamat
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
                                          dataplg[index]
                                              .pelanggan_hp
                                              .toString(),
                                          style: TextStyle(fontSize: 23)),
                                    ),
                                    DataCell(
                                      GestureDetector(
                                        onTap: () async {
                                          AlertDialog delKat = AlertDialog(
                                            title: Text(
                                                "Hapus Kategori ${dataplg[index].pelanggan_nama}"),
                                            content:
                                                DeleteConfrimationPelanggan(
                                                    dataplg[index]),
                                          );
                                          final del = await showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return BlocProvider<
                                                    Deletepelanggan>.value(
                                                  value: Deletepelanggan(0),
                                                  child: delKat,
                                                );
                                              });
                                          if (del) {
                                            Getpelanggan bloc =
                                                BlocProvider.of<Getpelanggan>(
                                                    context);
                                            bloc.add("");
                                          }
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: FitnessAppTheme.redtext,
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          )),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DeleteConfrimationPelanggan extends StatefulWidget {
  final pelanggan delPlg;
  DeleteConfrimationPelanggan(this.delPlg);
  @override
  _DeleteConfrimationPelangganState createState() =>
      _DeleteConfrimationPelangganState();
}

class _DeleteConfrimationPelangganState
    extends State<DeleteConfrimationPelanggan> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              "Anda yakin ingin menghapus Pelanggan : \n${widget.delPlg.pelanggan_nama} ?"),
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
                    Deletepelanggan remover =
                        BlocProvider.of<Deletepelanggan>(context);
                    remover.add(widget.delPlg.pelanggan_id);
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
