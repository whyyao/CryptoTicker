import 'package:flutter/material.dart';

class CryptoDetailPage extends StatelessWidget {
  final Map currency;
  CryptoDetailPage(this.currency);


  @override
  Widget build(BuildContext context) {
    final String money = '\$${currency["price_usd"]}';
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(currency["name"]),
      ),
      body: new Center(child:
      new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Column(children: <Widget>[
          new Text(currency["name"], style: new TextStyle(fontSize: 24.0),),
          new Text(money, style: new TextStyle(fontSize: 56.0),),
          _getHourChanged(currency["percent_change_1h"])
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
}
