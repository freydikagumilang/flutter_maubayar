import 'package:flutter/material.dart';
import 'package:maubayar/ui_view/template/frxappbar.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
class PrintNota extends StatefulWidget {
  @override
  _PrintNotaState createState() => _PrintNotaState();
}

class _PrintNotaState extends State<PrintNota> {
  PrinterBluetoothManager _printManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _device = [];
  @override
  void initState(){
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
          itemBuilder: (context,idx){
            return ListTile(
              onTap: (){
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

  void searchPrinter(){
    _printManager.startScan(Duration(seconds: 2));
    _printManager.scanResults.listen((printers) {
      if(!mounted) return;
      setState(()=>_device=printers);
      print(_device);
    });
    
  }

  Future<void> _startPrint(PrinterBluetooth selprinter) async{
    _printManager.selectPrinter(selprinter);
    final hasil_print = await _printManager.printTicket(await _createNota(PaperSize.mm58));
    print(hasil_print);
  }
  Future<Ticket> _createNota(PaperSize paper)async{
    final ticket = Ticket(paper);
    ticket.text("NgePrint Pake Hape");
    ticket.cut();
    return ticket;
  }
}
