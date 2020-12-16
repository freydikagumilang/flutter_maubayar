import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maubayar/bloc/blockapster.dart';
import 'package:maubayar/bloc/blockasir.dart';
import 'package:maubayar/bloc/blocpelanggan.dart';
import 'package:maubayar/bloc/blocproduk.dart';
import 'package:maubayar/fintness_app_theme.dart';
import 'package:maubayar/global_var.dart';
import 'package:maubayar/main.dart';
import 'package:maubayar/models/kapstermodel.dart';
import 'package:maubayar/models/kasirmodel.dart';
import 'package:maubayar/models/pelangganmodel.dart';
import 'package:maubayar/models/produkmodel.dart';
import 'package:maubayar/txtformater.dart';
import 'package:maubayar/ui_view/template/frxappbar.dart';
import 'package:intl/intl.dart';
import 'package:maubayar/ui_view/transaksi/printnota.dart';
import 'package:uuid/uuid.dart';

class Kasir extends StatefulWidget {
  @override
  KasirState createState() => KasirState();
}

class KasirState extends State<Kasir> with SingleTickerProviderStateMixin {
  TabController tabct;
  List<kapster> kaps;
  List<produk> prod;
  List<pelanggan> plg;

  _movetabto(int tab_idx) {
    setState(() {
      tabct.animateTo(tab_idx);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    tabct = new TabController(vsync: this, length: 3);
    if (global_var.inv_temp_id == "") {
      var uuid = Uuid();
      global_var.inv_temp_id = uuid.v1();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabct.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyApp(
                      tab_id: 1,
                    )));
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<Getkapster>(create: (context) => Getkapster(kaps)),
          BlocProvider<Getproduk>(create: (context) => Getproduk(prod)),
          BlocProvider<Getpelanggan>(create: (context) => Getpelanggan(plg)),
          BlocProvider<InsertDet>(create: (context) => InsertDet(0.0)),
        ],
        child: Scaffold(
          appBar: FrxAppBar("Kasir", backroute: "/masterdata"),
          body: TabBarView(controller: tabct, children: [
            SearchItem(_movetabto),
            SearchPelanggan(_movetabto),
            KasirCheckout(_movetabto),
          ]),
          bottomNavigationBar: new Material(
              color: FitnessAppTheme.tosca,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    )
                  ],
                  color: FitnessAppTheme.tosca,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: TabBar(
                  controller: tabct,
                  indicatorColor: FitnessAppTheme.yellow,
                  indicatorWeight: 3,
                  tabs: [
                    Tab(icon: Icon(Icons.search), text: "Item"),
                    Tab(
                      icon: Icon(Icons.person),
                      text: "Pelanggan",
                    ),
                    Tab(
                      icon: Icon(Icons.payment_rounded),
                      text: "Bayar",
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class SearchItem extends StatefulWidget {
  final ValueChanged<int> tabnavigator;
  const SearchItem(this.tabnavigator);
  @override
  _SearchItemState createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  TextEditingController txtcariprod = TextEditingController();
  List<kapster> kaps;
  @override
  void initState() {
    // TODO: implement initState
    FocusManager.instance.primaryFocus.unfocus();
    Future.delayed(Duration.zero, () {
      Getproduk bloc = BlocProvider.of<Getproduk>(context);
      bloc.add("");
    });
  }

  @override
  Widget build(BuildContext context) {
    var NumFormat = new NumberFormat.compact(locale: "id");
    Getproduk bloc = BlocProvider.of<Getproduk>(context);
    return Container(
      padding: EdgeInsets.all(8),
      color: FitnessAppTheme.tosca,
      child: BlocBuilder<Getproduk, List<produk>>(
        builder: (context, dt_item) => Column(
          children: [
            Card(
                color: FitnessAppTheme.white,
                child: TextFormField(
                  controller: txtcariprod,
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
              child: ListView.builder(
                itemCount: (dt_item == null) ? 0 : dt_item.length,
                itemBuilder: (context, idx) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dt_item[idx].kat_nama,
                                style: TextStyle(
                                    fontSize: 14, color: FitnessAppTheme.grey),
                              ),
                              Padding(padding: EdgeInsets.all(2)),
                              Text(
                                dt_item[idx].prod_nama,
                                style: TextStyle(fontSize: 20),
                              ),
                              Padding(padding: EdgeInsets.all(2)),
                              Text(
                                NumFormat.format(dt_item[idx].prod_price)
                                    .toString(),
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          GestureDetector(
                            child: Icon(
                              Icons.add_circle_outline,
                              size: 40,
                              color: FitnessAppTheme.tosca,
                            ),
                            onTap: () {
                              AlertDialog pilKapster = AlertDialog(
                                title: Text("Beuatycian"),
                                content: PilihKapster(
                                    widget.tabnavigator, dt_item[idx]),
                              );
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return BlocProvider<Getkapster>.value(
                                      value: Getkapster(kaps),
                                      child: BlocProvider<InsertDet>.value(
                                        value: InsertDet(0.0),
                                        child: pilKapster,
                                      ),
                                    );
                                  });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchPelanggan extends StatefulWidget {
  final ValueChanged<int> tabnavigator;
  const SearchPelanggan(this.tabnavigator);
  @override
  _SearchPelangganState createState() => _SearchPelangganState();
}

class _SearchPelangganState extends State<SearchPelanggan> {
  TextEditingController txtcariplg = TextEditingController();
  List<pelanggan> listplg;

  @override
  Widget build(BuildContext context) {
    Getpelanggan bloc_plg = BlocProvider.of<Getpelanggan>(context);
    return Container(
        padding: EdgeInsets.all(8),
        color: FitnessAppTheme.tosca,
        child: BlocBuilder<Getpelanggan, List<pelanggan>>(
          builder: (context, dt_plg) => Column(
            children: [
              Card(
                  color: FitnessAppTheme.white,
                  child: TextFormField(
                    controller: txtcariplg,
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                    decoration: InputDecoration(
                        hintText: "Nama / No.HP Pelanggan",
                        prefixIcon: Icon(
                          Icons.search,
                          color: FitnessAppTheme.tosca,
                        )),
                    onChanged: (val) {
                      Future.delayed(Duration(milliseconds: 500), () {
                        bloc_plg.add(val);
                      });
                    },
                  )),
              Expanded(
                child: ListView.builder(
                  itemCount: (dt_plg == null) ? 0 : dt_plg.length,
                  itemBuilder: (context, idx) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dt_plg[idx].pelanggan_nama,
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  dt_plg[idx].pelanggan_hp.toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: FitnessAppTheme.grey),
                                ),
                              ],
                            ),
                            GestureDetector(
                              child: Icon(
                                Icons.check_circle_outline,
                                size: 30,
                                color: FitnessAppTheme.tosca,
                              ),
                              onTap: () {
                                setState(() {
                                  global_var.kasirpelanggan = pelanggan(
                                      dt_plg[idx].pelanggan_nama,
                                      dt_plg[idx].pelanggan_hp,
                                      dt_plg[idx].pelanggan_alamat);
                                  global_var.kasirpelanggan
                                      .setId(dt_plg[idx].pelanggan_id);
                                });
                                widget.tabnavigator(2);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

class KasirCheckout extends StatefulWidget {
  final ValueChanged<int> tabnavigator;
  KasirCheckout(this.tabnavigator);
  @override
  _KasirCheckoutState createState() => _KasirCheckoutState();
}

class _KasirCheckoutState extends State<KasirCheckout> {
  var NumFormat = new NumberFormat.compact(locale: "en");
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: FitnessAppTheme.tosca,
      child: ListView(
        children: [
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Aloodie Beauty Studio",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text("Tanjung Anom, Solobaru, Sukoharjo"),
                  Text("Wa: 08467324824974"),
                  Text("IG : @aloodie.beauty"),
                  Padding(padding: EdgeInsets.all(10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "No.Inv",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text("Tgl", style: TextStyle(fontSize: 16)),
                          Text("Pelanggan", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("5480653458", style: TextStyle(fontSize: 16)),
                          Text("01-Jan-2021", style: TextStyle(fontSize: 16)),
                          GestureDetector(
                              onTap: () {
                                widget.tabnavigator(1);
                              },
                              child: Text(
                                ((global_var.kasirpelanggan == null)
                                    ? "Pilih Pelanggan"
                                    : global_var.kasirpelanggan.pelanggan_nama),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: FitnessAppTheme.nearlyBlue),
                              )),
                        ],
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Table(
                    border: TableBorder(
                      top: BorderSide(width: 1),
                    ),
                    columnWidths: {
                      0: FractionColumnWidth(0.5),
                      1: FractionColumnWidth(0.2),
                      2: FractionColumnWidth(0.3)
                    },
                    children: [
                      TableRow(
                          //table header
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            //                   <--- left side
                            color: Colors.black,
                            width: 1.0,
                          ))),
                          children: [
                            Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Text(
                                  "Item",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text("Qty",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                            ),
                            Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Text("Nominal",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600))),
                          ]),
                      if (global_var.detailkasir != null)
                        for (int idx = 0;
                            idx < global_var.detailkasir.length;
                            idx++)
                          TableRow(children: [
                            Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          child: Icon(
                                            Icons.close,
                                            size: 16,
                                            color: FitnessAppTheme.redtext,
                                          ),
                                          onTap: () async {
                                            global_var.total -= global_var
                                                .detailkasir[idx].invdet_total;
                                            await global_var.detailkasir
                                                .removeAt(idx);
                                            setState(() {
                                              global_var.kembalian =
                                                  global_var.pembayaran +
                                                      global_var.diskon -
                                                      global_var.total;
                                            });
                                          },
                                        ),
                                        Text(
                                            global_var.detailkasir[idx]
                                                .invdet_prod_nama,
                                            style: TextStyle(fontSize: 22)),
                                      ],
                                    ),
                                    Text(
                                        "Btc : " +
                                            (global_var.detailkasir[idx]
                                                    .invdet_kapster_name ??
                                                "-"),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: FitnessAppTheme.grey)),
                                    Text(global_var.detailkasir[idx].invdet_ket,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: FitnessAppTheme.grey))
                                  ],
                                )),
                            Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text(
                                  NumFormat.format(global_var
                                          .detailkasir[idx].invdet_qty)
                                      .toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18)),
                            ),
                            Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Text(
                                    NumFormat.format(global_var
                                        .detailkasir[idx].invdet_total),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontSize: 18))),
                          ]),
                      TableRow(
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ))),
                          children: [
                            Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Text("Total",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400))),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                  (global_var.detailkasir == null)
                                      ? "0"
                                      : global_var.detailkasir.length
                                          .toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400)),
                            ),
                            Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Text(NumFormat.format(global_var.total),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400))),
                          ]),
                      TableRow(children: [
                        Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text("Potongan",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400))),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text("",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.all(2.0),
                            child: GestureDetector(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.edit,
                                    size: 22,
                                    color: FitnessAppTheme.tosca,
                                  ),
                                  Text(
                                      NumFormat.format(
                                          (global_var.diskon ?? 0)),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                              onTap: () async {
                                AlertDialog inputPot = AlertDialog(
                                  title: Text("Potongan"),
                                  content: InputPotongan(),
                                );
                                var setpot = await showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return inputPot;
                                    });

                                if (setpot) {
                                  setState(() {});
                                }
                              },
                            )),
                      ]),
                      TableRow(children: [
                        Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text("Pembayaran",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400))),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text("",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400)),
                        ),
                        Padding(
                            padding: EdgeInsets.all(2.0),
                            child: GestureDetector(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.edit,
                                    size: 22,
                                    color: FitnessAppTheme.tosca,
                                  ),
                                  Text(
                                      NumFormat.format(
                                          (global_var.pembayaran ?? 0)),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                              onTap: () async {
                                AlertDialog inputBayar = AlertDialog(
                                  title: Text("Pembayaran"),
                                  content: InputBayar(),
                                );
                                var paid = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return inputBayar;
                                    });

                                if (paid == true) {
                                  setState(() {});
                                }
                              },
                            )),
                      ]),
                      TableRow(children: [
                        Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                                (global_var.kembalian >= 0)
                                    ? "Kembali"
                                    : "Kurang",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: (global_var.kembalian > 0)
                                        ? Colors.black
                                        : FitnessAppTheme.redtext))),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text("",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                              NumFormat.format((global_var.kembalian).abs()),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: (global_var.kembalian >= 0)
                                      ? Colors.black
                                      : FitnessAppTheme.redtext)),
                        ),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(8)),
          RaisedButton(
            elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>PrintNota()));
              },
              color: Colors.amber[700],
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    Text(
                      "Simpan Transaksi",
                      style: TextStyle(fontSize: 25.0,color: Colors.white),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class PilihKapster extends StatefulWidget {
  final ValueChanged<int> tabnavigator;
  final produk add_prod;
  const PilihKapster(this.tabnavigator, this.add_prod);
  @override
  _PilihKapsterState createState() => _PilihKapsterState();
}

class _PilihKapsterState extends State<PilihKapster> {
  int selectedkapster;
  kapster detkapster;
  TextEditingController txtketItem = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    FocusManager.instance.primaryFocus.unfocus();
    Future.delayed(Duration.zero, () {
      Getkapster bloc = BlocProvider.of<Getkapster>(context);
      bloc.add("");
    });
  }

  @override
  Widget build(BuildContext context) {
    InsertDet _insertDet = BlocProvider.of<InsertDet>(context);
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: BlocBuilder<Getkapster, List<kapster>>(
        builder: (context, snapshot) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton(
                elevation: 3,
                underline: SizedBox(),
                isExpanded: true,
                value: selectedkapster,
                items: (snapshot == null)
                    ? []
                    : snapshot.map((item) {
                        return DropdownMenuItem(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 3.0),
                                child: Icon(Icons.face,
                                    color: FitnessAppTheme.tosca),
                              ),
                              Text(
                                item.kapster_nama,
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          value:
                              (item.kapster_id == null) ? 0 : item.kapster_id,
                        );
                      }).toList(),
                onChanged: (selItem) {
                  setState(() {
                    selectedkapster = selItem;
                    detkapster = snapshot[
                        snapshot.indexWhere((dt) => dt.kapster_id == selItem)];
                    print(detkapster.kapster_nama);
                  });
                }),
            Text(
              "Catatan:",
              style: TextStyle(fontSize: 14),
            ),
            TextFormField(
              controller: txtketItem,
              style: TextStyle(fontSize: 16.0, color: Colors.black),
              minLines: 5, //Normal textInputField will be displayed
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(hintText: "Catatan"),
            ),
            Padding(padding: EdgeInsets.all(6)),
            FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                onPressed: () async {
                  //add to list
                  produk _prod = widget.add_prod;
                  int _date = DateTime.now().microsecondsSinceEpoch;
                  invoicedet itemdet = await invoicedet(
                      global_var.inv_temp_id,
                      _prod.prod_id,
                      txtketItem.text.toString(),
                      1,
                      _prod.prod_price,
                      _prod.prod_price,
                      _prod.komisi_kat / 100 * _prod.prod_price,
                      selectedkapster,
                      _date,
                      0,
                      0,
                      invdet_prod_nama: _prod.prod_nama,
                      invdet_kapster_name: detkapster.kapster_nama);
                  _insertDet.add(itemdet);
                  Navigator.of(context).pop(true);
                  widget.tabnavigator(2);
                },
                color: FitnessAppTheme.tosca,
                child: Text(
                  "Tambah Ke List",
                  style:
                      TextStyle(fontSize: 18.0, color: FitnessAppTheme.white),
                ))
          ],
        ),
      ),
    );
  }
}

