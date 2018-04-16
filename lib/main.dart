import 'package:flutter/material.dart';
import 'dart:core';
import 'CurrencyWidget.dart';
import 'Setting.dart';
import 'HomePage.dart';


void main(){
  runApp(new MaterialApp(
    home: new Center(
      child: new MainPage(),
    ),
    //theme: new ThemeData(primaryColor: new Color(0x979797),),
  ));
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  PageController _pageController;

  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
  
        body: new PageView(
          children: [
            new HomePage(),
            new CurrenciesWidget(),
            new Setting()
          ],
          /// Specify the page controller
          controller: _pageController,
          onPageChanged: onPageChanged
        ),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text("Home")
          ), 
          new BottomNavigationBarItem(
              icon: new Icon(Icons.trending_up),
              title: new Text("Trending")
          ),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.settings),
              title: new Text("Settings")
          )
    
        ],

        onTap: navigationTapped,
        currentIndex: _page
      )
    );
  }

  void navigationTapped(int page){

    _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease
    );
  }


  void onPageChanged(int page){
    setState((){
      this._page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose(){
    super.dispose();
    _pageController.dispose();
  }


}


