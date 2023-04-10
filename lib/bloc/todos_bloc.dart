import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdash/models/todo.dart';

class TodosBloc extends Cubit<List<Todo>>{
  TodosBloc():super([]);

  addTodo(Todo todo)=>emit([...state,todo]);

  removeTodo(int id){
    var todo= state.where((todo) => todo.id==id).first;
    if (todo != null){
      state.remove(todo);
      emit([...state]);
    }
  }

  updateTodo(Todo todo){
   state.where((td) => td.id==todo.id).first.isCompleted=todo.isCompleted;
   emit([...state]);
  }

  addTodos(List<Todo> todos)=>emit(todos);
  
}