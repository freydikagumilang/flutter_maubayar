import 'package:flutter/material.dart';
import 'package:maubayar/global_var.dart';
import 'package:maubayar/ui_view/template/frxappbar.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:intl/intl.dart';

class PrintNota extends StatefulWidget {
  @override
  _PrintNotaState createState() => _PrintNotaState();
}

class _PrintNotaState extends State<PrintNota> {
  PrinterBluetoothManager _printManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _device = [];
  DateTime selectedDate = DateTime.now();
  final formatter = new DateFormat.yMMMMd();
  final _nominal = NumberFormat.compact(locale: "en");

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
                  _startPrint(_device[idx]);
                },
                title: Text(_device[idx].name),
                subtitle: Text(_device[idx].address),
                leading: Icon(Icons.print),
              );
            }),
      ),
    );
  }

  void searchPrinter() {
    _printManager.startScan(Duration(seconds: 2));
    _printManager.scanResults.listen((printers) {
      if (!mounted) return;
      setState(() => _device = printers);
      print(_device);
    });
  }

  Future<void> _startPrint(PrinterBluetooth selprinter) async {
    _printManager.selectPrinter(selprinter);
    final hasil_print =
        await _printManager.printTicket(await _createNota(PaperSize.mm58));
    print(hasil_print);
  }

  Future<Ticket> _createNota(PaperSize paper) async {
    final ticket = Ticket(paper);
    ticket.text(
      "A l o o d i e",
      styles: PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
          bold: true,
          fontType: PosFontType.fontA),
      linesAfter: 1,
    ); //judul
    ticket.text(
        "Tanjung Anom, Solobaru\nRsvp: 08467324824974\nIG : @aloodie.beauty",
        styles: PosStyles(
            align: PosAlign.center, width: PosTextSize.size1)); //Alamat Telp
    ticket.emptyLines(1);
    ticket.row([
      PosColumn(
        text: 'INV-47326489',
        width: 6,
      ),
      PosColumn(
        text: formatter.format(selectedDate),
        width: 6,
        styles: PosStyles(align: PosAlign.right),
      ),
    ]);
    ticket.hr();
    for (var i = 0; i < global_var.detailkasir.length; i++) {
      String layanan =
          (_nominal.format(global_var.detailkasir[i].invdet_qty).toString() +
                  "x " +
                  global_var.detailkasir[i].invdet_kat_nama +
                  " " +
                  global_var.detailkasir[i].invdet_prod_nama)
              .padRight(28, " ")
              .substring(0, 28);
      String harga = _nominal
          .format(global_var.detailkasir[i].invdet_total)
          .toString()
          .padLeft(4, " ");
      ticket.row([
        PosColumn(
          text: layanan + harga,
          width: 12,
        )
      ]);
    }
    ticket.hr();
    String Total = ("Total : ").padLeft(28, " ") +
        _nominal.format(global_var.total).toString().padLeft(4, " ");
    ticket.text(Total,
        styles: PosStyles(align: PosAlign.center, width: PosTextSize.size1));
    if (global_var.diskon > 0) {
      Total = ("Potongan : ").padLeft(28, " ") +
          _nominal.format(global_var.diskon).toString().padLeft(4, " ");
      ticket.text(Total,
          styles: PosStyles(align: PosAlign.center, width: PosTextSize.size1));
    }
    Total = ("Pembayaran : ").padLeft(28," ")+_nominal.format(global_var.pembayaran).toString().padLeft(4," ");
    ticket.text(
        Total,
        styles: PosStyles(
            align: PosAlign.center, width: PosTextSize.size1)); 

    Total = ("Kembali : ").padLeft(28," ")+_nominal.format((global_var.kembalian<0)?0:global_var.kembalian).toString().padLeft(4," ");
    ticket.text(
        Total,
        styles: PosStyles(
            align: PosAlign.center, width: PosTextSize.size1)); 



    ticket.cut();
    return ticket;
  }
}
