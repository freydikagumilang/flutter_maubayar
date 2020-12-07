import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maubayar/bloc/blockapster.dart';
import 'package:maubayar/bloc/blocpelanggan.dart';
import 'package:maubayar/bloc/blocproduk.dart';
import 'package:maubayar/fintness_app_theme.dart';
import 'package:maubayar/global_var.dart';
import 'package:maubayar/main.dart';
import 'package:maubayar/models/kapstermodel.dart';
import 'package:maubayar/models/pelangganmodel.dart';
import 'package:maubayar/models/produkmodel.dart';
import 'package:maubayar/ui_view/template/frxappbar.dart';
import 'package:intl/intl.dart';

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
        ],
        child: Scaffold(
          appBar: FrxAppBar("Kasir", backroute: "/masterdata"),
          body: TabBarView(controller: tabct, children: [
            SearchItem(),
            SearchPelanggan(_movetabto),
            KasirCheckout(_movetabto),
          ]),
          bottomNavigationBar: new Material(
              color: FitnessAppTheme.tosca,
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
              )),
        ),
      ),
    );
  }
}

class TabBarKasir extends StatefulWidget {
  @override
  _TabBarKasirState createState() => _TabBarKasirState();
}

class _TabBarKasirState extends State<TabBarKasir> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SearchItem extends StatefulWidget {
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
                                content: PilihKapster(),
                              );
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return BlocProvider<Getkapster>.value(
                                      value: Getkapster(kaps),
                                      child: pilKapster,
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
  var NumFormat = new NumberFormat.compact(locale: "id");
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: FitnessAppTheme.tosca,
      child: Card(
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
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text("Qty",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                        ),
                        Padding(
                            padding:  EdgeInsets.all(2.0),
                            child: Text("Nominal",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600))),
                      ]),
                  TableRow(children: [
                    Padding(
                        padding:  EdgeInsets.all(2.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Eyelash Natural",
                                style: TextStyle(fontSize: 18)),
                            Text("* Ukuran 12",
                                style: TextStyle(
                                    fontSize: 16, color: FitnessAppTheme.grey))
                          ],
                        )),
                    Padding(
                      padding:  EdgeInsets.all(2.0),
                      child: Text("1",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18)),
                    ),
                    Padding(
                        padding:  EdgeInsets.all(2.0),
                        child: Text(NumFormat.format(100000),
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 18))),
                  ]),
                  TableRow(children: [
                    Padding(
                        padding:  EdgeInsets.all(2.0),
                        child: Text("Eyelash Volume",
                            style: TextStyle(fontSize: 18))),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text("1",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18)),
                    ),
                    Padding(
                        padding:  EdgeInsets.all(2.0),
                        child: Text(NumFormat.format(150000),
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
                            padding:  EdgeInsets.all(2.0),
                            child: Text("Total",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400))),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text("2",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400)),
                        ),
                        Padding(
                            padding:  EdgeInsets.all(2.0),
                            child: Text(NumFormat.format(250000),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400))),
                      ]),
                  TableRow(children: [
                    Padding(
                        padding:  EdgeInsets.all(2.0),
                        child: Text("Potongan",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400))),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text("",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                    Padding(
                        padding:  EdgeInsets.all(2.0),
                        child: Text(NumFormat.format(10000),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400))),
                  ]),
                  TableRow(children: [
                    Padding(
                        padding:  EdgeInsets.all(2.0),
                        child: Text("Bayar",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400))),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text("",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400)),
                    ),
                    Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(NumFormat.format(240000),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400))),
                  ]),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PilihKapster extends StatefulWidget {
  @override
  _PilihKapsterState createState() => _PilihKapsterState();
}

class _PilihKapsterState extends State<PilihKapster> {
  int selectedkapster;
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
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                color: FitnessAppTheme.tosca,
                child: Text(
                  "Pilih",
                  style:
                      TextStyle(fontSize: 18.0, color: FitnessAppTheme.white),
                ))
          ],
        ),
      ),
    );
  }
}
