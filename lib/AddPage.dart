import 'package:flutter/material.dart';
import 'src/flutter_search_bar_base.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import 'package:flutter/foundation.dart';
import 'CryptoDetailPage.dart';
//import 'database/SavedCurrenciesDB.dart';
//import 'model/saved_currency.dart';

class AddPage extends StatefulWidget {
  @override
  AddPageState createState() => new AddPageState();
}

class AddPageState extends State<AddPage>{
  SearchBar searchBar;
  List allCoins;
  String searchKeywords = "";
  //DatabaseHelper db = DatabaseHelper.internal();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState(){
    super.initState();
    this.getAllCoins();
    //db.initDb();
  }

  @override
  void dispose(){
    super.dispose();
    searchKeywords = "";
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('Search Bar Demo'),
        actions: [searchBar.getSearchAction(context)]);
  }

  void onSubmitted(String value) {
    setState(() => 
      searchKeywords = value
    );

  }

  Future<String> getAllCoins() async {
    String apiUrl = 'https://chasing-coins.com/api/v1/coins';
    http.Response response = await http.get(apiUrl);
    List data = json.decode(response.body);
    setState((){
      allCoins = data;
      });
    return "Success";
  }


  AddPageState() {
    searchBar = new SearchBar(
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted);
  }

  Widget _buildBody() {
     if(allCoins != null){
      return new Container(
        child: new Column(
          // Column for keeping to top down 
          children: <Widget>[_getListViewWidget()],
        ),
      );
     }else{
       return new Center(
         child: const CircularProgressIndicator(),
       );
     }
  }

  Widget _getListViewWidget() {
    List resultList = new List();

    if(searchKeywords == ''){
      resultList = allCoins;
    }else{
      allCoins.forEach((item){
        if(item.contains(searchKeywords.toUpperCase())){
          resultList.add(item);
        }
      });
    }
   
    return new Expanded(child: new ListView.builder(
            itemCount: resultList.length,
            itemBuilder: (context, index) {
              return _getListTileWithPlatform(context, resultList[index].toString());
            }));
  }

  ListTile _getListTile(BuildContext context, String currency) {
    var currencyMap = {
      'currency_code': "BTC",
      'amount_owned': 0.0
    };
    //SavedCurrency curr = SavedCurrency.fromMap(currencyMap);
    return new ListTile(
      leading: _getLeadingWidget(currency),
      title: new Text(currency),
      // trailing: new Icon(Icons.add),
      trailing: new IconButton(icon:new Icon(Icons.add),
      onPressed: (){

      }
      ),
    );
  }

  CircleAvatar _getLeadingWidget(String currencyName) {
    return new CircleAvatar(
      backgroundColor: new Color(0x00000000),
      backgroundImage: new Image.network("https://chasing-coins.com/api/v1/std/logo/" + currencyName.toUpperCase()).image,
    );
  }

   Widget _getListTileWithPlatform(BuildContext context, String currency){
    if(defaultTargetPlatform == TargetPlatform.iOS){
      return _getListTile(context, currency);
    }else{
      return new Card(child: _getListTile(context, currency));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: searchBar.build(context),
      key: _scaffoldKey,
      body: _buildBody()
    );
  }

//  void onAdded(SavedCurrency curr){
//    db.insertCurrency(curr);
//  }

}