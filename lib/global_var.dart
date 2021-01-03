import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:maubayar/models/kasirmodel.dart';
import 'package:maubayar/models/pelangganmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
class global_var {
  static DateFormat formatter = DateFormat('yyyy-MM-dd 00:00:00');

  static pelanggan kasirpelanggan;
  static double diskon=0;
  static double pembayaran=0;
  static double kembalian=0;
  static double total=0;
  static int isTunai=0;
  static int isSaved=0;
  static List<invoicedet> detailkasir;
  static PrinterBluetooth default_printer;
  static int unixtime_today = formatter.parse(formatter.format(DateTime.now())).millisecondsSinceEpoch ;
  static bool cetak_nota=false;
  void savePref(String variable, String isi )async{
    SharedPreferences _shp = await SharedPreferences.getInstance();
    await _shp.setString(variable, isi);
  }
  Future<String> getPref(String variable )async{
    SharedPreferences _shp = await SharedPreferences.getInstance();
    var _ambiltext = await _shp.getString(variable)?? "";
    return _ambiltext;
  }
  void ClearKasir(){
    diskon=0;
    pembayaran=0;
    kembalian=0;
    total=0;
    detailkasir=[];
    isTunai=1;
    kasirpelanggan=null;
    isSaved=0;
  }
  
}