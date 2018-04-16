import 'package:flutter/material.dart';

class Setting extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text("Settings"),),
      body: _getBody(),
    );
  }

  Widget _getBody(){
    return new Center(
      child: new Container(child: new Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[ new Container(child:new Image.asset("graphics/app_icon.png",height: 36.0, width: 36.0,), margin: new EdgeInsets.all(8.0),), 
      new Text("Ether Ticker v1.0.0"),
      new Text("with Flutter"),
      ]))
    );
  }
}