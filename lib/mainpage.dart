import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talabat/Restaurants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MainPage extends StatefulWidget {
  final List<Restaurants> restaurants;

  MainPage(this.restaurants);

  @override
  _MainPageState createState() => _MainPageState(restaurants);
}

class _MainPageState extends State<MainPage> {
  List<Restaurants> res;

  _MainPageState(this.res);

  String fromName;
  String fromCity;
  String fromImage;
  int fromRate;
  int fromId;

  void sortAndFilter() {
    res.sort((a, b) => b.rating.compareTo(a.rating));
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.sort,
              color: Colors.white,
            ),
            onPressed: () {
              sortAndFilter();
              setState(() {});
            },
          )
        ],
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        title: Text(
          'Restaurants List',
          style: TextStyle(fontSize: 25.0, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: res.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  color: Colors.orange[700],
                  child: Container(
                    width: 100,
                    height: 100,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8.0),
                      leading: Container(
                          height: 100,
                          width: 100,
                          child: Container(
                            child: Image.network(
                              res[index].image,
                              fit: BoxFit.fill,
                              alignment: Alignment.topLeft,
                            ),
                          )),
                      title: Container(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          res[index].name,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      subtitle: Container(
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              res[index].city,
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.black),
                            ),
                            RatingBar.builder(
                              initialRating: 0,
                              itemSize: 20.0,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 2.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
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

