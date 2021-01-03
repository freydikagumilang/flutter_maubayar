import 'package:bloc/bloc.dart';
import 'package:maubayar/models/kasirmodel.dart';
import 'package:maubayar/global_var.dart';
import 'package:maubayar/models/kasmodel.dart';
import 'package:intl/intl.dart';

class InsertDet extends Bloc<invoicedet, double> {
  InsertDet(double initialState) : super(initialState);

  @override
  Stream<double> mapEventToState(invoicedet event) async* {
    if (global_var.detailkasir == null) {
      global_var.detailkasir = [event];
    } else {
      global_var.detailkasir.add(event);
    }
    global_var.total += event.invdet_total;
    global_var.kembalian =
        global_var.pembayaran + global_var.diskon - global_var.total;
    yield global_var.total;
  }
}

class CreateNota extends Bloc<invoice, int> {
  final _notaDAO = invoiceDAO();
  CreateNota(int initialState) : super(initialState);

  @override
  Stream<int> mapEventToState(invoice event) async* {
    int id;
    try {
      if (event.inv_id != 0 && event.inv_id != null) {
        id = await _notaDAO.updateInv(event);
      } else {
        id = await _notaDAO.saveInv(event);
      }
      yield id;
    } catch (e) {
      print("error");
      print(e);
    }
  }
}

class CreateBukuKas extends Bloc<bukukas, int> {
  final _bukukasDAO = bukukasDAO();
  CreateBukuKas(int initialState) : super(initialState);

  @override
  Stream<int> mapEventToState(bukukas event) async* {
    int id;
    try {
      id = await _bukukasDAO.saveBukuKas(event);
      id = await _bukukasDAO.saveDetBukuKas(event.detail_bukukas);

      yield id;
    } catch (e) {
      print("error");
      print(e);
    }
  }
}

class GetLast7DaysSale extends Bloc<int, List<salesperday>> {
  GetLast7DaysSale(List<salesperday> initialState) : super(initialState);
  final _notaDAO = invoiceDAO();
  @override
  Stream<List<salesperday>> mapEventToState(int event) async* {
    DateFormat _dtformater = DateFormat('yyyy-MM-dd HH:mm:ss');
    int start_date;
    int end_date;
    DateTime _enddatetime;
    List<int> _7days=[];
    try {
      for (var i = 6; i >= 0; i--) {
        _enddatetime = DateTime.fromMillisecondsSinceEpoch(event).subtract(Duration(days: i)).add(Duration(hours: 23,minutes: 59,seconds: 59));

        start_date = _dtformater
            .parse(_dtformater.format(DateTime.fromMillisecondsSinceEpoch(event)
                .subtract(Duration(days: i))))
            .millisecondsSinceEpoch;
        end_date = _dtformater.parse(_dtformater.format(_enddatetime)).millisecondsSinceEpoch;
        _7days.add(start_date);
        _7days.add(end_date);
        
      }
      List<salesperday> _result = await _notaDAO.GetSalelast7Days(_7days);
      yield _result;
    } catch (e) {
      print("error");
      print(e);
    }
  }
}
