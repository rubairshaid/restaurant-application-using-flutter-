import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'favPage.dart';
import 'menuPage.dart';
import 'orderPage.dart';

class Header extends StatelessWidget {
  const Header({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite menus" ),
        actions: [
          IconButton(
              icon: Icon(Icons.fastfood ), 
              onPressed: (){
                Navigator.push(context , MaterialPageRoute(builder: (context)=>OrderPage()));
              }
              ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: (){
              Navigator.push(context ,MaterialPageRoute(builder: (context)=>FavoritePage()));
            })
        ],
      ),
      body: MenuPage(),
    );
  }
}