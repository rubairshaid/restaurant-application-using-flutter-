import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'Restaurants.dart';
import 'mainpage.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  List<Restaurants> restaurants = [];

  void fetchRestaurant() async {
    http.Response response =
        await http.get('http://appback.ppu.edu/restaurants');
    if (response.statusCode == 200) {
      var jsonArray = jsonDecode(response.body)['restaurants'] as List;
      restaurants = jsonArray.map((e) => Restaurants.fromJson(e)).toList();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(restaurants),
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
      body: Column(
        children: [
          Container(
            child: Image.network(
              'https://image.similarpng.com/very-thumbnail/2020/06/Fast-delivery-package-by-scooter-mobile-phone-order-vector-PNG.png',
              fit: BoxFit.cover,
            ),
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
