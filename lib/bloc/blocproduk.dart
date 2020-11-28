import 'package:maubayar/models/produkmodel.dart';
import 'package:bloc/bloc.dart';

class Createproduk extends Bloc<produk,int>{
  final prodDAO = produkDAO();

  Createproduk(int initialState) : super(initialState);

  @override
  Stream<int> mapEventToState(event)async* {
    int id;
    // TODO: implement mapEventToState
    try {
      print(event.prod_id);
      if(event.prod_id!=0 && event.prod_id!=null){
        id = await prodDAO.updateKat(event);
      }else{        
        id = await prodDAO.saveProd(event);    
      }
      
      yield id;
    } catch (e) {
    }
    
  }
  
}

class Getproduk extends Bloc<String, List<produk>>{
  final prodDAO = produkDAO();

  Getproduk(List<produk> initialState) : super(initialState);
    
  @override
  Stream<List<produk>> mapEventToState(String event)async* {
    try {
      List<produk> listprod = await prodDAO.getProd(event);
      yield listprod;
    } catch (e) {
      print("error : ${e}");
    }
  }

}

class Deleteproduk extends Bloc<int,int>{
  final prodDAO = produkDAO();
  Deleteproduk(int initialState) : super(initialState);

  @override
  Stream<int> mapEventToState(int event)async* {
    try{
      int ret = await prodDAO.deleteProd(event);
      yield ret;
    }catch(e){

    }
  }
  
}