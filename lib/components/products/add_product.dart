import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdash/bloc/products_bloc.dart';
import 'package:flutterdash/components/componets.dart';
import 'package:flutterdash/database/products_database.dart';
import 'package:flutterdash/models/product.dart';


class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController nameController=TextEditingController();
  TextEditingController priceController=TextEditingController();
  TextEditingController quantityController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  ProductsDBHelper productsDBHelper= ProductsDBHelper();


  addItemDialog(){
    showDialog(context:context, builder: (context)=>AlertDialog(
      title: const Text("Add product"),
      contentPadding: const EdgeInsets.all(5),
      content: SizedBox(
        height: 400,
        width: 400,
        child: Column(
          children: [
            customTextInput(nameController, "product name"),
            customTextInput(priceController, "price",inputType: TextInputType.number),
            customTextInput(quantityController, "Quantity",inputType: TextInputType.number),
            customTextInput(descriptionController, "Description",maxLines: 3),
          ],
        ),
      ),
      actions: [
        OutlinedButton(onPressed: ()=>Navigator.pop(context), child: const Text('cancel')),
         OutlinedButton(onPressed: addproduct, child: const Text('add item')),
      ],
    ));
  }

  addproduct()async{
    var product =Product.fromJson({
      "name":nameController.text,
      "price":double.tryParse(priceController.text),
      "quantity":int.tryParse(quantityController.text),
      'description':descriptionController.text
    });
    context.read<ProductsBloc>().addproduct(product);
    await productsDBHelper.insertProduct(product);
    var data= await productsDBHelper.getAllProducts();
    context.read<ProductsBloc>().resetState(data);
    nameController.clear();
    priceController.clear();
    descriptionController.clear();
    quantityController.clear();
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: addItemDialog, 
      child: const Text("Add Product")
    ) ;
  }
}