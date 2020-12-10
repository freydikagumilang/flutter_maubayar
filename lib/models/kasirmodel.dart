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

class invoicedet {
  int invdet_id;
  int invdet_inv_id;
  String _invdet_tmp_id;
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
    {this.invdet_prod_nama,this.invdet_kapster_name}
  );
  invoicedet.map(dynamic obj) {
    this._invdet_tmp_id = obj["invdet_tmp_id"];
    this._invdet_item_id= obj["invdet_item_id"];
    this._invdet_ket= obj["invdet_ket"];
    this._invdet_qty= obj["invdet_qty"];
    this._invdet_price= obj["invdet_price"];
    this._invdet_total= obj["invdet_total"];
    this._invdet_komisi= obj["invdet_komisi"];
    this._invdet_kapster_id= obj["invdet_kapster_id"];
    this._invdet_created_at= obj["invdet_created_at"];
    this._invdet_updated_at= obj["invdet_updated_at"];
    this._invdet_deleted_at= obj["invdet_deleted_at"];
    this.invdet_prod_nama= obj["invdet_prod_nama"];
    this.invdet_kapster_name= obj["invdet_kapster_name"];
  }

  String get invdet_tmp_id =>_invdet_tmp_id;
  int get invdet_item_id => _invdet_item_id;
  String get invdet_ket => _invdet_ket;
  double get invdet_qty => _invdet_qty;
  double get invdet_price => _invdet_price;
  double get invdet_total => _invdet_total;
  double get invdet_komisi => _invdet_komisi;
  int get invdet_kapster_id => _invdet_kapster_id;
  int get invdet_created_at => _invdet_created_at;
  int get invdet_updated_at => _invdet_updated_at;
  int get invdet_deleted_at => invdet_deleted_at;


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["invdet_inv_id"] = invdet_inv_id;
    map["invdet_tmp_id"] = invdet_tmp_id;
    map["invdet_item_id"] = invdet_item_id;
    map["invdet_ket"] = invdet_ket;
    map["invdet_qty"] = invdet_qty;
    map["invdet_price"] = invdet_price;
    map["invdet_total"] = invdet_total;
    map["invdet_komisi"] = invdet_komisi;
    map["invdet_kapster_id"] = invdet_kapster_id;
    map["inv_created_at"] = invdet_created_at;
    map["inv_updated_at"] = invdet_updated_at;
    map["inv_deleted_at"] = invdet_deleted_at;

    return map;
  }

  void setId(int id) {
    this.invdet_id = id;
  }
}