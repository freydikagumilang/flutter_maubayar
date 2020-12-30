import 'package:maubayar/dbhelper.dart';

class produk {
  int prod_id;
  int _prod_kat_id;
  String _prod_nama;
  String _prod_barcode;
  String _prod_img;
  int _prod_countable;
  double _prod_stock;
  double _prod_price;
  double _prod_cogs;
  int _prod_suspended;
  String kat_nama;
  double komisi_kat;

  produk(
    this._prod_nama,
    this._prod_kat_id,
    this._prod_barcode,
    this._prod_img,
    this._prod_countable,
    this._prod_stock,
    this._prod_price,
    this._prod_cogs,
    this._prod_suspended,
    {this.kat_nama,this.komisi_kat}
  );
  produk.map(dynamic obj) {
    this._prod_nama = obj["prod_nama"];
    this._prod_kat_id = obj["prod_kat_id"];
    this._prod_barcode = obj["prod_barcode"];
    this._prod_img = obj["prod_img"];
    this._prod_countable = obj["prod_countable"];
    this._prod_stock = obj["prod_stock"];
    this._prod_price = obj["prod_price"];
    this._prod_cogs = obj["prod_cogs"];
    this._prod_suspended = obj["prod_suspended"];
    this.kat_nama = obj["kat_nama"];
  }

  String get prod_nama => _prod_nama;
  int get prod_kat_id => _prod_kat_id;
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
    map["prod_kat_id"] = prod_kat_id;
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
    
    // String sSQLdrop ="drop table produk ";
    // await dbClient.rawQuery(sSQLdrop);
    String sSQL = '''Create table IF NOT EXISTS produk 
    (prod_id INTEGER PRIMARY KEY autoincrement,
    prod_barcode TEXT,
    prod_nama TEXT,
    prod_kat_id INTEGER,
    prod_img TEXT,
    prod_countable INTEGER,
    prod_stock REAL,
    prod_price REAL,
    prod_cogs REAL,
    prod_suspended INTEGER,
    prod_sale_retention INTEGER
    )''';
    await dbClient.rawQuery(sSQL);
    
    sSQL = '''select * from produk 
              left join kategori
              on kat_id = prod_kat_id 
              where prod_nama like "%${cari}%" ''';
    List<Map> datalist = await dbClient.rawQuery(sSQL);
    List<produk> listproduk = new List();

    for (var i = 0; i < datalist.length; i++) {
      var row = new produk(
        datalist[i]['prod_nama'].toString(),
        datalist[i]['prod_kat_id'],
        datalist[i]['prod_barcode'].toString(),
        datalist[i]['prod_img'].toString(),
        datalist[i]['prod_countable'],
        datalist[i]['prod_stock'],
        datalist[i]['prod_price'],
        datalist[i]['prod_cogs'],
        datalist[i]['prod_suspended'],
        kat_nama: datalist[i]['kat_nama'],
        komisi_kat:datalist[i]['kat_komisi']
      );
      listproduk.add(row);
      row.setId(datalist[i]["prod_id"]);
    }
    return listproduk;
  }

  Future<List<produk>> SearchItemKasir(String cari) async {
    var dbClient = await DBHelper().setDb();
    
    // String sSQLdrop ="alter table produk add column prod_sale_retention INTEGER default 0";
    // await dbClient.rawQuery(sSQLdrop);
    
    
    String sSQL = '''select * from produk 
              left join kategori
              on kat_id = prod_kat_id 
              where prod_nama like "%${cari}%"
              order by prod_sale_retention desc''';
    List<Map> datalist = await dbClient.rawQuery(sSQL);
    List<produk> listproduk = new List();

    for (var i = 0; i < datalist.length; i++) {
      var row = new produk(
        datalist[i]['prod_nama'].toString(),
        datalist[i]['prod_kat_id'],
        datalist[i]['prod_barcode'].toString(),
        datalist[i]['prod_img'].toString(),
        datalist[i]['prod_countable'],
        datalist[i]['prod_stock'],
        datalist[i]['prod_price'],
        datalist[i]['prod_cogs'],
        datalist[i]['prod_suspended'],
        kat_nama: datalist[i]['kat_nama'],
        komisi_kat:datalist[i]['kat_komisi']
      );
      listproduk.add(row);
      row.setId(datalist[i]["prod_id"]);
    }
    return listproduk;
  }

  Future<int> saveProd(produk prod) async {
    var dbClient = await DBHelper().setDb();
    print("saveprod");
    int res = await dbClient.insert("produk", prod.toMap());
    print(prod.prod_price);
    return res;
  }
  Future<int> updateProd(produk prod) async {
    var dbClient = await DBHelper().setDb();
    int res = await dbClient.update("produk", prod.toMap(),
        where: "prod_id=?", whereArgs: <int>[prod.prod_id]);
    return res;
  }

  Future<int> deleteProd(int idprod) async {
    var dbClient = await DBHelper().setDb();
    int res = await dbClient.rawDelete(
        "delete from produk where prod_id = ?", [idprod]);
    return res;
  }
}
