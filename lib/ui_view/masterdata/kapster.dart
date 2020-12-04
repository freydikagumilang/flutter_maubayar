import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maubayar/bloc/blockapster.dart';
import 'package:maubayar/fintness_app_theme.dart';
import 'package:maubayar/main.dart';
import 'package:maubayar/models/kapstermodel.dart';
import 'package:maubayar/ui_view/masterdata/input_kapster.dart';
import 'package:maubayar/ui_view/template/frxappbar.dart';

class Kapster extends StatefulWidget {
  @override
  _KapsterState createState() => _KapsterState();
}

class _KapsterState extends State<Kapster> {
  List<kapster> listkps;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyApp(tab_id: 1,)));
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<Getkapster>(
              create: (context) => Getkapster(listkps)),
          BlocProvider<Deletekapster>(
              create: (context) => Deletekapster(0)),
        ],
        child: Scaffold(
          backgroundColor: FitnessAppTheme.tosca,
          appBar: FrxAppBar("Beautycian", backroute: "/masterdata"),
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
              size: 30,
              color: FitnessAppTheme.darkText,
            ),
            backgroundColor: FitnessAppTheme.yellow,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InputKapster()));
            },
          ),
          body: Padding(
              padding: const EdgeInsets.all(5.0), child: Kapsterlist()),
        ),
      ),
    );
  }
}

class Kapsterlist extends StatefulWidget {
  @override
  _KapsterlistState createState() => _KapsterlistState();
}

class _KapsterlistState extends State<Kapsterlist> {
  TextEditingController txtcari = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      Getkapster bloc = BlocProvider.of<Getkapster>(context);
      bloc.add("");
    });
  }

  @override
  Widget build(BuildContext context) {
    Getkapster bloc = BlocProvider.of<Getkapster>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
            color: FitnessAppTheme.white,
            child: TextFormField(
              controller: txtcari,
              style: TextStyle(fontSize: 20.0, color: Colors.black),
              decoration: InputDecoration(
                  hintText: "Cari Beautycian ",
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
                  child: BlocBuilder<Getkapster, List<kapster>>(
                      builder: (context, datakps) => DataTable(
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
                              
                              ((datakps == null) ? 0 : datakps.length),
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
                                                      InputKapster(
                                                        editPlg: datakps[index],
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
                                                  datakps[index].kapster_nama,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      TextStyle(fontSize: 20)),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(3),
                                            ),
                                            Text(
                                              (datakps[index]
                                                          .kapster_alamat !=
                                                      null)
                                                  ? datakps[index]
                                                      .kapster_alamat
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
                                          datakps[index]
                                              .kapster_hp
                                              .toString(),
                                          style: TextStyle(fontSize: 23)),
                                    ),
                                    DataCell(
                                      GestureDetector(
                                        onTap: () async {
                                          AlertDialog delKat = AlertDialog(
                                            title: Text(
                                                "Hapus Kategori ${datakps[index].kapster_nama}"),
                                            content:
                                                DeleteConfrimationKapster(
                                                    datakps[index]),
                                          );
                                          final del = await showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return BlocProvider<
                                                    Deletekapster>.value(
                                                  value: Deletekapster(0),
                                                  child: delKat,
                                                );
                                              });
                                          if (del) {
                                            Getkapster bloc =
                                                BlocProvider.of<Getkapster>(
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

class DeleteConfrimationKapster extends StatefulWidget {
  final kapster delPlg;
  DeleteConfrimationKapster(this.delPlg);
  @override
  _DeleteConfrimationKapsterState createState() =>
      _DeleteConfrimationKapsterState();
}

class _DeleteConfrimationKapsterState
    extends State<DeleteConfrimationKapster> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              "Anda yakin ingin menghapus Kapster : \n${widget.delPlg.kapster_nama} ?"),
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
                    Deletekapster remover =
                        BlocProvider.of<Deletekapster>(context);
                    remover.add(widget.delPlg.kapster_id);
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
