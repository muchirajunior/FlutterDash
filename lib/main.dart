import 'package:flutter/material.dart';
import 'package:flutterdash/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkmode=true;

  checkTheme()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.getString("theme")=='light' || preferences.getString('theme')==null){
      isDarkmode=false;
      setState(() {});
    }
  }

  @override
  initState(){
    checkTheme();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dash',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      themeMode: isDarkmode ? ThemeMode.dark : ThemeMode.light,
      home: const DashBoard()
    );
  }
}
