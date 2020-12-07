import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:talabat/menuPage.dart';
import 'Restaurants.dart';
import 'appBarBody.dart';
import 'array.dart';
import 'mainpage.dart';
import 'menu.dart';

class LoadMenu extends StatefulWidget {
  String resName ; 
  int resId;
  LoadMenu(this.resId , this.resName);
  @override
  _LoadMenuState createState() => _LoadMenuState(resId , resName);
}

class _LoadMenuState extends State<LoadMenu> {
  String resName ; 
  int resId;

  _LoadMenuState(this.resId , this.resName);

  void fetchRestaurant() async {

    List<Menu> returnedMenu =[];
    if (visitedResturants.contains(resId))
    {
      List<Restaurants> rr = allres.where((e){return e.id==resId;}).toList();
      returnedMenu = rr[0].menus;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Header(resName , returnedMenu),
        ));
    }
    else{
      visitedResturants.add(resId);
   http.Response httpRes = await http.get ('http://appback.ppu.edu/menus/$resId');
    if (httpRes.statusCode == 200)
    {
      var jsonStr = jsonDecode(httpRes.body) as List;
      //returnedMenu = jsonStr.map((element)=> Menu.fromJson(element)).toList();
      for (int i=0 ;i<jsonStr.length;i++)
      {
        Menu m = Menu.fromJson(jsonStr[i]);
        returnedMenu.add(m);
        m.setResturant(resName);
      }
      List<Restaurants> rr = allres.where((e){return e.id==resId;}).toList();
      rr[0].setMenu(returnedMenu);
      
    }
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Header(resName , returnedMenu),
        ));
        }
  }

  @override
  void initState() {
    super.initState();
    fetchRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: SpinKitFoldingCube(
                            color: Colors.blue,
                            size: 50.0,
      )
   );
  }
}

