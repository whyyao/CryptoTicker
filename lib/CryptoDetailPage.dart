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
  Map icoData;
  CryptoDetailPageState(this.currencySymbol);

  @override
  void initState(){
    super.initState();
    this.getCoinBySymbol(currencySymbol);
    this.getICObySymbol(currencySymbol);
  }
  
  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(currencySymbol),
        //backgroundColor: new Color(0x979797),
      ),
      body: networkComplete()
    );
  }

  Text _getHourChanged(String hc){
    if(double.parse(hc) < 0){
      return new Text("hour changed: $hc%", style: new TextStyle(color: Colors.red),);
    }else{
      return new Text("hour changed: $hc%", style: new TextStyle(color: Colors.green),);
    }
  }

  Text _getDayChanged(String dc){
    if(double.parse(dc) < 0){
      return new Text("day changed: $dc%", style: new TextStyle(color: Colors.red),);
    }else{
      return new Text("day changed: $dc%", style: new TextStyle(color: Colors.green),);
    }
  }


  Future<String> getCoinBySymbol(String symbol) async{
    String apiUrl = 'https://chasing-coins.com/api/v1/std/coin/' + symbol.toUpperCase();
    http.Response response = await http.get(apiUrl);
    Map data = json.decode(response.body);
    setState(() {
      currencyData = data;
    });
    return "Success";
  }

  Future<String> getICObySymbol(String symbol) async{
    String apiUrl = 'https://chasing-coins.com/api/v1/icos/lookup/' + symbol.toUpperCase();
    http.Response response = await http.get(apiUrl);
    Map data = json.decode(response.body);
    setState(() {
      icoData = data;
    });
    return "Success";
  }

  Widget networkComplete(){
    if(currencyData != null && icoData != null){
  
      return new Container(child: _getCurrencyInfoWidget(), margin: new EdgeInsets.all(20.0));
      
  }else{
    return new Center(
      child: const CircularProgressIndicator(),
    );
  }
}

Widget _getCurrencyInfoWidget(){
  String heat = currencyData["coinheat"].toString();
  String name = icoData['name'];
  if(name.contains("/")){
    name = name.substring(0,name.indexOf("/")-1);
  }
  
  String money = '\$${currencyData["price"]}';
  if(money.length>= 7){
    money = money.substring(0,7);
  }
  return new Column(children: <Widget>[
          new Row(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
            new Container(margin: new EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 0.0), child: new Image.network("https://chasing-coins.com/api/v1/std/logo/" + currencySymbol.toUpperCase(), height: 84.0, width: 84.0)),
            new Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[ new Row(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[new Text(name, style: new TextStyle(fontSize: 24.0)), 
                                                                                                                  new Container(child: new Text(heat,style: new TextStyle(color: Colors.red, fontSize: 18.0)), margin: new EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),), 
                                                                                                                  new Image.asset("graphics/ic_trending_up.png",width: 24.0, height: 24.0,color: Colors.red,)]),
                                          new Text(money, style: new TextStyle(fontSize: 48.0),)
            ])
            ]),
            new Container(child: _getHourChanged(currencyData["change"]["hour"]), margin: new EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 0.0)),
            _getDayChanged(currencyData["change"]["day"]),
          
          ]);
}

}
