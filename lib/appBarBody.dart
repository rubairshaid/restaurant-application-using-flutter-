import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'favPage.dart';
import 'menuPage.dart';
import 'orderPage.dart';

class Header extends StatelessWidget {

  String resName ; 
  int resId ; 

  Header(this.resId , this.resName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text("$resName menu" ),
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
      body: MenuPage(resId , resName),
    );
  }
}