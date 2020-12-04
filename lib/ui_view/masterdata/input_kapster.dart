import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maubayar/bloc/blockapster.dart';
import 'package:maubayar/fintness_app_theme.dart';
import 'package:maubayar/models/kapstermodel.dart';
import 'package:maubayar/ui_view/masterdata/kapster.dart';
import 'package:maubayar/ui_view/template/frxappbar.dart';

class InputKapster extends StatefulWidget {
  final kapster editPlg;
  InputKapster({this.editPlg});
  @override
  InputKapsterState createState() => InputKapsterState();
}

class InputKapsterState extends State<InputKapster> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context, rootNavigator: true).pushNamed("/kapster");
      },
      child: BlocProvider<Createkapster>(
          create: (BuildContext context) => Createkapster(""),
          child: Scaffold(
            backgroundColor: FitnessAppTheme.tosca,
            appBar: FrxAppBar(
              ((widget.editPlg != null) ? "Edit Beautycian" : "Input Beautycian"),
              backroute: "/kapster",
            ),
            body: Container(
                height: MediaQuery.of(context).size.height / 2.5,
                padding: EdgeInsets.all(10),
                child: InputFormKapster(
                  editplg: widget.editPlg,
                )),
          )),
    );
  }
}

class InputFormKapster extends StatefulWidget {
  final kapster editplg;
  InputFormKapster({this.editplg});
  @override
  _InputFormKapsterState createState() => _InputFormKapsterState();
}

class _InputFormKapsterState extends State<InputFormKapster> {
  TextEditingController txtNamaPlg = TextEditingController();
  TextEditingController txtHP = TextEditingController();
  TextEditingController txtAlamat = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if (widget.editplg != null) {
      txtNamaPlg.text = widget.editplg.kapster_nama;
      txtHP.text = widget.editplg.kapster_hp;
      txtAlamat.text = widget.editplg.kapster_alamat;
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
                  kapster newplg =
                      kapster(txtNamaPlg.text, txtHP.text.toString(), txtAlamat.text);
                  if (widget.editplg != null) {
                    newplg.setId(widget.editplg.kapster_id);
                  }
                  Createkapster creator = Createkapster("");
                  creator.add(newplg);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Kapster()));
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
