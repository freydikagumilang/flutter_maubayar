import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maubayar/bloc/blockategori.dart';
import 'package:maubayar/fintness_app_theme.dart';
import 'package:maubayar/models/kategorimodel.dart';
import 'package:maubayar/ui_view/template/frxappbar.dart';

class Kategori extends StatefulWidget {
  @override
  _KategoriState createState() => _KategoriState();
}

class _KategoriState extends State<Kategori> {
  List<kategori> kat = [kategori("")];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetKategori>(create: (context) => GetKategori(kat)),
        BlocProvider<CreateKategori>(create: (context) => CreateKategori(0)),
        BlocProvider<DeleteKategori>(create: (context) => DeleteKategori(0)),
      ],
      child: Scaffold(
        backgroundColor: FitnessAppTheme.tosca,
        appBar: FrxAppBar("Kategori"),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 30,
            color: FitnessAppTheme.darkText,
          ),
          backgroundColor: FitnessAppTheme.yellow,
          onPressed: () async {
            AlertDialog inputdialog = AlertDialog(
              title: Text("Input Kategori"),
              content: InputKategori(),
            );
            final res = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return BlocProvider<CreateKategori>.value(
                    value: CreateKategori(0),
                    child: inputdialog,
                  );
                });
            if (res) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Kategori()));
            }
          },
        ),
        body: Padding(padding: EdgeInsets.all(5), child: kategorilist()),
      ),
    );
  }
}

// ignore: camel_case_types
class kategorilist extends StatefulWidget {
  final String cari;
  kategorilist({this.cari});
  @override
  _kategorilistState createState() => _kategorilistState();
}

// ignore: camel_case_types
class _kategorilistState extends State<kategorilist> {
  @override
  void initState() {
    // TODO: implement initState

    Future.delayed(Duration.zero, () {
      GetKategori bloc = BlocProvider.of<GetKategori>(context);
      bloc.add("");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GetKategori bloc = BlocProvider.of<GetKategori>(context);
    TextEditingController txtcari = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
            color: FitnessAppTheme.white,
            child: TextFormField(
              controller: txtcari,
              style: TextStyle(fontSize: 20.0, color: Colors.black),
              decoration: InputDecoration(
                  hintText: "Cari Kategori",
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
              padding: EdgeInsets.only(bottom: 100),
              shrinkWrap: true,
              children: [
                Card(
                  color: FitnessAppTheme.white,
                  child: BlocBuilder<GetKategori, List<kategori>>(
                    builder: (context, kat) => DataTable(
                        showBottomBorder: true,
                        columns: [
                          DataColumn(
                              label: Text("Kategori",
                                  style: TextStyle(fontSize: 20))),
                        ],
                        rows: List<DataRow>.generate(
                            ((kat == null) ? 0 : kat.length),
                            (index) => DataRow(
                                    color: MaterialStateProperty.resolveWith<
                                        Color>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.selected))
                                        return FitnessAppTheme.redtext;
                                      // Even rows will have a grey color.
                                      if (index % 2 == 0)
                                        return FitnessAppTheme.nearlyBlack
                                            .withOpacity(0.1);
                                      return null;
                                    }),
                                    cells: [
                                      DataCell(Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              GestureDetector(
                                                child: Icon(Icons.edit,
                                                    color:
                                                        FitnessAppTheme.tosca),
                                                onTap: () async {
                                                  AlertDialog inputdialog =
                                                      AlertDialog(
                                                    title: Text(
                                                        "Edit Kategori ${kat[index].kat_nama}"),
                                                    content: InputKategori(
                                                      editKat:
                                                          kat[index].kat_nama,
                                                      idKat: kat[index].kat_id,
                                                    ),
                                                  );
                                                  final res = await showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return BlocProvider<
                                                            CreateKategori>.value(
                                                          value:
                                                              CreateKategori(0),
                                                          child: inputdialog,
                                                        );
                                                      });
                                                  if (res) {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                Kategori()));
                                                  }
                                                },
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 8)),
                                              Text(
                                                kat[index].kat_nama,
                                                style: TextStyle(fontSize: 21),
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              AlertDialog delKat = AlertDialog(
                                                title: Text(
                                                    "Hapus Kategori ${kat[index].kat_nama}"),
                                                content: DeleteConfirmation(
                                                    kat[index].kat_nama,
                                                    kat[index].kat_id),
                                              );
                                              final del = await showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return BlocProvider<
                                                        DeleteKategori>.value(
                                                      value: DeleteKategori(0),
                                                      child: delKat,
                                                    );
                                                  });
                                              if (del) {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            Kategori()));
                                              }
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: FitnessAppTheme.redtext,
                                            ),
                                          ),
                                        ],
                                      ))
                                    ]))),
                  ),
                )
              ]),
        ),
      ],
    );
  }
}

class InputKategori extends StatefulWidget {
  String editKat;
  int idKat = 0;
  InputKategori({this.editKat, this.idKat = 0});
  @override
  _InputKategoriState createState() => _InputKategoriState();
}

class _InputKategoriState extends State<InputKategori> {
  final txtkategori = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    txtkategori.text = widget.editKat;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: BlocBuilder<CreateKategori, int>(
        builder: (context, idkat) => (Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                  controller: txtkategori,
                  decoration: InputDecoration(
                      labelText: 'Nama Kategori',
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: FitnessAppTheme.tosca)))),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: FitnessAppTheme.tosca,
                  onPressed: () {
                    if (widget.idKat != 0) {
                      CreateKategori creator =
                          BlocProvider.of<CreateKategori>(context);
                      kategori edited = kategori((txtkategori.text).toString());
                      edited.setId(widget.idKat);
                      creator.add(edited);
                      Navigator.of(context).pop(true);
                    } else {
                      CreateKategori creator =
                          BlocProvider.of<CreateKategori>(context);
                      creator.add(kategori((txtkategori.text).toString()));
                      Navigator.of(context).pop(true);
                    }
                  },
                  child: Text(
                    "Simpan",
                    style:
                        TextStyle(fontSize: 18.0, color: FitnessAppTheme.white),
                  )),
            ])),
      ),
    );
  }
}

class DeleteConfirmation extends StatefulWidget {
  final int idKat;
  final String namaKat;
  DeleteConfirmation(this.namaKat, this.idKat);
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
          Text("Anda yakin ingin menghapus kategori ${widget.namaKat} ?"),
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
                    DeleteKategori remover =
                        BlocProvider.of<DeleteKategori>(context);
                    remover.add(widget.idKat);
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
