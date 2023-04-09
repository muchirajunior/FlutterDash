import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdash/bloc/products_bloc.dart';
import 'package:flutterdash/models/product.dart';

class ProductsTab extends StatefulWidget {
  const ProductsTab({super.key});

  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  TextEditingController productController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Card(
            child: TextFormField(
              controller: productController,
              decoration:  InputDecoration(
                border: OutlineInputBorder( 
                  borderRadius: BorderRadius.circular(18)
                ),
                hintText: "Search here  ...",
                labelText: "Search Product",
                suffixIcon: IconButton(
                  onPressed: ()=>context.read<ProductsBloc>().addproduct(Product.fromJson({
                    'name':productController.text,
                    'price':50.0,
                    'description':"product description"
                  })),
                  icon:const Icon(Icons.add),
                )
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<ProductsBloc,List<Product>>(
              builder: (context, products) => ListView(
                children: products.map((product) =>Card(
                  child: ListTile(
                    title: Text(product.name.toString()),
                    subtitle: Text(product.description.toString()),
                    trailing: Text(product.price.toString()),
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