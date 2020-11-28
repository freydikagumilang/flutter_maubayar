import 'package:maubayar/dbhelper.dart';

class produk {
  int prod_id;
  String _prod_nama;
  String _prod_barcode;
  String _prod_img;
  int _prod_countable;
  double _prod_stock;
  double _prod_price;
  double _prod_cogs;
  int _prod_suspended;

  produk(
    this._prod_nama,
    this._prod_barcode,
    this._prod_img,
    this._prod_countable,
    this._prod_stock,
    this._prod_price,
    this._prod_cogs,
    this._prod_suspended,
  );
  produk.map(dynamic obj) {
    this._prod_nama = obj["prod_nama"];
  }

  String get prod_nama => _prod_nama;
  String get prod_barcode => _prod_barcode;
  String get prod_img => _prod_img;
  int get prod_countable => _prod_countable;
  double get prod_stock => _prod_stock;
  double get prod_price => _prod_price;
  double get prod_cogs => _prod_cogs;
  int get prod_suspended => _prod_suspended;


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["prod_nama"] = prod_nama;
    map["prod_barcode"] = prod_barcode;
    map["prod_img"] = prod_img;
    map["prod_countable"] = prod_countable;
    map["prod_stock"] = prod_stock;
    map["prod_price"] = prod_price;
    map["prod_cogs"] = _prod_cogs;
    map["prod_suspended"] = prod_suspended;

    return map;
  }

  void setId(int id) {
    this.prod_id = id;
  }
}

class produkDAO {
  Future<List<produk>> getProd(String cari) async {
    var dbClient = await DBHelper().setDb();
    String sSQL = '''Create table IF NOT EXISTS produk 
    (prod_id INTEGER PRIMARY KEY autoincrement,
    prod_barcode TEXT,
    prod_nama TEXT,
    prod_img TEXT,
    prod_countable INTEGER,
    prod_stock REAL,
    prod_price REAL,
    prod_cogs REAL
    prod_suspended INTEGER,
    )''';
    await dbClient.rawQuery(sSQL);
    
    sSQL = '''select * from produk where prod_nama like "%${cari}%" ''';
    List<Map> datalist = await dbClient.rawQuery(sSQL);
    List<produk> listproduk = new List();

    for (var i = 0; i < datalist.length; i++) {
      var row = new produk(
        datalist[i]['prod_nama'].toString(),
        datalist[i]['prod_barcode'].toString(),
        datalist[i]['prod_img'].toString(),
        datalist[i]['prod_countable'],
        datalist[i]['prod_stock'],
        datalist[i]['prod_price'],
        datalist[i]['prod_cogs'],
        datalist[i]['prod_suspended'],
      );
      listproduk.add(row);
      row.setId(datalist[i]["prod_id"]);
    }
    return listproduk;
  }
  Future<int> saveProd(produk kat) async {
    var dbClient = await DBHelper().setDb();
    int res = await dbClient.insert("produk", kat.toMap());
    return res;
  }
  Future<int> updateKat(produk kat) async {
    var dbClient = await DBHelper().setDb();
    int res = await dbClient.update("produk", kat.toMap(),
        where: "prod_id=?", whereArgs: <int>[kat.prod_id]);
    return res;
  }

  Future<int> deleteProd(int idkat) async {
    var dbClient = await DBHelper().setDb();
    int res = await dbClient.rawDelete(
        "delete from produk where prod_id = ?", [idkat]);
    return res;
  }
}
