import 'package:maubayar/models/kategorimodel.dart';
import 'package:bloc/bloc.dart';

class CreateKategori extends Bloc<kategori,int>{
  final katDAO = kategoriDAO();

  CreateKategori(int initialState) : super(initialState);

  @override
  Stream<int> mapEventToState(event)async* {
    int id;
    // TODO: implement mapEventToState
    try {
      if(event.kat_id!=0 && event.kat_id!=null){
        id = await katDAO.updateKat(event);
      }else{        
        id = await katDAO.saveKat(event);    
      }
      
      yield id;
    } catch (e) {
    }
    
  }
  
}

class GetKategori extends Bloc<String, List<kategori>>{
  final katDAO = kategoriDAO();

  GetKategori(List<kategori> initialState) : super(initialState);
    
  @override
  Stream<List<kategori>> mapEventToState(String event)async* {
    try {
      List<kategori> listprod = await katDAO.getKat(event);
      print(listprod.length.toString());
      yield listprod;
    } catch (e) {
      print("error : ${e}");
    }
  }

}

class DeleteKategori extends Bloc<int,int>{
  final katDAO = kategoriDAO();
  DeleteKategori(int initialState) : super(initialState);

  @override
  Stream<int> mapEventToState(int event)async* {
    try{
      int ret = await katDAO.deleteKat(event);
      yield ret;
    }catch(e){

    }
  }
  
}