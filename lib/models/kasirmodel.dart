import 'package:maubayar/dbhelper.dart';

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

  invoice(
    this._inv_no,
    this._inv_date,
    this._inv_plg_id,
    this._inv_total_bruto,
    this._inv_diskon,
    this._inv_total_net,
    this._inv_created_at,
    this._inv_updated_at,
    this._inv_deleted_at
  );
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