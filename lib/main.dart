import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
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


void main() async{
  List info = await getInfo();
  runApp(new MaterialApp(
    theme: defaultTargetPlatform == TargetPlatform.iOS
        ? kIOSTheme
        : kDefaultTheme,
    home: new Center(
      child: new CurrenciesWidget(info),
    ),
  ));
}

Future<List> getInfo() async {
  String apiUrl = 'https://api.coinmarketcap.com/v1/ticker/?limit=10';
  http.Response response = await http.get(apiUrl);
  return json.decode(response.body);
}

class CurrenciesWidget extends StatelessWidget{
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];
  final List _currencies;

  CurrenciesWidget(this._currencies);

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
    return new Container(
      child: new Column(
        // Column for keeping to top down 
        children: <Widget>[_getListViewWidget()],
      ),
    );
  }

  Widget _getListViewWidget() {
    return new Flexible(
        child: new ListView.builder(
            itemCount: _currencies.length,
            itemBuilder: (context, index) {
              final Map currency = _currencies[index];
              final MaterialColor color = _colors[index % _colors.length];
              return _getListTileWithPlatform(context, currency, color);
            })
    );
  }

  CircleAvatar _getLeadingWidget(String currencyName, MaterialColor color) {
    return new CircleAvatar(
      backgroundColor: color,
      child: new Text(currencyName[0]),
    );
  }

  Text _getTitleWidget(String currencyName) {
    return new Text(
      currencyName,
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
      leading: _getLeadingWidget(currency['name'], color),
      title: _getTitleWidget(currency['name']),
      trailing: _getSubtitleText(currency['price_usd']),
      onTap: (){
        Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => new CryptoDetailPage(currency)),
        );
      }
    );
  }

  Widget _getListTileWithPlatform(BuildContext context, Map currency, MaterialColor color){
    if(defaultTargetPlatform == TargetPlatform.iOS){
      return _getListTile(context, currency, color);
    }else{
      return new Card(child: _getListTile(context, currency, color),);
    }
  }
}

