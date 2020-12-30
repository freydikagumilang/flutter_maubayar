import 'package:maubayar/dbhelper.dart';

class bukukas {
  int bukukas_id;
  double _bukukas_tunai;
  double _bukukas_non_tunai;
  int _bukukas_created_at;
  int _bukukas_updated_at;
  int _bukukas_deleted_at;
  bukukasdet detail_bukukas;

  bukukas(
      this._bukukas_tunai,
      this._bukukas_non_tunai,
      this._bukukas_created_at,
      this._bukukas_updated_at,
      this._bukukas_deleted_at,
      {this.detail_bukukas});

  bukukas.map(dynamic obj) {
    this._bukukas_tunai = obj["bukukas_tunai"];
    this._bukukas_non_tunai = obj["bukukas_non_tunai"];
    this._bukukas_created_at = obj["bukukas_created_at"];
    this._bukukas_updated_at = obj["bukukas_updated_at"];
    this._bukukas_deleted_at = obj["bukukas_deleted_at"];
  }

  void AddAmount(double tunai, double nontunai) {
    this._bukukas_tunai += tunai;
    this._bukukas_non_tunai += nontunai;
  }

  double get bukukas_tunai => _bukukas_tunai;
  double get bukukas_non_tunai => _bukukas_non_tunai;
  int get bukukas_created_at => _bukukas_created_at;
  int get bukukas_updated_at => _bukukas_updated_at;
  int get bukukas_deleted_at => _bukukas_deleted_at;
  

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["bukukas_tunai"] = bukukas_tunai;
    map["bukukas_non_tunai"] = _bukukas_non_tunai;
    map["bukukas_created_at"] = bukukas_created_at;
    map["bukukas_updated_at"] = bukukas_updated_at;
    map["bukukas_updated_at"] = bukukas_deleted_at;

    return map;
  }

  void setId(int id) {
    this.bukukas_id = id;
  }
}

class bukukasdet {
  int bukukasdet_id;
  double _bukukasdet_tunai;
  double _bukukasdet_non_tunai;
  String _bukukasdet_ket;
  int _bukukasdet_created_at;
  int _bukukasdet_updated_at;
  int _bukukasdet_deleted_at;

  bukukasdet(
    this._bukukasdet_tunai,
    this._bukukasdet_non_tunai,
    this._bukukasdet_ket,
    this._bukukasdet_created_at,
    this._bukukasdet_updated_at,
    this._bukukasdet_deleted_at,
  );

  bukukasdet.map(dynamic obj) {
    this._bukukasdet_tunai = obj["bukukasdet_tunai"];
    this._bukukasdet_non_tunai = obj["bukukasdet_non_tunai"];
    this._bukukasdet_ket = obj["bukukasdet_ket"];
    this._bukukasdet_created_at = obj["bukukasdet_created_at"];
    this._bukukasdet_updated_at = obj["bukukasdet_updated_at"];
    this._bukukasdet_deleted_at = obj["bukukasdet_deleted_at"];
  }

  double get bukukasdet_tunai => _bukukasdet_tunai;
  double get bukukasdet_non_tunai => _bukukasdet_non_tunai;
  String get bukukasdet_ket => _bukukasdet_ket;
  int get bukukasdet_created_at => _bukukasdet_created_at;
  int get bukukasdet_updated_at => _bukukasdet_updated_at;
  int get bukukasdet_deleted_at => _bukukasdet_deleted_at;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["bukukasdet_tunai"] = bukukasdet_tunai;
    map["bukukasdet_non_tunai"] = bukukasdet_non_tunai;
    map["bukukasdet_ket"] = bukukasdet_ket;
    map["bukukasdet_created_at"] = bukukasdet_created_at;
    map["bukukasdet_updated_at"] = bukukasdet_updated_at;
    map["bukukasdet_deleted_at"] = bukukasdet_deleted_at;

    return map;
  }

  void setId(int id) {
    this.bukukasdet_id = id;
  }
}