class InputPotongan extends StatefulWidget {
  @override
  _InputPotonganState createState() => _InputPotonganState();
}

class _InputPotonganState extends State<InputPotongan> {
  TextEditingController txtPot = TextEditingController();
  final f = NumberFormat("#,###", "id");

  @override
  void initState() {
    // TODO: implement initState
    txtPot.text = f.format((global_var.diskon ?? 0).round()).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextFormField(
            controller: txtPot,
            inputFormatters: [NumericTextFormatter()],
            style: TextStyle(fontSize: 22.0, color: Colors.black),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "Pembayaran"),
          ),
          Padding(padding: EdgeInsets.all(5)),
          FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              onPressed: () {
                setState(() {
                  global_var.diskon = double.parse((txtPot.text == "")
                      ? 0
                      : txtPot.text.replaceAll(".", ""));
                  global_var.kembalian = global_var.pembayaran +
                      global_var.diskon -
                      global_var.total;
                });

                Navigator.of(context).pop(true);
              },
              color: FitnessAppTheme.tosca,
              child: Text(
                "Potongan",
                style: TextStyle(fontSize: 18.0, color: FitnessAppTheme.white),
              ))
        ],
      ),
    );
  }
}

class InputBayar extends StatefulWidget {
  @override
  _InputBayarState createState() => _InputBayarState();
}

