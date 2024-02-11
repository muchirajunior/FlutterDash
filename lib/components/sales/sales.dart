import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdash/bloc/sale_draft_bloc.dart';
import 'package:flutterdash/components/sales/add_draft_dialog.dart';
import 'package:flutterdash/components/sales/drafts_handler.dart';
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
  var draftSearchController =  TextEditingController();
  var productsDB=ProductsDBHelper();
  List<Product> products=[];
  List<Product> selectedProducts=[];
  bool sortAsceding=true;
  int? selectedId;

  showSnackbar(message)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));

  getProducts()async{
    products=await productsDB.getAllProducts();
    setState(() { });
  }

  loadDrafts()async{
    var drafts = await SalesDraftsHandler.getDrafts();
    if(context.mounted){
      context.read<SalesDraftBloc>().addDrafts(drafts);
    }
  }

  @override
  void initState() {
    loadDrafts();
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
              controller: draftSearchController,
              onSelected: (value)=> setState(() {
                selectedId = value != null ? selectedId=value.id : null ;
              }),
              dropdownMenuEntries: drafts.map((draft) => DropdownMenuEntry(
                value: draft, 
                label: draft.title,
                trailingIcon: IconButton(
                  onPressed: () async{
                     if(draft.id == selectedId){
                      draftSearchController.clear();
                      setState(()=> selectedId = null);
                    }
                    await SalesDraftsHandler.deleteDraft(draft: draft);
                    await loadDrafts();
                   
                  },
                  icon: const Icon(Icons.delete),
                )
              )).toList(),
            ),

                        
            Expanded(
              child: selectedId == null ? const Center( child: Text('No  Selected Draft ..!'),) :
              SizedBox(
                width: double.infinity,
                child: Card(
                  margin: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: DataTable(
                      showBottomBorder: true,
                      // horizontalMargin: 100,
                      columns: const <DataColumn>[
                        DataColumn(label: Text('Code')),
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Price')),
                        DataColumn(label: Text('Quantity')),
                        DataColumn(label: Text('Actions')),
                      ],
                      rows: drafts.firstWhere((d) => d.id == selectedId ).items.map((item) => DataRow(
                        cells: <DataCell>[
                          DataCell(Text(item.code)),
                          DataCell(Text(item.name)),
                          DataCell(Text(item.price.toString())),
                          DataCell(Text(item.quantity.toString())),
                          DataCell(Row(
                            children: [
                              FilledButton(onPressed: ()async{
                                item.quantity++;
                                var draft = drafts.firstWhere((element) => element.id ==selectedId);
                                draft.items= draft.items.map((x) => x.code == item.code ? item : x).toList();
                                await SalesDraftsHandler.updateDraft(draft: draft);
                                await loadDrafts();
                              }, child: const Icon(Icons.add)),
                              FilledButton(onPressed: ()async{
                                var draft = drafts.firstWhere((element) => element.id ==selectedId);
                                if(item.quantity>1){
                                  item.quantity--;
                                  draft.items= draft.items.map((x) => x.code == item.code ? item : x).toList();
                                }else{
                                  draft.items.removeWhere((element) => element.code==item.code);
                                }                              
                                await SalesDraftsHandler.updateDraft(draft: draft);
                                await loadDrafts();
                              }, child: const Icon(Icons.remove)),
                            ],
                          ))
                        ]
                      )).toList()+[
                        DataRow(cells: [
                          DataCell(DropdownMenu(
                                enableFilter: true,
                                expandedInsets: const EdgeInsets.all(2),
                                controller: searchController,
                                onSelected: (value) async{
                                  if(value != null){
                                    var draft = drafts.firstWhere((element) => element.id==selectedId);
                                    value.quantity = 1;
                                    if(draft.items.where((element) => element.code== value.code).toList().isNotEmpty){
                                      showSnackbar('item already exists');
                                      searchController.clear();
                                      return;
                                    }
                                    draft.items.add( SalesDraftItem.fromJson(value.toJson()) );
                                    await SalesDraftsHandler.updateDraft(draft: draft);
                                    await loadDrafts();
                                    searchController.clear();
                                    // setState((){});
                                  }
                                  
                                },
                                label: const Text('item search'),
                                dropdownMenuEntries: products.map((product) => DropdownMenuEntry(
                                  value: product, 
                                  label: product.code.toString()
                                  )).toList(),
                              )
                            
                          ),
                          const DataCell(SizedBox() ),
                          const DataCell(Text('')),
                          const DataCell(Text('')),
                          const DataCell(Text(''))
                        ])
                      ]
                    ),
                  ),
                ),
              )
            ),


          

          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: ()=>showDialog(context: context, barrierDismissible: false, builder: (context)=>const AddDraftDialog()),
        child: const Icon(Icons.add),
      ),
    );

    
  }
}