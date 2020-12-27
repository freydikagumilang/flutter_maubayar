import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:maubayar/fintness_app_theme.dart';
import 'package:maubayar/global_var.dart';
import 'package:maubayar/main.dart';
import 'package:maubayar/ui_view/template/frxappbar.dart';

class SysConfig extends StatefulWidget {
  @override
  _SysConfigState createState() => _SysConfigState();
}

class _SysConfigState extends State<SysConfig> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: FitnessAppTheme.tosca,
        appBar: FrxAppBar("Pengaturan", backroute: "/dashboard"),
        body: Container(
          child: ListView(
            children: ListTile.divideTiles(
                context: context,
                color: FitnessAppTheme.white,
                tiles: [
                  ListTile(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true)
                          .pushNamed("/company_profile");
                    },
                    leading: Icon(
                      Icons.business,
                      color: FitnessAppTheme.white,
                      size: 35,
                    ),
                    title: Text(
                      "Profil Usaha",
                      style:
                          TextStyle(color: FitnessAppTheme.white, fontSize: 20),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: FitnessAppTheme.white,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true)
                          .pushNamed("/printer_config");
                    },
                    leading: Icon(
                      Icons.print,
                      color: FitnessAppTheme.white,
                      size: 35,
                    ),
                    title: Text(
                      "Printer",
                      style:
                          TextStyle(color: FitnessAppTheme.white, fontSize: 20),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: FitnessAppTheme.white,
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.dns,
                      color: FitnessAppTheme.white,
                      size: 35,
                    ),
                    title: Text(
                      "Database",
                      style:
                          TextStyle(color: FitnessAppTheme.white, fontSize: 20),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: FitnessAppTheme.white,
                    ),
                  )
                ]).toList(),
          ),
        ),
      ),
    );
  }
}

class CompanyConfig extends StatefulWidget {
  @override
  _CompanyConfigState createState() => _CompanyConfigState();
}

class _CompanyConfigState extends State<CompanyConfig> {
  TextEditingController txtCompany = TextEditingController();
  TextEditingController txtAlamat = TextEditingController();
  TextEditingController txtket = TextEditingController();
  TextEditingController txtterimakasih = TextEditingController();
  global_var gb = global_var();
  @override
  void initState() {
    // TODO: implement initState

    gb.getPref("nama_bisnis").then((val) {
      txtCompany.text = val;
      setState(() {});
    });
    gb.getPref("alamat_bisnis").then((val) {
      txtAlamat.text = val;
      setState(() {});
    });
    gb.getPref("ket_bisnis").then((val) {
      txtket.text = val;
      setState(() {});
    });
    gb.getPref("terimakasih_nota").then((val) {
      txtterimakasih.text = val;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyApp(
                      tab_id: 0,
                    )));
      },
      child: Scaffold(
        backgroundColor: FitnessAppTheme.tosca,
        appBar: FrxAppBar(
          "Profil Bisnis",
          backroute: "/sysconfig",
        ),
        body: WillPopScope(
            onWillPop: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyApp(
                            tab_id: 3,
                          )));
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                              style: TextStyle(
                                  fontSize: 20, color: FitnessAppTheme.white),
                              controller: txtCompany,
                              decoration: InputDecoration(
                                  labelText: 'Nama Bisnis',
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: FitnessAppTheme.white)),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: FitnessAppTheme.white),
                                    //  when the TextFormField in unfocused
                                  ),
                                  labelStyle:
                                      TextStyle(color: FitnessAppTheme.white))),
                          TextFormField(
                              style: TextStyle(
                                  fontSize: 20, color: FitnessAppTheme.white),
                              controller: txtAlamat,
                              maxLines: 3,
                              minLines: 1,
                              decoration: InputDecoration(
                                  labelText: 'Alamat',
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: FitnessAppTheme.white)),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: FitnessAppTheme.white),
                                    //  when the TextFormField in unfocused
                                  ),
                                  labelStyle:
                                      TextStyle(color: FitnessAppTheme.white))),
                          TextFormField(
                              style: TextStyle(
                                  fontSize: 20, color: FitnessAppTheme.white),
                              controller: txtket,
                              maxLines: 3,
                              minLines: 1,
                              decoration: InputDecoration(
                                  labelText: 'Keterangan',
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: FitnessAppTheme.white)),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: FitnessAppTheme.white),
                                    //  when the TextFormField in unfocused
                                  ),
                                  labelStyle:
                                      TextStyle(color: FitnessAppTheme.white))),
                          TextFormField(
                              style: TextStyle(
                                  fontSize: 20, color: FitnessAppTheme.white),
                              controller: txtterimakasih,
                              maxLines: 3,
                              minLines: 1,
                              decoration: InputDecoration(
                                  labelText: 'Ucapan Terima Kasih Nota',
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: FitnessAppTheme.white)),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: FitnessAppTheme.white),
                                    //  when the TextFormField in unfocused
                                  ),
                                  labelStyle:
                                      TextStyle(color: FitnessAppTheme.white)))
                        ],
                      ),
                    ),
                  ),
                  FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      color: FitnessAppTheme.yellow,
                      onPressed: () async {
                        gb.savePref("nama_bisnis", txtCompany.text);
                        gb.savePref("alamat_bisnis", txtAlamat.text);
                        gb.savePref("ket_bisnis", txtket.text);
                        gb.savePref("terimakasih_nota", txtterimakasih.text);
                        Navigator.of(context).pop();
                      },
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "Simpan",
                        style: TextStyle(
                            fontSize: 25.0, color: FitnessAppTheme.white),
                      ))
                ],
              ),
            )),
      ),
    );
  }
}

class PrinterConfig extends StatefulWidget {
  @override
  _PrinterConfigState createState() => _PrinterConfigState();
}

class _PrinterConfigState extends State<PrinterConfig> {
  global_var gb = global_var();
  String _printer_id = "";
  PrinterBluetoothManager _printManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _device = [];

  void searchPrinter() {
    _printManager.startScan(Duration(seconds: 2));
    _printManager.scanResults.listen((printers) {
      if (!mounted) return;
      setState(() => _device = printers);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    searchPrinter();
    gb.getPref("printer_id").then((val) {
      _printer_id = val;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyApp(
                        tab_id: 0,
                      )));
        },
        child: Scaffold(
          backgroundColor: FitnessAppTheme.tosca,
          appBar: FrxAppBar(
            "Pengaturan Printer",
            backroute: "/sysconfig",
          ),
          body: Container(
            padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
            child: ListView.separated(
              itemCount: _device.length,
              itemBuilder: (context, idx) {
                return ListTile(
                    onTap: () {
                      gb.savePref("printer_id", _device[idx].address);
                      Navigator.of(context).pop();
                    },
                    title: Text(
                      _device[idx].name,
                      style:
                          TextStyle(color: FitnessAppTheme.white, fontSize: 22),
                    ),
                    subtitle: Text(_device[idx].address,
                        style: TextStyle(color: FitnessAppTheme.white)),
                    leading: Icon(
                      Icons.print,
                      color: FitnessAppTheme.white,
                      size: 30,
                    ),
                    trailing: (_printer_id != "")
                        ? Icon(
                            Icons.check_circle,
                            color: FitnessAppTheme.yellow,
                            size: 30,
                          )
                        : Text(""));
              },
              separatorBuilder: (context, index) {
                return Divider(color: FitnessAppTheme.white,);
              },
            ),
          ),
        ));
  }
}
