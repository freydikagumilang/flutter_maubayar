import 'package:maubayar/models/pelangganmodel.dart';
import 'package:bloc/bloc.dart';

class Createpelanggan extends Bloc<pelanggan,String>{
  final pelangganDAO = PelangganDAO();

  Createpelanggan(String initialState) : super(initialState);

  @override
  Stream<String> mapEventToState(event)async* {
    // TODO: implement mapEventToState
    int id;
    try {
      if(event.pelanggan_id!=0 && event.pelanggan_id!=null){
        id = await pelangganDAO.updatePelanggan(event);
      }else{        
        id = await pelangganDAO.savePelanggan(event);    
      }
      yield "success";
    } catch (e) {
      print(e);
    }
    
  }
  
}

class Getpelanggan extends Bloc<String, List<pelanggan>>{
  final pelangganDAO = PelangganDAO();

  Getpelanggan(List<pelanggan> initialState) : super(initialState);
    
  @override
  Stream<List<pelanggan>> mapEventToState(String event)async* {
    try {
      List<pelanggan> listprod = await pelangganDAO.getPelanggan(event);
      yield listprod;
    } catch (e) {
      print("error : ${e}");
    }
  }

}

class Deletepelanggan extends Bloc<int,int>{
  final pelangganDAO = PelangganDAO();
  Deletepelanggan(int initialState) : super(initialState);

  @override
  Stream<int> mapEventToState(int event)async* {
    try{
      int ret = await pelangganDAO.deletePelanggan(event);
      yield ret;
    }catch(e){

    }
  }
  
}