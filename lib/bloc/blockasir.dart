import 'package:bloc/bloc.dart';
import 'package:maubayar/models/kasirmodel.dart';
import 'package:maubayar/global_var.dart';
import 'package:maubayar/models/kasmodel.dart';

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
class CreateNota extends Bloc<invoice,int>{
  final _notaDAO = invoiceDAO();
  CreateNota(int initialState) : super(initialState);

  @override
  Stream<int> mapEventToState(invoice event) async* {
    int id;
    try {
      if(event.inv_id!=0 && event.inv_id!=null){
        id = await _notaDAO.updateInv(event);
      }else{        
        id = await _notaDAO.saveInv(event);    
      }
      yield id;
    } catch (e) {
      print("error");
      print(e);
    }
  }

}
class CreateBukuKas extends Bloc<bukukas,int>{
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