import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdash/models/todo.dart';

class TodosBloc extends Cubit<List<Todo>>{
  TodosBloc():super([]);

  addTodo(Todo todo)=>emit([...state,todo]);

  removeTodo(int id){
    var todo= state.where((todo) => todo.id==id).first;
    if (todo != null){
      state.remove(todo);
      emit(state);
    }
  }

  updateTodo(Todo todo){
    var oldTodo= state.where((td) => td.id==todo.id).first;
    if(oldTodo != null){
      oldTodo=todo;
      print(oldTodo.toJson());
      emit(state);
    }

  }
  
}