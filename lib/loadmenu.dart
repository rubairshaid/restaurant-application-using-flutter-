import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'Restaurants.dart';
import 'appBarBody.dart';
import 'array.dart';
import 'menu.dart';

class LoadMenu extends StatefulWidget {
  final Restaurants res ; 
  LoadMenu(this.res);
  @override
  _LoadMenuState createState() => _LoadMenuState(res);
}

class _LoadMenuState extends State<LoadMenu> {
  final Restaurants res ; 

  _LoadMenuState(this.res);

  void fetchRestaurant() async {

    List<Menu> returnedMenu =[];
    if (visitedResturants.contains(res.id))
    {
      List<Restaurants> rr = allres.where((e){return e.id==res.id;}).toList();
      returnedMenu = rr[0].menus;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Header(res),
        ));
    }
    else{
      visitedResturants.add(res.id);
   http.Response httpRes = await http.get ('http://appback.ppu.edu/menus/${res.id}');
    if (httpRes.statusCode == 200)
    {
      var jsonStr = jsonDecode(httpRes.body) as List;
      //returnedMenu = jsonStr.map((element)=> Menu.fromJson(element)).toList();
      for (int i=0 ;i<jsonStr.length;i++)
      {
        Menu m = Menu.fromJson(jsonStr[i]);
        returnedMenu.add(m);
        m.setResturant(res.name);
      }
      List<Restaurants> rr = allres.where((e){return e.id==res.id;}).toList();
      rr[0].setMenu(returnedMenu);
      
    }
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Header(res),
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

