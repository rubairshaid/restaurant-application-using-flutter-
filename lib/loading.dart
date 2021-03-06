import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'Restaurants.dart';
import 'array.dart';
import 'mainpage.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void fetchRestaurant() async {
    http.Response response =
        await http.get('http://appback.ppu.edu/restaurants');
    List<Restaurants> _restaurants = [];
    if (response.statusCode == 200) {
      var jsonArray = jsonDecode(response.body) as List;
      _restaurants = jsonArray.map((e) => Restaurants.fromJson(e)).toList();
    }
    allres= _restaurants;
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(_restaurants),
        ));
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Talabat',
            style: TextStyle(
                fontSize: 90.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal),
          ),
          Center(
            child: SpinKitThreeBounce(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: index.isEven ? Colors.white : Colors.white,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

