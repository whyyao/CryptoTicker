import 'package:flutter/material.dart';
import 'AddPage.dart';
//import 'dart:convert';
//import 'database/SavedCurrenciesDB.dart';
//import 'model/saved_currency.dart';

class HomePage extends StatefulWidget {
  @override
  createState() => new HomePageState();
}

class HomePageState extends State<HomePage>{
  //DatabaseHelper db = new DatabaseHelper();
  //List<SavedCurrency> currencies;

  @override
  void initState(){
    super.initState();
    this.getAll();
    //db.initDb();
  }

  void getAll() async{
     //currencies = await db.getAllSavedCurrency();
  }

  
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text("Settings"),
      actions: <Widget>[new IconButton(icon: new Icon(Icons.add), onPressed: _addNew)],),
      body: _getBody(),
    );
  }

  Widget _getBody() {
//    if(currencies != null) {
//      return _getListViewWidget();
//    }else{
      return new Center(child: new Text("yes"),);
    //}
  }

   void _addNew(){
     Navigator.of(context).push(
          new MaterialPageRoute(builder: (context) => new AddPage()),
        );
  }

//    Widget _getListViewWidget() {
//    return new Expanded(child: new ListView.builder(
//            itemCount: currencies.length,
//            itemBuilder: (context, index) {
//              return new Text(currencies[index].currencyCode);
//            }));
//  }
}