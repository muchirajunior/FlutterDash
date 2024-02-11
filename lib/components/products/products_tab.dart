import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdash/bloc/products_bloc.dart';
import 'package:flutterdash/components/products/add_product.dart';
import 'package:flutterdash/database/products_database.dart';
import 'package:flutterdash/models/product.dart';

class ProductsTab extends StatefulWidget {
  const ProductsTab({super.key});

  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  TextEditingController searchController= TextEditingController();
  ProductsDBHelper productsDBHelper=ProductsDBHelper();

  loadProducts()async{
      var products=await productsDBHelper.getAllProducts();
      if(context.mounted){
         context.read<ProductsBloc>().resetState(products);
      }
     
  }

  deleteProduct(int id){
      showDialog(context: context, builder: (context)=>AlertDialog(
        title:const Text("Are you sure you want to delete this product"),
        actions: [
          OutlinedButton(onPressed: ()=>Navigator.pop(context), child: const Text("cancel")),
          OutlinedButton(onPressed: ()async{
            await productsDBHelper.deleteProduct(id);
            await loadProducts();
            if(context.mounted) {
              Navigator.pop(context);
            }
          }, child:const Text("Delete")),
        ],
      ));
  }

  @override
  void initState() {
    loadProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: searchController,
                  onChanged: (_)=>setState(() {}),
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
              const SizedBox(
                width:140,
                height: 50,
                child: AddProduct()
              )
            ],
          ),
          Expanded(
            child: BlocBuilder<ProductsBloc,List<Product>>(
              builder: (context, products) => ListView(
                children:  products.map((product) => product.name!.toLowerCase().contains(searchController.text.toLowerCase()) ? 
                Card(
                  child: ListTile(
                    leading: Card(
                      color: Theme.of(context).primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(product.quantity.toString(), style: const TextStyle(color: Colors.white),),
                      ),
                    ),
                    title: Text(product.name.toString()),
                    subtitle: Text(product.code.toString()),
                    trailing: Text("\$ ${product.price.toString()}"),
                    onTap: ()=>deleteProduct(product.id!),
                  ),
                ) : const SizedBox()
               ).toList()
              ),
            ) 
          )
        ],
      ),
    );
  }
}