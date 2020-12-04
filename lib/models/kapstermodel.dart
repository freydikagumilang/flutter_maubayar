import 'package:maubayar/dbhelper.dart';

class kapster {
  int kapster_id=0;
  String _kapster_nama="";
  String _kapster_hp="";
  String _kapster_alamat="";

  kapster(
    this._kapster_nama,
    this._kapster_hp,
    this._kapster_alamat,
  );
  kapster.map(dynamic obj) {
    this._kapster_nama = obj["kapster_nama"];
    this._kapster_hp = obj["_kapster_hp"];
    this._kapster_alamat = obj["_kapster_alamat"];
  }

  String get kapster_nama => _kapster_nama;
  String get kapster_hp => _kapster_hp;
  String get kapster_alamat => _kapster_alamat;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["kapster_nama"] = kapster_nama;
    map["kapster_hp"] = kapster_hp.toString();
    map["kapster_alamat"] = kapster_alamat;

    return map;
  }

  void setId(int id) {
    this.kapster_id = id;
  }
}

class KapsterDAO {
  Future<List<kapster>> getKapster(String cari) async {
    var dbClient = await DBHelper().setDb();
    await dbClient.rawQuery("Create table IF NOT EXISTS kapster (kapster_id INTEGER PRIMARY KEY autoincrement,kapster_nama string,kapster_hp string,kapster_alamat string)");
    
    List<Map> datalist = await dbClient.rawQuery("select * from kapster where kapster_nama like '%${cari}%' or kapster_hp like '%${cari}%'");
    List<kapster> listkapster = new List();

    for (var i = 0; i < datalist.length; i++) {
      var row = new kapster(
        datalist[i]['kapster_nama'].toString(),
        datalist[i]['kapster_hp'].toString(),
        datalist[i]['kapster_alamat'].toString(),
      );
      listkapster.add(row);
      row.setId(datalist[i]["kapster_id"]);
    }
    return listkapster;
  }
  Future<int> saveKapster(kapster kapster) async {
    var dbClient = await DBHelper().setDb();
    int res = await dbClient.insert("kapster", kapster.toMap());
    return res;
  }
  Future<int> updateKapster(kapster kapster) async {
    var dbClient = await DBHelper().setDb();
    int res = await dbClient.update("kapster", kapster.toMap(),
        where: "kapster_id=?", whereArgs: <int>[kapster.kapster_id]);
    return res;
  }

  Future<int> deleteKapster(int idkapster) async {
    var dbClient = await DBHelper().setDb();
    int res = await dbClient.rawDelete(
        "delete from kapster where kapster_id = ?", [idkapster]);
    return res;
  }
}