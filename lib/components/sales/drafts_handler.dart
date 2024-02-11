import 'dart:convert';
import 'dart:developer';

import 'package:flutterdash/models/sales_daft.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalesDraftsHandler{

  static Future<List<SalesDraft>> getDrafts()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<SalesDraft> drafts=[];
    String results=preferences.getString('drafts') ?? "[]";
    List data = jsonDecode(results);
    for (var json in data) {
      drafts.add(SalesDraft.fromJson(json));
    }

    return drafts;
  }

  static Future<bool> addDraft({required String title})async{
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      List<SalesDraft> drafts=await getDrafts();
      var draft = SalesDraft(id: drafts.isEmpty ? 1 : drafts.last.id+1, title: title);
      drafts.add(draft);
      var data = drafts.map((d) => d.toJson()).toList();
      var newDrafts = jsonEncode(data);
      preferences.setString('drafts', newDrafts);
      return true;
    } catch (error) {
      log('error adding draft', error: error);
    }
    return false;
  }

  static Future<bool> updateDraft({required SalesDraft draft})async{
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      List<SalesDraft> drafts=await getDrafts();
      drafts = drafts.map((saleDraft) => saleDraft.id == draft.id ? draft : saleDraft ).toList();
      var data = drafts.map((d) => d.toJson()).toList();
      var newDrafts = jsonEncode(data);
      preferences.setString('drafts', newDrafts);
      return true;
    } catch (error) {
      log('error updating draft', error: error);
    }

    return false;
  }

  static Future<bool> deleteDraft({required SalesDraft draft})async{
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      List<SalesDraft> drafts=await getDrafts();
      drafts.removeWhere((d)=>d.id == draft.id);
      var data = drafts.map((d) => d.toJson()).toList();
      var newDrafts = jsonEncode(data);
      preferences.setString('drafts', newDrafts);
      return true;
    } catch (error) {
      log('error deleting draft', error: error);
    }

    return false;
  }


}