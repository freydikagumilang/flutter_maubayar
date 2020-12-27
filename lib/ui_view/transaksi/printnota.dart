import 'package:flutter/material.dart';
import 'package:maubayar/global_var.dart';
import 'package:maubayar/ui_view/template/frxappbar.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';


// class PrintNota extends StatefulWidget {
//   @override
//   _PrintNotaState createState() => _PrintNotaState();
// }

// class _PrintNotaState extends State<PrintNota> {
//   PrinterBluetoothManager _printManager = PrinterBluetoothManager();
//   global_var gb = global_var();
  
//   DateTime selectedDate = DateTime.now();
//   final formatter = new DateFormat.yMMMMd();
//   final _nominal = NumberFormat.compact(locale: "en");
//   String _nama_bisnis = "";
//   String _alamat_bisnis = "";
//   String _ket_bisnis = "";
//   String _terimakasih = "";
//   String _default_printer = "";
//   @override
//   void initState() {
//     // TODO: implement initState

//     gb.getPref("nama_bisnis").then((val) {
//       _nama_bisnis = val;
//       setState(() {});
//     });
//     gb.getPref("alamat_bisnis").then((val) {
//       _alamat_bisnis = val;
//       setState(() {});
//     });
//     gb.getPref("ket_bisnis").then((val) {
//       _ket_bisnis = val;
//       setState(() {});
//     });
//     gb.getPref("terimakasih_nota").then((val) {
//       _terimakasih = val;
//       setState(() {});
//     });
//     gb.getPref("printer_id").then((val) {
//       _default_printer = val;
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(

//     );
//   }


//   Future<void> _startPrint(PrinterBluetooth selprinter) async {
//     print(selprinter.name);
//     _printManager.selectPrinter(selprinter);
//     final hasil_print =
//         await _printManager.printTicket(await _createNota(PaperSize.mm58));
//     print(hasil_print.msg);
//   }

//   Future<Ticket> _createNota(PaperSize paper) async {
//     final ticket = Ticket(paper);

//     ticket.text(
//       (_nama_bisnis) ?? "Bisnis-ku",
//       styles: PosStyles(
//           align: PosAlign.center,
//           height: PosTextSize.size2,
//           width: PosTextSize.size2,
//           bold: true,
//           fontType: PosFontType.fontA),
//       linesAfter: 1,
//     ); //judul
//     ticket.text(((_alamat_bisnis) ?? "Alamat") + "\n" + ((_ket_bisnis) ?? ""),
//         styles: PosStyles(
//             align: PosAlign.center, width: PosTextSize.size1)); //Alamat Telp
//     ticket.emptyLines(1);
//     ticket.row([
//       PosColumn(
//         text: 'No',
//         width: 4,
//       ),
//       PosColumn(
//         text: 'INV-47326489',
//         width: 8,
//       ),
//     ]);
//     ticket.row([
//       PosColumn(
//         text: 'Tgl',
//         width: 4,
//       ),
//       PosColumn(
//         text: formatter.format(selectedDate),
//         width: 8,
//       ),
//     ]);
//     ticket.row([
//       PosColumn(
//         text: 'Cust',
//         width: 4,
//       ),
//       PosColumn(
//         text: global_var.kasirpelanggan.pelanggan_nama,
//         width: 8,
//       ),
//     ]);
//     ticket.hr();
//     for (var i = 0; i < global_var.detailkasir.length; i++) {
//       String layanan =
//           (_nominal.format(global_var.detailkasir[i].invdet_qty).toString() +
//                   "x " +
//                   global_var.detailkasir[i].invdet_kat_nama +
//                   " " +
//                   global_var.detailkasir[i].invdet_prod_nama)
//               .padRight(28, " ")
//               .substring(0, 28);
//       String harga = _nominal
//           .format(global_var.detailkasir[i].invdet_total)
//           .toString()
//           .padLeft(4, " ");
//       ticket.row([
//         PosColumn(
//           text: layanan + harga,
//           width: 12,
//         )
//       ]);
//     }
//     ticket.hr();
//     String Total = ("Total : ").padLeft(28, " ") +
//         _nominal.format(global_var.total).toString().padLeft(4, " ");
//     ticket.text(Total,
//         styles: PosStyles(align: PosAlign.center, width: PosTextSize.size1));
//     if (global_var.diskon > 0) {
//       Total = ("Potongan : ").padLeft(28, " ") +
//           _nominal.format(global_var.diskon).toString().padLeft(4, " ");
//       ticket.text(Total,
//           styles: PosStyles(align: PosAlign.center, width: PosTextSize.size1));
//     }
//     Total = ("Pembayaran : ").padLeft(28, " ") +
//         _nominal.format(global_var.pembayaran).toString().padLeft(4, " ");
//     ticket.text(Total,
//         styles: PosStyles(align: PosAlign.center, width: PosTextSize.size1));

//     Total = ("Kembali : ").padLeft(28, " ") +
//         _nominal
//             .format((global_var.kembalian < 0) ? 0 : global_var.kembalian)
//             .toString()
//             .padLeft(4, " ");

//     ticket.emptyLines(1);
//     ticket.text((_terimakasih) ?? "-Terima Kasih-",
//         styles: PosStyles(align: PosAlign.center, width: PosTextSize.size1));

//     ticket.cut();
//     return ticket;
//   }

// }

class CariPrinter extends StatefulWidget {
  @override
  _CariPrinterState createState() => _CariPrinterState();
}

class _CariPrinterState extends State<CariPrinter> {
  PrinterBluetoothManager _printManager = PrinterBluetoothManager();  
  List<PrinterBluetooth> _device = [];
  global_var gb = global_var();


  void searchPrinter() async {
    _printManager.startScan(Duration(seconds: 2));
    _printManager.scanResults.listen((printers) async {
      if (!mounted) return;
      print(printers);
      setState(() => _device = printers);
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    
    searchPrinter();
  
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FrxAppBar("Print Nota"),
      body: Container(
        child: ListView.builder(
            itemCount: _device.length,
            itemBuilder: (context, idx) {
              return ListTile(
                onTap: () {
                  gb.savePref("printer_id", _device[idx].address);
                  global_var.default_printer =  _device[idx];
                  setState(() {});
                  Navigator.of(context).pop(true);
                },
                title: Text(_device[idx].name),
                subtitle: Text(_device[idx].address),
                leading: Icon(Icons.print),
              );
            }),
      ),
    );
  }
}
