import 'package:flutter/material.dart';
import 'package:flutterdash/components/componets.dart';

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
    const Text("Products"),
    const Text("favourites"),
    const Text("Messages"),
    const Text("Settings"),
  ];
  _changeDestination(int index)=>setState(()=>selectedIndex=index);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text("DashBoards With Flutter"),
        actions:  <Widget>[
            const Center(child: Text("JOHN DOE "),),
            const SizedBox(width: 5,),
            profileImage,
            const SizedBox(width: 5,),
        ],
      ),

      body:  Container(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          children: [
            NavigationRail(
              elevation: 10,
              selectedIndex: selectedIndex,
              onDestinationSelected: _changeDestination,
              selectedLabelTextStyle: const TextStyle(color: Colors.black,fontSize: 16),
              minWidth: 93,
              useIndicator: true,
              labelType: NavigationRailLabelType.all,
              indicatorColor: Colors.grey,

              leading: SizedBox(width: 60, child: profileImage,),

              destinations: const <NavigationRailDestination>[
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