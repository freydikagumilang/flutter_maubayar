import 'package:maubayar/dbhelper.dart';

class kas {
  int kas_id;
  double _kas_tunai;
  double _kas_non_tunai;
  int _kas_created_at;
  int _kas_updated_at;
  int _kas_deleted_at;

  kas(
    this._kas_tunai,
    this._kas_non_tunai,
    this._kas_created_at,
    this._kas_updated_at,
    this._kas_deleted_at
  );
  kas.map(dynamic obj) {
    this._kas_tunai = obj["kas_tunai"];
    this._kas_non_tunai = obj["kas_non_tunai"];
    this._kas_created_at = obj["kas_created_at"];
    this._kas_updated_at = obj["kas_updated_at"];
    this._kas_deleted_at = obj["kas_deleted_at"]; 
  }

  double get kas_tunai => _kas_tunai;
  double get kas_non_tunai => _kas_non_tunai;
  int get kas_created_at => _kas_created_at;
  int get kas_updated_at => _kas_updated_at;
  int get kas_deleted_at => _kas_deleted_at;


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["kas_tunai"] = kas_tunai;
    map["kas_non_tunai"] = _kas_non_tunai;
    map["kas_created_at"] = kas_created_at;
    map["kas_updated_at"] = kas_updated_at;
    map["kas_updated_at"] = kas_deleted_at;

    return map;
  }

  void setId(int id) {
    this.kas_id = id;
  }
}