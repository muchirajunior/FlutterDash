import 'package:flutterdash/models/product.dart';
import 'package:flutterdash/utils.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ProductsDBHelper {
  Future<Database> getDatabse() async {
    var databaseFactory = databaseFactoryFfi;
    var db = await databaseFactory.openDatabase("${Utils.databasePath}products.db");
    try {
      await db.execute(" CREATE TABLE products (id INTEGER PRIMARY KEY autoincrement,name TEXT,code TEXT,price REAL,quantity INTEGER)");
    } catch(error){ ()=>{} ;}
    return db;
  }

  Future insertProduct(Product product)async{
    Database database= await getDatabse();
    await database.insert("products", product.toJson());
  }

  Future<List<Product>> getAllProducts()async{
    Database database= await getDatabse();
    List<Map> data= await database.query("products");
    List<Product> products=[];
    if(data.isNotEmpty){
      for (var element in data) {
        products.add(Product.fromJson(element));
      }
    }
    return products;
  }

  Future deleteProduct(int id)async{
    Database database= await getDatabse();
    await database.delete("products",where: "id=?",whereArgs: [id]);
  }


}
