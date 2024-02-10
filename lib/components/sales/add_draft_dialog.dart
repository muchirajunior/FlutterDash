import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdash/bloc/sale_draft_bloc.dart';
import 'package:flutterdash/components/sales/drafts_handler.dart';

class AddDraftDialog extends StatelessWidget {
  const AddDraftDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    showSnackbar(message)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));

    return AlertDialog(
      title: const Text('Add Draft'),

      content: Container(
        constraints: const BoxConstraints(
          minWidth: 500
        ),
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text('title/customer name')
          ),
        ),
      ),

      actions: [
        TextButton(onPressed: ()=>Navigator.pop(context), child: const Text('Cancel')),
        TextButton(onPressed: ()async{
          if(controller.text.length<4){
            showSnackbar('too short title');
            return;
          }
          var response = await SalesDraftsHandler.addDraft(title: controller.text);
          if(response){
            var drafts =  await SalesDraftsHandler.getDrafts(); 
            if(context.mounted){
              context.read<SalesDraftBloc>().addDrafts(drafts);
              Navigator.pop(context);
            }
                          
          }
          
        }, child: const Text('Save'))
      ],
    );
  }
}