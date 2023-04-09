import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdash/bloc/products_bloc.dart';
import 'package:flutterdash/bloc/theme_bloc.dart';
import 'package:flutterdash/bloc/todos_bloc.dart';
import 'package:flutterdash/dashboard.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  if(Platform.isWindows || Platform.isLinux){
    sqfliteFfiInit();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  initState(){
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(create: (context)=> ThemeBloc()),
        BlocProvider<TodosBloc>(create: (context)=>TodosBloc()),
        BlocProvider(create: (context)=> ProductsBloc())
      ],
      
      child: BlocBuilder<ThemeBloc,ThemeMode>(
        builder: (context, theme) {
          return MaterialApp(
            title: 'Flutter Dash',
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(
              useMaterial3: true,
            ),
            darkTheme: ThemeData.dark(
              useMaterial3: true,
            ),
            themeMode: theme,
            home: const DashBoard()
          );
        }
      )
      
    );
  }
}
