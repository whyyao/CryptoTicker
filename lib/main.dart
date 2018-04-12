import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'CryptoDetailPage.dart';


final ThemeData kIOSTheme = new ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = new ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);


void main(){
  runApp(new MaterialApp(
    theme: defaultTargetPlatform == TargetPlatform.iOS
        ? kIOSTheme
        : kDefaultTheme,
    home: new Center(
      child: new CurrenciesWidget(),
    ),
  ));
}

class CurrenciesWidget extends StatefulWidget {
  @override
  CurrenciesWidgetState createState() => new CurrenciesWidgetState();
}


class CurrenciesWidgetState extends State<CurrenciesWidget>{
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];
  Map _currencies;
  Map currencyInfo = new Map();

  @override
  void initState(){
    super.initState();
    this.getTopCoins();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Crypto Ticker"),
      ),
      body: _buildBody(),
      //backgroundColor: Colors.blue,
    );
  }

   Widget _buildBody() {
     if(_currencies != null){
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
    return new Expanded(child: new ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              final indexStr = (index + 1).toString();
              final Map currency = _currencies[indexStr];
              final MaterialColor color = _colors[index % _colors.length];
              return _getListTileWithPlatform(context, currency, color);
            }));
  }

  CircleAvatar _getLeadingWidget(String currencyName, MaterialColor color) {
    return new CircleAvatar(
      backgroundColor: new Color(0x00000000),
      backgroundImage: new Image.network("https://chasing-coins.com/api/v1/std/logo/" + currencyName.toUpperCase()).image,
    );
  }

  Text _getTitleWidget(String coinData){
    return new Text(
      coinData,
      style: new TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _getSubtitleText(String priceUsd) {
    TextSpan priceTextWidget = new TextSpan(text: "\$$priceUsd", style:
    new TextStyle(color: Colors.black, fontSize: 18.0),);
    return new RichText(text: priceTextWidget);
  }

  ListTile _getListTile(BuildContext context, Map currency, MaterialColor color) {     
    return new ListTile(
      leading: _getLeadingWidget(currency['symbol'], color),
      title:  _getTitleWidget(currency['symbol']),
      trailing: _getSubtitleText(currency['price']),
      onTap: (){
        Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => new CryptoDetailPage(currency['symbol'].toString())),
        );
      }
    );
  }

  Future<String> getTopCoins() async {
    String apiUrl = 'https://chasing-coins.com/api/v1/top-coins/20';
    http.Response response = await http.get(apiUrl);
    Map data = json.decode(response.body);
    setState((){
      _currencies = data;
      });
    return "Success";
  }

  Widget _getListTileWithPlatform(BuildContext context, Map currency, MaterialColor color){
    if(defaultTargetPlatform == TargetPlatform.iOS){
      return _getListTile(context, currency, color);
    }else{
      return new Card(child: _getListTile(context, currency, color),);
    }
  }
}

