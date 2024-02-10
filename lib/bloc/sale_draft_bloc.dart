import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdash/models/sales_daft.dart';

class SalesDraftBloc extends Cubit<List<SalesDraft>>{
  SalesDraftBloc() : super([]);

  addDrafts(List<SalesDraft> drafts)=>emit([...drafts]);

}