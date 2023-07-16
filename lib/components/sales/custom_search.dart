import 'package:flutter/material.dart';
import 'package:flutterdash/models/product.dart';

class CustomSearchDelegate extends SearchDelegate{
  List<Product> products;
  Function updateSearch;
  CustomSearchDelegate({required this.products, required this.updateSearch}) : super(
    
  );

  @override
  ThemeData appBarTheme(BuildContext context){
    return Theme.of(context).copyWith(
      appBarTheme: const AppBarTheme(
        elevation: 6
      )
    );
  }

  

  @override
  List<Widget> buildActions(BuildContext context){
    return [
      IconButton(onPressed: ()=>query='', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context){
    return IconButton(onPressed: ()=>close(context, null), icon:const Icon(Icons.arrow_back));
  } 

  @override 
  Widget buildResults(BuildContext context){
    List<Product> matchQuery=products.where((product)=>product.name.toString().toLowerCase().contains(query.toLowerCase())).toList();
    return ListView(
      children: matchQuery.map((product) => ListTile(
        title: Text(product.name.toString()),
          onTap: () {
          updateSearch(product);
          close(context, null);
        },
        )).toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context){
    List<Product> matchQuery=products.where((product)=>product.name.toString().toLowerCase().contains(query.toLowerCase())).take(4).toList();
    return ListView(
      children: matchQuery.map((product) => ListTile(
        title: Text(product.name.toString()),
        trailing: Text("in stock ${product.quantity}", style:const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
        onTap: () {
          updateSearch(product);
          close(context, null);
        },
        )).toList(),
    );
  }
}