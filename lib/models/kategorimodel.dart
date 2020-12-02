import 'package:maubayar/dbhelper.dart';

class kategori {
  int kat_id=0;
  String _kat_nama="";

  kategori(
    this._kat_nama,
  );
  kategori.map(dynamic obj) {
    this._kat_nama = obj["kat_nama"];
  }

  String get kat_nama => _kat_nama;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["kat_nama"] = kat_nama;

    return map;
  }

  void setId(int id) {
    this.kat_id = id;
  }
}

class kategoriDAO {
  Future<List<kategori>> getKat(String cari) async {
    var dbClient = await DBHelper().setDb();
    await dbClient.rawQuery("Create table IF NOT EXISTS kategori (kat_id INTEGER PRIMARY KEY autoincrement,kat_nama string)");
    

    List<Map> datalist = await dbClient.rawQuery("select * from kategori where kat_nama like '%${cari}%' ");
    List<kategori> listkategori = new List();

    for (var i = 0; i < datalist.length; i++) {
      var row = new kategori(
        datalist[i]['kat_nama'].toString(),
      );
      listkategori.add(row);
      row.setId(datalist[i]["kat_id"]);
    }
    return listkategori;
  }
  Future<int> saveKat(kategori kat) async {
    var dbClient = await DBHelper().setDb();
    int res = await dbClient.insert("kategori", kat.toMap());
    return res;
  }
  Future<int> updateKat(kategori kat) async {
    var dbClient = await DBHelper().setDb();
    int res = await dbClient.update("kategori", kat.toMap(),
        where: "kat_id=?", whereArgs: <int>[kat.kat_id]);
    return res;
  }

  Future<int> deleteKat(int idkat) async {
    var dbClient = await DBHelper().setDb();
    int res = await dbClient.rawDelete(
        "delete from kategori where kat_id = ?", [idkat]);
    return res;
  }
}
