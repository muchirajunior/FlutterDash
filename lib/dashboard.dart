import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdash/bloc/theme_bloc.dart';
import 'package:flutterdash/components/componets.dart';
import 'package:flutterdash/components/products/products_tab.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/home/home.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  int selectedIndex=0;
  List<Widget> dashboardComponents=[
    const Home(),
    const Text("Sales"),
    const ProductsTab(),
    const Text("favourites"),
    const Text("Messages"),
    const Text("Settings"),
  ];
  bool isDarkmode=true;
  late ThemeBloc _themeBloc;
  

  checkTheme()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String theme='dark';
    if(preferences.getString("theme")=='light' || preferences.getString('theme')==null){
     theme='light';
    }
    _themeBloc.changeTheme(theme);
  }

  _changeDestination(int index)=>setState(()=>selectedIndex=index);

  _chageTheme(ThemeMode theme)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(theme== ThemeMode.dark){
      preferences.setString("theme", "light");
    }else{ preferences.setString("theme", "dark");}
   _themeBloc.changeTheme(theme== ThemeMode.dark ? 'light' :'dark') ;
  }
  
  @override
  initState(){
    _themeBloc=context.read<ThemeBloc>();
    checkTheme();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text("DashBoards With Flutter"),
        elevation: 1,
        shadowColor: Colors.grey.shade400,
        actions:  <Widget>[
            BlocBuilder<ThemeBloc,ThemeMode>(
              builder: (context,theme) {
                return IconButton(
                  onPressed:()=>_chageTheme(theme), 
                  icon: theme == ThemeMode.dark ? const Icon(Icons.light_mode) : const Icon(Icons.dark_mode)  
                );
              }
            ),
            const SizedBox(width: 10,),
            const Center(child: Text("JOHN DOE "),),
            const SizedBox(width: 5,),
            profileImage,
            const SizedBox(width: 5,),
        ],
      ),

      body:  SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          children: [
            NavigationRail(
              elevation: 10,
              selectedIndex: selectedIndex,
              onDestinationSelected: _changeDestination,
              selectedLabelTextStyle: const TextStyle(color: Colors.grey, fontSize: 16),
              minWidth: 140,
              useIndicator: true,
              labelType: NavigationRailLabelType.all,
              leading: SizedBox(width: 60, child: profileImage,),
              

              destinations: const [
                NavigationRailDestination(icon: Icon(Icons.home_outlined), label: Text("Home"),selectedIcon: Icon(Icons.home)  ),
                NavigationRailDestination(icon: Icon(Icons.shopping_cart_outlined), label: Text("Sales"),selectedIcon: Icon(Icons.shopping_cart) ),
                NavigationRailDestination(icon: Icon(Icons.list_outlined), label: Text("products") ),
                NavigationRailDestination(icon: Icon(Icons.favorite_outline), label: Text("Favourite"),selectedIcon: Icon(Icons.favorite)  ),
                NavigationRailDestination(icon: Icon(Icons.mail_outline), label: Text("Messages"), selectedIcon: Icon(Icons.mail)),
                NavigationRailDestination(icon: Icon(Icons.settings_outlined), label: Text("Settings"),selectedIcon: Icon(Icons.settings)  ),
              ], 
             
            ),

            Expanded(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: dashboardComponents[selectedIndex],
            ))
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: const Icon(Icons.replay_outlined),
      ),

    );
  }
}