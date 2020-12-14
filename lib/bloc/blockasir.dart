import 'package:bloc/bloc.dart';
import 'package:maubayar/models/kasirmodel.dart';
import 'package:maubayar/global_var.dart';

class InsertDet extends Bloc<invoicedet, double> {
  InsertDet(double initialState) : super(initialState);

  @override
  Stream<double> mapEventToState(invoicedet event)async* {
    if (global_var.detailkasir == null) {
      global_var.detailkasir = [event];
    } else {
      global_var.detailkasir.add(event);
    }
    global_var.total+=event.invdet_total;
    global_var.kembalian = global_var.pembayaran+global_var.diskon-global_var.total;
    yield global_var.total;
  }
}
