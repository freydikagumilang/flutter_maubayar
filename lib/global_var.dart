import 'package:maubayar/models/kasirmodel.dart';
import 'package:maubayar/models/pelangganmodel.dart';

class global_var {
  static pelanggan kasirpelanggan;
  static double diskon=0;
  static double pembayaran=0;
  static double kembalian=0;
  static double total=0;
  static int isTunai=0;
  static List<invoicedet> detailkasir;
  static String inv_temp_id = "";
}