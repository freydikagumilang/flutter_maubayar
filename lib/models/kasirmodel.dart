import 'package:maubayar/dbhelper.dart';
import 'package:maubayar/global_var.dart';
import 'package:maubayar/ui_view/transaksi/kasir.dart';

class invoice {
  int inv_id;
  int _inv_plg_id;
  String _inv_no;
  String _inv_date;
  double _inv_total_bruto;
  double _inv_diskon;
  double _inv_total_net;
  double _inv_paid;
  int _inv_iscash;
  int _inv_created_at;
  int _inv_updated_at;
  int _inv_deleted_at;
  String inv_plg_nama;
  String inv_plg_hp;
  List<invoicedet> details;

  invoice(
      this._inv_no,
      this._inv_date,
      this._inv_plg_id,
      this._inv_total_bruto,
      this._inv_diskon,
      this._inv_total_net,
      this._inv_created_at,
      this._inv_updated_at,
      this._inv_deleted_at,
      {this.inv_plg_nama,
      this.inv_plg_hp,
      this.details});
  invoice.map(dynamic obj) {
    this._inv_no = obj["inv_no"];
    this._inv_date = obj["inv_date"];
    this._inv_plg_id = obj["inv_plg_id"];
    this._inv_total_bruto = obj["inv_total_bruto"];
    this._inv_diskon = obj["inv_diskon"];
    this._inv_total_net = obj["inv_total_net"];
    this._inv_created_at = obj["inv_created_at"];
    this._inv_updated_at = obj["inv_updated_at"];
    this._inv_deleted_at = obj["inv_deleted_at"];
    this.inv_plg_nama = obj["inv_plg_nama"];
    this.inv_plg_hp = obj["inv_plg_hp"];
    this.details = obj["details"];
  }

  String get inv_no => _inv_no;
  String get inv_date => _inv_date;
  double get inv_total_bruto => _inv_total_bruto;
  double get inv_diskon => _inv_diskon;
  double get inv_total_net => _inv_total_net;
  double get inv_paid => _inv_paid;
  int get inv_iscash => _inv_iscash;
  int get inv_created_at => _inv_created_at;
  int get inv_updated_at => _inv_updated_at;
  int get inv_deleted_at => _inv_deleted_at;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["inv_no"] = inv_no;
    map["inv_date"] = inv_date;
    map["inv_total_bruto"] = inv_total_bruto;
    map["inv_diskon"] = inv_diskon;
    map["inv_total_net"] = inv_total_net;
    map["inv_paid"] = inv_paid;
    map["inv_iscash"] = inv_iscash;
    map["inv_created_at"] = inv_created_at;
    map["inv_deleted_at"] = inv_deleted_at;

    return map;
  }

  void setId(int id) {
    this.inv_id = id;
  }
}

class invoicedet {
  int invdet_id;
  int invdet_inv_id;
  int _invdet_tmp_id;
  int _invdet_item_id;
  String _invdet_ket;
  double _invdet_qty;
  double _invdet_price;
  double _invdet_total;
  double _invdet_komisi;
  int _invdet_kapster_id;
  int _invdet_created_at;
  int _invdet_updated_at;
  int _invdet_deleted_at;
  String invdet_prod_nama;
  String invdet_kapster_name;
  String invdet_kat_nama;
  double invdet_kat_komisi;

  invoicedet(
      this._invdet_tmp_id,
      this._invdet_item_id,
      this._invdet_ket,
      this._invdet_qty,
      this._invdet_price,
      this._invdet_total,
      this._invdet_komisi,
      this._invdet_kapster_id,
      this._invdet_created_at,
      this._invdet_updated_at,
      this._invdet_deleted_at,
      {this.invdet_prod_nama,
      this.invdet_kapster_name,
      this.invdet_kat_nama,
      this.invdet_kat_komisi});

