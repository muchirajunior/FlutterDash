import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdash/models/product.dart';

class ProductsBloc extends Cubit<List<Product>>{
  ProductsBloc():super([]);

  addproduct(Product product)=>emit([...state,product]);

  removeproduct(int id){
    var product= state.where((product) => product.id==id).firstOrNull;
    if (product != null){
      state.remove(product);
      emit([...state]);
    }
  }

  updateproduct(Product product){
    var oldProduct= state.where((product) => product.id==product.id).firstOrNull;
    if(oldProduct != null){
      oldProduct=product;
      emit([...state]);
    }
  }

  resetState(List<Product> products)=> emit(products);
  
}