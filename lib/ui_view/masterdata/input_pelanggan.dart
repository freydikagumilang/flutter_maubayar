import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maubayar/bloc/blocpelanggan.dart';
import 'package:maubayar/fintness_app_theme.dart';
import 'package:maubayar/models/pelangganmodel.dart';
import 'package:maubayar/ui_view/masterdata/pelanggan.dart';
import 'package:maubayar/ui_view/template/frxappbar.dart';

class InputPelanggan extends StatefulWidget {
  final pelanggan editPlg;
  InputPelanggan({this.editPlg});
  @override
  InputPelangganState createState() => InputPelangganState();
}

class InputPelangganState extends State<InputPelanggan> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context, rootNavigator: true).pushNamed("/pelanggan");
      },
      child: BlocProvider<Createpelanggan>(
          create: (BuildContext context) => Createpelanggan(""),
          child: Scaffold(
            backgroundColor: FitnessAppTheme.tosca,
            appBar: FrxAppBar(
              ((widget.editPlg != null) ? "Edit Pelanggan" : "Input Pelanggan"),
              backroute: "/pelanggan",
            ),
            body: Container(
                height: MediaQuery.of(context).size.height / 2,
                padding: EdgeInsets.all(10),
                child: InputFormPelanggan(
                  editplg: widget.editPlg,
                )),
          )),
    );
  }
}

class InputFormPelanggan extends StatefulWidget {
  final pelanggan editplg;
  InputFormPelanggan({this.editplg});
  @override
  _InputFormPelangganState createState() => _InputFormPelangganState();
}

class _InputFormPelangganState extends State<InputFormPelanggan> {
  TextEditingController txtNamaPlg = TextEditingController();
  TextEditingController txtHP = TextEditingController();
  TextEditingController txtAlamat = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if (widget.editplg != null) {
      txtNamaPlg.text = widget.editplg.pelanggan_nama;
      txtHP.text = widget.editplg.pelanggan_hp;
      txtAlamat.text = widget.editplg.pelanggan_alamat;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
                style: TextStyle(fontSize: 20),
                controller: txtNamaPlg,
                decoration: InputDecoration(
                    labelText: 'Nama',
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: FitnessAppTheme.tosca)))),
            TextFormField(
                style: TextStyle(fontSize: 20),
                controller: txtHP,
                decoration: InputDecoration(
                    labelText: 'No.Handphone',
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: FitnessAppTheme.tosca)))),
            TextFormField(
                style: TextStyle(fontSize: 20),
                controller: txtAlamat,
                decoration: InputDecoration(
                    labelText: 'Alamat',
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: FitnessAppTheme.tosca)))),
            FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: FitnessAppTheme.tosca,
                onPressed: () {
                  pelanggan newplg =
                      pelanggan(txtNamaPlg.text, txtHP.text, txtAlamat.text);
                  if (widget.editplg != null) {
                    newplg.setId(widget.editplg.pelanggan_id);
                  }
                  Createpelanggan creator = Createpelanggan("");
                  creator.add(newplg);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Pelanggan()));
                },
                child: Text(
                  "Simpan",
                  style:
                      TextStyle(fontSize: 18.0, color: FitnessAppTheme.white),
                ))
          ],
        ),
      ),
    );
  }
}
