import 'package:maubayar/models/kapstermodel.dart';
import 'package:bloc/bloc.dart';

class Createkapster extends Bloc<kapster,String>{
  final kapsterDAO = KapsterDAO();

  Createkapster(String initialState) : super(initialState);

  @override
  Stream<String> mapEventToState(event)async* {
    // TODO: implement mapEventToState
    int id;
    try {
      if(event.kapster_id!=0 && event.kapster_id!=null){
        id = await kapsterDAO.updateKapster(event);
      }else{        
        id = await kapsterDAO.saveKapster(event);    
      }
      yield "success";
    } catch (e) {
      print(e);
    }
    
  }
  
}

class Getkapster extends Bloc<String, List<kapster>>{
  final kapsterDAO = KapsterDAO();

  Getkapster(List<kapster> initialState) : super(initialState);
    
  @override
  Stream<List<kapster>> mapEventToState(String event)async* {
    try {
      List<kapster> listprod = await kapsterDAO.getKapster(event);
      yield listprod;
    } catch (e) {
      print("error : ${e}");
    }
  }

}

class Deletekapster extends Bloc<int,int>{
  final kapsterDAO = KapsterDAO();
  Deletekapster(int initialState) : super(initialState);

  @override
  Stream<int> mapEventToState(int event)async* {
    try{
      int ret = await kapsterDAO.deleteKapster(event);
      yield ret;
    }catch(e){

    }
  }
  
}