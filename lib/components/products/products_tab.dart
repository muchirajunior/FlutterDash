import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdash/bloc/products_bloc.dart';
import 'package:flutterdash/components/products/add_product.dart';
import 'package:flutterdash/models/product.dart';

class ProductsTab extends StatefulWidget {
  const ProductsTab({super.key});

  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  TextEditingController searchController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width*.7,
                child: TextFormField(
                  controller: searchController,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder( 
                      borderRadius: BorderRadius.circular(18)
                    ),
                    hintText: "Search here  ...",
                    labelText: "Search Product",
                  ),
                ),
              ),
              const SizedBox(width: 20,),
              const AddProduct()
            ],
          ),
          Expanded(
            child: BlocBuilder<ProductsBloc,List<Product>>(
              builder: (context, products) => ListView(
                children: products.map((product) =>Card(
                  child: ListTile(
                    leading: Card(
                      
                      color: Theme.of(context).primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(product.quantity.toString(), style: const TextStyle(color: Colors.white),),
                      ),
                    ),
                    title: Text(product.name.toString()),
                    subtitle: Text(product.description.toString()),
                    trailing: Text("\$ ${product.price.toString()}"),
                  ),
                ) ).toList(),
              ),
            ) 
          )
        ],
      ),
    );
  }
}