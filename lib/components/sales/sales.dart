import 'package:flutter/material.dart';
import 'package:flutterdash/components/sales/custom_search.dart';
import 'package:flutterdash/database/products_database.dart';
import 'package:flutterdash/models/product.dart';

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
    return Column(
      children: [
        //search 
        TextFormField(
          controller: searchController,
          keyboardType: TextInputType.text,
          onTap: () => showSearch(context: context,useRootNavigator: true, delegate: CustomSearchDelegate(products: products, updateSearch: updateSearch,)),
          decoration: InputDecoration(
            labelText: "search",
            hintText: "enter product name",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
            )
          ),
        ),

        const SizedBox(height: 20,),

        Card(
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height*.7,
            child: SingleChildScrollView(
              child: DataTable(
                sortColumnIndex: 1,
                sortAscending: sortAsceding,
                columns:  <DataColumn>[
                  const DataColumn(label: Text("name")),
                  DataColumn(label: const Text("price"), onSort: (columnIndex, ascending) => setState((){
                    sortAsceding=ascending;
                    selectedProducts.sort((a,b)=> ascending ? a.price!.compareTo(b.price!) : b.price!.compareTo(a.price!)  );
                    })
                    ),
                  const DataColumn(label: Text("quantity")),
                  const DataColumn(label: Text("actions")),
                ],
                rows: selectedProducts.map((product) => DataRow(cells: <DataCell> [
                  DataCell(Text(product.name.toString()) , showEditIcon: true),
                  DataCell(Text(product.price.toString(), )),
                  DataCell(Text(product.quantity.toString())),
                  DataCell(Row(children: [
                    FilledButton(onPressed: ()=>reduceItem(product), child: const Icon(Icons.remove)),
                    const SizedBox(width: 5,),
                    FilledButton(onPressed: ()=>setState(()=>product.quantity), child: const Icon(Icons.add))
                  ],))
                ] )).toList(),
              ),
            ),
          )
          )
        

      ],
    );
  }
}