class bukukasDAO {
  Future<List<bukukas>> getBukukas(List<int> tgl) async {
    var dbClient = await DBHelper().setDb();
    String sSQL =
        '''Create table IF NOT EXISTS bukukas (bukukas_id INTEGER PRIMARY KEY autoincrement,
                  bukukas_tunai real,bukukas_non_tunai double,
                  bukukas_created_at integer,bukukas_updated_at integer DEFAULT 0 ,bukukas_deleted_at integer DEFAULT 0  )''';

    await dbClient.rawQuery(sSQL);
    
    String sSQLdet =
        '''Create table IF NOT EXISTS bukukasdet (bukukasdet_id INTEGER PRIMARY KEY autoincrement,
                  bukukasdet_tunai real,bukukasdet_non_tunai double,bukukasdet_ket string,
                  bukukasdet_created_at integer,bukukasdet_updated_at integer DEFAULT 0 ,bukukasdet_deleted_at integer DEFAULT 0  )''';

    await dbClient.rawQuery(sSQLdet);

    sSQL = '''select * 
    from bukukas where bukukas_created_at between {$tgl[0]} and {$tgl[1]}''';

    List<Map> datalist = await dbClient.rawQuery(sSQL);
    List<bukukas> _bukukas = new List();

    for (var i = 0; i < datalist.length; i++) {
      var row = new bukukas(
        datalist[i]['bukukas_tunai'],
        datalist[i]['bukukas_non_tunai'],
        datalist[i]['bukukas_created_at'],
        datalist[i]['bukukas_updated_at'],
        datalist[i]['bukukas_deleted_at'],
      );
      _bukukas.add(row);
      row.setId(datalist[i]["bukukas_id"]);
    }
    return _bukukas;
  }
  Future<int> saveBukuKas(bukukas bukas) async {
    var dbClient = await DBHelper().setDb();
    int res =0;
    String sSQL1 =
        '''Create table IF NOT EXISTS bukukas (bukukas_id INTEGER PRIMARY KEY autoincrement,
                  bukukas_tunai real,bukukas_non_tunai double,
                  bukukas_created_at integer,bukukas_updated_at integer DEFAULT 0 ,bukukas_deleted_at integer DEFAULT 0  )''';

    await dbClient.rawQuery(sSQL1);

    String sSQLdet =
        '''Create table IF NOT EXISTS bukukasdet (bukukasdet_id INTEGER PRIMARY KEY autoincrement,
                  bukukasdet_tunai real,bukukasdet_non_tunai double,bukukasdet_ket string,
                  bukukasdet_created_at integer,bukukasdet_updated_at integer DEFAULT 0 ,bukukasdet_deleted_at integer DEFAULT 0  )''';

    await dbClient.rawQuery(sSQLdet);

    int created_at=bukas.bukukas_created_at;
    String sSQL = '''select * 
    from bukukas where bukukas_created_at = $created_at''';

    List<Map> datalist = await dbClient.rawQuery(sSQL);

    if(datalist.length >0 ){
      bukas.AddAmount(bukas.bukukas_tunai,bukas.bukukas_non_tunai);
      res = await dbClient.update("bukukas", bukas.toMap(),
        where: "bukukas_id=?", whereArgs: <int>[datalist[0]['bukukas_id']]);
    }else{
      res = await dbClient.insert("bukukas", bukas.toMap());
    }
    return res;
  }


  Future<List<bukukasdet>> getDetBukukas(List<int> tgl) async {
    var dbClient = await DBHelper().setDb();
    

    String sSQL = '''select * 
    from bukukasdet where bukukasdet_created_at between {$tgl[0]} and {$tgl[1]}''';

    List<Map> datalist = await dbClient.rawQuery(sSQL);
    List<bukukasdet> _bukukasdet = new List();

    for (var i = 0; i < datalist.length; i++) {
      var row = new bukukasdet(
        datalist[i]['bukukasdet_tunai'],
        datalist[i]['bukukasdet_non_tunai'],
        datalist[i]['bukukasdet_ket'],
        datalist[i]['bukukasdet_created_at'],
        datalist[i]['bukukasdet_updated_at'],
        datalist[i]['bukukasdet_deleted_at'],
      );
      _bukukasdet.add(row);
      row.setId(datalist[i]["bukukas_id"]);
    }
    return _bukukasdet;
  }

  Future<int> saveDetBukuKas(bukukasdet bukasdet) async {
    var dbClient = await DBHelper().setDb();
    int res =0;
    res = await dbClient.insert("bukukasdet", bukasdet.toMap());
    
    return res;
  }


}