  invoicedet.map(dynamic obj) {
    this._invdet_tmp_id = obj["invdet_tmp_id"];
    this._invdet_item_id = obj["invdet_item_id"];
    this._invdet_ket = obj["invdet_ket"];
    this._invdet_qty = obj["invdet_qty"];
    this._invdet_price = obj["invdet_price"];
    this._invdet_total = obj["invdet_total"];
    this._invdet_komisi = obj["invdet_komisi"];
    this._invdet_kapster_id = obj["invdet_kapster_id"];
    this._invdet_created_at = obj["invdet_created_at"];
    this._invdet_updated_at = obj["invdet_updated_at"];
    this._invdet_deleted_at = obj["invdet_deleted_at"];
    this.invdet_prod_nama = obj["invdet_prod_nama"];
    this.invdet_kapster_name = obj["invdet_kapster_name"];
    this.invdet_kat_nama = obj["invdet_kat_nama"];
    this.invdet_kat_komisi = obj["invdet_kat_komisi"];
  }

  int get invdet_tmp_id => invdet_tmp_id;
  int get invdet_item_id => _invdet_item_id;
  String get invdet_ket => _invdet_ket;
  double get invdet_qty => _invdet_qty;
  double get invdet_price => _invdet_price;
  double get invdet_total => _invdet_total;
  double get invdet_komisi => _invdet_komisi;
  int get invdet_kapster_id => _invdet_kapster_id;
  int get invdet_created_at => _invdet_created_at;
  int get invdet_updated_at => _invdet_updated_at;
  int get invdet_deleted_at => _invdet_deleted_at;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["invdet_inv_id"] = 0;
    map["invdet_item_id"] = invdet_item_id;
    map["invdet_ket"] = invdet_ket;
    map["invdet_qty"] = invdet_qty;
    map["invdet_price"] = invdet_price;
    map["invdet_total"] = invdet_total;
    map["invdet_komisi"] = invdet_komisi;
    map["invdet_kapster_id"] = invdet_kapster_id;
    map["invdet_created_at"] = invdet_created_at;
    map["invdet_updated_at"] = invdet_updated_at;
    map["invdet_deleted_at"] = invdet_deleted_at;

    return map;
  }

  void setId(int id) {
    this.invdet_id = id;
  }

  void setInvId(int id) {
    this.invdet_inv_id = id;
  }
}

class invoiceDAO {
  Future<List<invoice>> getInv(String cari) async {
    var dbClient = await DBHelper().setDb();
    String sSQL =
        '''Create table IF NOT EXISTS invoice (inv_id INTEGER PRIMARY KEY autoincrement,inv_no string,inv_plg_id int,
                  inv_date string, inv_total_bruto real, inv_diskon real,inv_total_net real,
                  inv_paid real,inv_iscash integer,inv_created_at integer,inv_updated_at integer DEFAULT 0 ,inv_deleted_at integer DEFAULT 0  )''';

    await dbClient.rawQuery(sSQL);
    sSQL = '''select * 
    from invoice 
    inner join pelanggan
      on inv_plg_id = pelanggan_id
    where (inv_no like "%${cari}%" or pelanggan_nama like "%${cari}%" or 
    pelanggan_hp like "%${cari}%") and  inv_deleted_at = 0''';

    List<Map> datalist = await dbClient.rawQuery(sSQL);
    List<invoice> list_inv = new List();

    for (var i = 0; i < datalist.length; i++) {
      var row = new invoice(
        datalist[i]['inv_no'].toString(),
        datalist[i]['inv_date'].toString(),
        datalist[i]['inv_plg_id'],
        datalist[i]['inv_total_bruto'],
        datalist[i]['inv_diskon'],
        datalist[i]['inv_total_net'],
        datalist[i]['inv_created_at'],
        datalist[i]['inv_updated_at'],
        datalist[i]['inv_deleted_at'],
        inv_plg_hp: datalist[i]['pelanggan_hp'],
        inv_plg_nama: datalist[i]['pelanggan_nama'],
      );
      list_inv.add(row);
      row.setId(datalist[i]["inv_id"]);
    }
    return list_inv;
  }

