import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:maubayar/models/kasirmodel.dart';
import 'package:maubayar/models/pelangganmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class global_var {
  static pelanggan kasirpelanggan;
  static double diskon=0;
  static double pembayaran=0;
  static double kembalian=0;
  static double total=0;
  static int isTunai=0;
  static List<invoicedet> detailkasir;
  static PrinterBluetooth default_printer;
  
  void savePref(String variable, String isi )async{
    SharedPreferences _shp = await SharedPreferences.getInstance();
    await _shp.setString(variable, isi);
  }
  Future<String> getPref(String variable )async{
    SharedPreferences _shp = await SharedPreferences.getInstance();
    var _ambiltext = await _shp.getString(variable)?? "";
    return _ambiltext;
  }
  
}