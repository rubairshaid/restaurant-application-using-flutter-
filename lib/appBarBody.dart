import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'favPage.dart';
import 'map.dart';
import 'menu.dart';
import 'Restaurants.dart';
import 'menuPage.dart';
import 'orderPage.dart';

class Header extends StatelessWidget {


  final Restaurants res ; 

  Header (this.res);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text("${res.name} menu" , style: TextStyle(color: Colors.black,fontSize: 25),),
        actions: [
          IconButton(
              icon: Icon(Icons.location_on), 
              onPressed: (){
                Navigator.push(context , MaterialPageRoute(builder: (context)=>MyMap(res.lat , res.lng)));
              }
              ),
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
      body: MenuPage(res.menus),
    );
  }
}