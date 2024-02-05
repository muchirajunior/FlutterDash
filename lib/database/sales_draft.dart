import 'dart:developer';

import 'package:flutterdash/utils.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite_common/sqlite_api.dart' show Database ;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SalesDraftDbHelper{
  Future<Database> _getDatabase()async{
    var databaseFactory = databaseFactoryFfi;
    var db = await databaseFactory.openDatabase("${Utils.databasePath}salesdrafts.db");
    try {
      await db.execute('''
        CREATE TABLE salesdafts (
          id INTEGER PRIMARY KEY,
          title TEXT,
          item
        )
      ''');
    } on Exception catch (error) { log(error.toString()); }

    return db;
  }
}