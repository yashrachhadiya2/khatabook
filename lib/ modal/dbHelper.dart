import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Database? db;

  Future<Database> checkDatabase() async {
    if (db != null) {
      return db!;
    } else {
      return await createDatabase();
    }
  }

  Future<Database> createDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String path = join(folder.path, "rnw.db");
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE std(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT, mobile TEXT)";
        String query1 =
            "CREATE TABLE product(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,amount TEXT,date TEXT,time TEXT,client_id INTEGER,payment_status INTEGER)";
        db.execute(query1);
        db.execute(query);
      },
    );

    return openDatabase(path, version: 1, onCreate: (db, version) {
      String query = "CREATE TABLE std (id INTEGER K)";
    });
  }

  void insertData(String n1, String m1) async {
    db = await checkDatabase();
    db!.insert("std", {"name": n1, "mobile": m1});
  }

  Future<List<Map>> readData() async {
    db = await checkDatabase();
    String query = "SELECT * FROM std";
    List<Map> stdList = await db!.rawQuery(query, null);

    return stdList;
  }

  void deleteData(String id) async {
    db = await checkDatabase();
    db!.delete("std", where: "id = ?", whereArgs: [int.parse(id)]);
  }

  void updateData(String id, String n1, String m1) async {
    db = await checkDatabase();
    db!.update("std", {"name": n1, "mobile": m1},
        where: "id = ?", whereArgs: [int.parse(id)]);
  }




















  void productinsertData(String n1, String a1, String d1, String t1,
      int clientId, int status) async {
    db = await checkDatabase();
    db!.insert("product", {
      "name": n1,
      "amount": a1,
      "date": d1,
      "time": t1,
      "client_id": clientId,
      "payment_status": status
    });
  }

  Future<List<Map>> productreadData({String? id}) async {
    db = await checkDatabase();
    String query = "";
    if (id != null)
      query = "SELECT * FROM product where client_id = $id";
    else
      query = "SELECT * FROM product";

    List<Map> productlist = await db!.rawQuery(query, null);

    return productlist;
  }

  Future<List<Map>> ProductFilterReadData(String? date) async {
    db = await checkDatabase();
    String query = "SELECT * FROM product where date = ?";
    List<Map> productlist = await db!.rawQuery(query, [date]);

    return productlist;
  }

  void productdeleteData(String id) async {
    db = await checkDatabase();
    db!.delete("product", where: "id = ?", whereArgs: [int.parse(id)]);
  }

  void productupdateData(
      String id, String n1, String a1, String d1, String t1) async {
    db = await checkDatabase();
    db!.update("product", {"name": n1, "amount": a1, "date": d1, "time": t1},
        where: "id = ?", whereArgs: [int.parse(id)]);
  }

}
