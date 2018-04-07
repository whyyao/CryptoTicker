import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CryptoDetailPage extends StatefulWidget{
  final String currencySymbol;
  CryptoDetailPage(this.currencySymbol);

  @override
  CryptoDetailPageState createState() => new CryptoDetailPageState(currencySymbol);
}

class CryptoDetailPageState extends State<CryptoDetailPage> {
  final String currencySymbol;
  Map currencyData;
  CryptoDetailPageState(this.currencySymbol);

  @override
  void initState(){
    super.initState();
    this.getCoinBySymbol(currencySymbol);
  }
  
  @override
  Widget build(BuildContext context) {
    final String money = '\$${currencyData["price"]}';
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(currencySymbol),
      ),
      body: new Center(child:
      new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Column(children: <Widget>[
          new Text(currencySymbol, style: new TextStyle(fontSize: 24.0),),
          new Text(money, style: new TextStyle(fontSize: 56.0),),
          _getHourChanged(currencyData["change"]["hour"])
        ]
        ),

      )

      ),
    );
  }

  Text _getHourChanged(String hc){
    if(double.parse(hc) < 0){
      return new Text("hour changed: ${hc}%", style: new TextStyle(color: Colors.red),);
    }else{
      return new Text("hour changed: ${hc}%", style: new TextStyle(color: Colors.green),);
    }
  }

  Future<String> getCoinBySymbol(String symbol) async{
    String apiUrl = 'https://chasing-coins.com/api/v1/std/coin/' + symbol.toUpperCase();
    print(apiUrl);
    http.Response response = await http.get(apiUrl);
    Map data = json.decode(response.body);
    setState(() {
      currencyData = data;
    });
    return "Success";
  }


}
