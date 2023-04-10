import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdash/bloc/todos_bloc.dart';
import 'package:flutterdash/models/todo.dart';
import 'package:http/http.dart';

class Todostab extends StatefulWidget {
  const Todostab({super.key});

  @override
  State<Todostab> createState() => _TodostabState();
}

class _TodostabState extends State<Todostab> {
  TextEditingController searchController=TextEditingController();
  bool isLoading=false;

  loadTodos()async{
    try {
      setState(() => isLoading=true);
      var results= await get(Uri.parse("https://jsonplaceholder.typicode.com/todos"));
      List data=jsonDecode(results.body);
      List<Todo> todos=[];
      data.forEach((item) =>{ todos.add( Todo.fromJson(item) ) });
      context.read<TodosBloc>().addTodos(todos);
    } catch (error) {
      print(error.toString());
    }finally{
      setState(()=> isLoading=false);
    }
  }

  @override
  void initState() {
    loadTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Card(
            child: TextFormField(
              controller: searchController,
              onChanged: (_)=>setState(() { }),
              decoration:  InputDecoration(
                prefixIcon: const Icon(Icons.filter_list),
                hintText: "Filter todos .....",
                border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: (){
                      searchController.clear();
                      setState(() {});
                  },
                  icon:const Icon(Icons.cancel)
                )
              ),
            ),
          ),
          Expanded(
            child:  isLoading ? 
            const Center(child: CircularProgressIndicator(),) :
            BlocBuilder<TodosBloc,List<Todo>>(builder: (context,todos)=> todos.isEmpty ?
            const Center(child: Text("No Todos here .....!"),) : ListView(
              children: todos.map((todo) => todo.title!.contains(searchController.text.toLowerCase()) ? Card(
                child: ListTile(
                  leading: CircleAvatar(child: Text(todo.id.toString())),
                  title: Text(todo.title.toString()),
                  trailing: todo.isCompleted! ? const Icon(Icons.check) : const Icon(Icons.timelapse_rounded),
                  onTap:(){
                    todo.isCompleted = !todo.isCompleted!;
                    context.read<TodosBloc>().updateTodo(todo);
                  },
                ),
              ) : SizedBox()
              ).toList(),
            ))
          )
        ],
      ),
    );
  }
}