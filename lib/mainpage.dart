import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:talabat/Restaurants.dart';

class MainPage extends StatefulWidget {
  final List<Restaurants> restaurants;

  MainPage(this.restaurants);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<List<Restaurants>> restaurants;
  String fromName;
  String fromCity;
  String fromImage;
  int fromRate;
  int fromId;

  // @override
  // void initState() {
  //   super.initState();
  //   fromId = json['id'];
  //   restaurants = fetchRestaurant(fromId);
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        title: Text(
          'Restaurants List',
          style: TextStyle(fontSize: 25.0, color: Colors.deepOrangeAccent),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border(
                left: BorderSide(
                  color: Colors.deepOrangeAccent[100],
                  width: 3,
                ),
              ),
            ),
            height: 50,
            color: Colors.deepOrangeAccent[100],
            margin: EdgeInsets.all(10.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 40,
                child: CircleAvatar(
                  backgroundImage: ExactAssetImage(fromImage),
                  minRadius: 40,
                  maxRadius: 40,
                ),
              ),
              title: Text(fromName),
              subtitle: Text(fromCity),
            ),
          ),
          FutureBuilder(
            future: restaurants,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Restaurants> res = snapshot.data;
                if (res.isEmpty) {
                  return SpinKitThreeBounce(
                    color: Colors.orangeAccent[500],
                    size: 50,
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: res.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.orangeAccent,
                        margin: EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () {
                            fromImage = res[index].image;
                            fromName = res[index].name;
                            fromRate = res[index].rating;
                            res.clear();
                            setState(() {});
                            // restaurants = fetchRestaurant(fromId);
                          },
                          leading: Image.network(res[index].image),
                          title: Text(res[index].name),
                          subtitle: Text('${res[index].rating}'),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return SpinKitThreeBounce(
                  color: Colors.deepOrange[500],
                  size: 50,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
