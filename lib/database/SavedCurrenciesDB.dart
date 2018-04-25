//import 'dart:async';
//import 'package:sqflite/sqflite.dart';
//import 'dart:io' as io;
//import 'package:path/path.dart';
//import 'package:path_provider/path_provider.dart';
//import '../model/saved_currency.dart';
//
//final String tableSavedCurrencies = "saved_currencies";
//final String columnId = "_id";
//final String columnCurrency= "currency_code";
//final String columnAmountOwned = "amount_owned";
//
//class DatabaseHelper {
//  static final DatabaseHelper _instance = new DatabaseHelper.internal();
//  factory DatabaseHelper() => _instance;
//  static Database _db;
//
//  Future<Database> get db async {
//    if(_db != null)
//      return _db;
//    _db = await initDb();
//    return _db;
//  }
//
//   DatabaseHelper.internal();
//
//
//  initDb() async {
//    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
//    String path = join(documentsDirectory.path, "currencies.db");
//    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
//    return theDb;
//  }
//
//  void _onCreate(Database db, int version) async {
//    // When creating the db, create the table
//    await db.execute('''
//    CREATE TABLE $tableSavedCurrencies (
//      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
//      $columnCurrency TEXT,
//      $columnAmountOwned REAL)
//    ''');
//    print("Created tables");
//  }
//
//  Future<int> insertCurrency(SavedCurrency savedCurrency) async {
//    var dbClient = await db;
//    int res = await dbClient.insert(tableSavedCurrencies, savedCurrency.toMap());
//    return res;
//  }
//
//  Future<SavedCurrency> getSavedCurrency(String currency) async {
//    var dbClient = await db;
//    List<Map> maps = await dbClient.query(tableSavedCurrencies,
//        columns: [columnId, columnAmountOwned, columnCurrency],
//        where: "$columnCurrency = ?",
//        whereArgs: [currency]);
//    if (maps.length > 0) {
//      return new SavedCurrency.fromMap(maps.first);
//    }
//    return null;
//  }
//
//  Future<List<SavedCurrency>> getAllSavedCurrency() async {
//    var dbClient = await db;
//    List<SavedCurrency> resultList;
//    List<Map> maps = await dbClient.query(tableSavedCurrencies,
//        columns: [columnId, columnAmountOwned, columnCurrency]);
//
//    for(int i = 0; i< maps.length; i++){
//      Map map = maps[i];
//      SavedCurrency currency = SavedCurrency.fromMap(map);
//      print(currency.currencyCode);
//      resultList.add(currency);
//    }
//
//    return resultList;
//  }
//
//
//
//  Future<int> deleteCurrency(String currency) async {
//    var dbClient = await db;
//    return await dbClient.delete(tableSavedCurrencies, where: "$columnCurrency = ?", whereArgs: [currency]);
//  }
//
//  Future<int> updateCurrency(SavedCurrency savedCurrency) async {
//    var dbClient = await db;
//    return await dbClient.update(tableSavedCurrencies, savedCurrency.toMap(),
//        where: "$columnCurrency = ?", whereArgs: [savedCurrency.currencyCode]);
//  }
//
//  Future close() async{
//    var dbClient = await db;
//    return dbClient.close();
//  }
//}