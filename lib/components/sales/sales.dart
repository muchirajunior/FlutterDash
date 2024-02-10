import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdash/bloc/sale_draft_bloc.dart';
import 'package:flutterdash/components/sales/add_draft_dialog.dart';
import 'package:flutterdash/database/products_database.dart';
import 'package:flutterdash/models/product.dart';
import 'package:flutterdash/models/sales_daft.dart';

class SalesTab extends StatefulWidget {
  const SalesTab({super.key});

  @override
  State<SalesTab> createState() => _SalesTabState();
}

class _SalesTabState extends State<SalesTab> {
  var searchController =  TextEditingController();
  var productsDB=ProductsDBHelper();
  List<Product> products=[];
  List<Product> selectedProducts=[];
  bool sortAsceding=true;

  getProducts()async{
    products=await productsDB.getAllProducts();
    setState(() { });
  }

  updateSearch(Product product){
    if(selectedProducts.contains(product)){
      selectedProducts.where((element) => element.id==product.id).first.quantity+=1;
      setState(() {});
    }else{
      setState(()=> selectedProducts.add(product));
    }
    // setState(()=> selectedProducts.add(product));
  }
  

  reduceItem(Product product){
    if(product.quantity == 1){
      selectedProducts.remove(product);
    }else{
      product.quantity-=1;
    }
    setState(() { });
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SalesDraftBloc, List<SalesDraft>>(
        builder: (context,drafts)=>Column(
          children: [
            DropdownMenu(
              label: const Text('Sales Drafts'),
              expandedInsets: const EdgeInsets.all(10),
              menuHeight: 200,
              dropdownMenuEntries: drafts.map((draft) => DropdownMenuEntry(
                value: draft, 
                label: draft.title
              )).toList(),
            ),

          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: ()=>showDialog(context: context, builder: (context)=>const AddDraftDialog()),
        child: const Icon(Icons.add),
      ),
    );

    
  }
}