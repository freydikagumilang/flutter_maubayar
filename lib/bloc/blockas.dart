import 'package:bloc/bloc.dart';
import 'package:maubayar/models/kasmodel.dart';

class GetBukuKasDetail extends Bloc<List<int>, List<bukukasdet>> {
  final bukuKasDAO = bukukasDAO();

  GetBukuKasDetail(List<bukukasdet> initialState) : super(initialState);

  @override
  Stream<List<bukukasdet>> mapEventToState(List<int> event) async* {
    try {
      List<bukukasdet> listprod = await bukuKasDAO.getDetBukukas(event);
      yield listprod;
    } catch (e) {
      print("error : ${e}");
    }
  }
}

class GetDateSaldo extends Bloc<List<int>, List<bukukas>> {
  final bukuKasDAO = bukukasDAO();

  GetDateSaldo(List<bukukas> initialState) : super(initialState);

  @override
  Stream<List<bukukas>> mapEventToState(List<int> event) async* {
    // TODO: implement mapEventToState
    try {
      List<bukukas> _bk = await bukuKasDAO.getBukukas(event);
      yield _bk;
    } catch (e) {
      print("error : ${e}");
    }
  }
}