  Future<int> saveInv(invoice inv) async {
    var dbClient = await DBHelper().setDb();
    String sSQL =
        '''Create table IF NOT EXISTS invoice (inv_id INTEGER PRIMARY KEY autoincrement,inv_no string,inv_plg_id int,
                  inv_date string, inv_total_bruto real, inv_diskon real,inv_total_net real,
                  inv_paid real,inv_iscash integer,inv_created_at integer,inv_updated_at integer DEFAULT 0 ,inv_deleted_at integer DEFAULT 0  )''';

    await dbClient.rawQuery(sSQL);
    String sSQLdet = '''Create table IF NOT EXISTS invoicedet (
      invdet_id INTEGER PRIMARY KEY autoincrement,
      invdet_inv_id int,invdet_item_id int,
      invdet_ket string, invdet_qty real, invdet_price real,invdet_total real,
      invdet_komisi real,invdet_kapster_id integer,invdet_created_at integer,invdet_updated_at integer DEFAULT 0 ,
      invdet_deleted_at integer DEFAULT 0  )''';

    await dbClient.rawQuery(sSQLdet);

    int res = await dbClient.insert("invoice", inv.toMap());

    // print("inv_id:" + res.toString());
    List<invoicedet> _details = inv.details;
    for (var i = 0; i < _details.length; i++) {
      int _prod_id = _details[i].invdet_item_id;

      await _details[i].setInvId(res);
      await dbClient.insert("invoicedet", _details[i].toMap());
      

      sSQLdet = '''update produk set prod_sale_retention = prod_sale_retention + 1
                where prod_id = $_prod_id ''';
      print(sSQLdet);
      await dbClient.rawQuery(sSQLdet);


    }
    return res;
  }

  Future<int> updateInv(invoice inv) async {
    var dbClient = await DBHelper().setDb();
    int res = await dbClient.update("invoice", inv.toMap(),
        where: "inv_id=?", whereArgs: <int>[inv.inv_id]);
    return res;
  }

  Future<int> deleteInv(int inv_id) async {
    var dbClient = await DBHelper().setDb();
    int res = await dbClient.rawDelete(
        "update invoice deleted_at = strftime('%s', 'now')  where inv_id = ?",
        [inv_id]);
    await dbClient.rawDelete(
        "update invoicedet deleted_at = strftime('%s', 'now')  where invdet_inv_id = ?",
        [inv_id]);
    return res;
  }

  Future<List<invoicedet>> getInvDet(int invdet_inv_id) async {
    var dbClient = await DBHelper().setDb();
    String sSQL = '''Create table IF NOT EXISTS invoicedet (
      invdet_id INTEGER PRIMARY KEY autoincrement,
      invdet_inv_id int,invdet_item_id int,
      invdet_ket string, invdet_qty real, invdet_price real,invdet_total real,
      invdet_komisi real,invdet_kapster_id integer,invdet_created_at integer,invdet_updated_at integer DEFAULT 0 ,
      invdet_deleted_at integer DEFAULT 0  )''';

    await dbClient.rawQuery(sSQL);
    sSQL = '''select * 
    from invoicedet 
    inner join produk
      on invdet_item_id = prod_id
    inner join kategori
      on kat_id = prod_kat_id
    inner join kapster
      on kapster_id = invdet_kapster_id
    where invdet_inv_id like "%${invdet_inv_id}%"  invdet_deleted_at = 0''';

    List<Map> datalist = await dbClient.rawQuery(sSQL);
    List<invoicedet> list_invdet = new List();

    for (var i = 0; i < datalist.length; i++) {

      var row = new invoicedet(
        datalist[i]['invdet_inv_id'],
        datalist[i]['invdet_item_id'],
        datalist[i]['invdet_ket'],
        datalist[i]['invdet_qty'],
        datalist[i]['invdet_price'],
        datalist[i]['invdet_total'],
        datalist[i]['invdet_komisi'],
        datalist[i]['invdet_kapster_id'],
        datalist[i]['invdet_created_at'],
        datalist[i]['invdet_updated_at'],
        datalist[i]['invdet_deleted_at'],
        invdet_prod_nama: datalist[i]['prod_nama'],
        invdet_kapster_name: datalist[i]['kapster_nama'],
        invdet_kat_komisi: datalist[i]['kat_komisi'],
        invdet_kat_nama: datalist[i]['kat_nama'],
      );
      list_invdet.add(row);
      row.setId(datalist[i]["invdet_id"]);
    }
    return list_invdet;
  }
}
