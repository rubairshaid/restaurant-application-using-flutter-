import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'favPage.dart';
import 'menu.dart';
import 'menuPage.dart';
import 'orderPage.dart';

class Header extends StatelessWidget {

  final List<Menu>snap;
final String resName ; 
  Header(this.resName , this.snap);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text("$resName menu" , style: TextStyle(color: Colors.black,fontSize: 25),),
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
      body: MenuPage(snap),
    );
  }
}