class _InputBayarState extends State<InputBayar> {
  TextEditingController txtbayar = TextEditingController();
  bool isTunai = true;
  final f = NumberFormat("#,###", "id");

  @override
  void initState() {
    // TODO: implement initState
    txtbayar.text = f.format((global_var.pembayaran ?? 0).round()).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Tunai",
                style: TextStyle(fontSize: 18),
              ),
              Switch(
                  activeColor: FitnessAppTheme.tosca,
                  inactiveTrackColor: Colors.red[200],
                  inactiveThumbColor: FitnessAppTheme.nearlyBlue,
                  value: isTunai,
                  onChanged: (newVal) {
                    setState(() {
                      isTunai = newVal;
                    });
                  }),
            ],
          ),
          TextFormField(
            controller: txtbayar,
            inputFormatters: [NumericTextFormatter()],
            style: TextStyle(fontSize: 22.0, color: Colors.black),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "Pembayaran"),
          ),
          Padding(padding: EdgeInsets.all(5)),
          FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              onPressed: () {
                setState(() {
                  global_var.pembayaran = double.parse((txtbayar.text == "")
                      ? 0
                      : txtbayar.text.replaceAll(".", ""));
                  global_var.isTunai = (isTunai) ? 1 : 0;
                  global_var.kembalian = global_var.pembayaran +
                      global_var.diskon -
                      global_var.total;
                });
                Navigator.of(context).pop(true);
              },
              color: FitnessAppTheme.tosca,
              child: Text(
                "Bayar",
                style: TextStyle(fontSize: 18.0, color: FitnessAppTheme.white),
              ))
        ],
      ),
    );
  }
}
