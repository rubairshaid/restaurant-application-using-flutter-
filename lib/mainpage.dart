import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talabat/Restaurants.dart';
import 'package:rating_dialog/rating_dialog.dart';

import 'appBarBody.dart';
import 'menuPage.dart';

class MainPage extends StatefulWidget {
  final List<Restaurants> restaurants;

  MainPage(this.restaurants);

  @override
  _MainPageState createState() => _MainPageState(restaurants);
}

class _MainPageState extends State<MainPage> {
  List<Restaurants> res;

  _MainPageState(this.res);

  List<Restaurants> restaurant = List<Restaurants>();

  void sortAndFilter() {
    res.sort((a, b) => b.rating.compareTo(a.rating));
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        actions: <Widget>[
          Row(
            children: [
              IconButton(
                alignment: Alignment.topLeft,
                icon: Icon(
                  Icons.sort,
                  color: Colors.white,
                ),
                onPressed: () {
                  sortAndFilter();
                  setState(() {});
                },
              ),
            ],
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              ' Restaurants List',
              style: TextStyle(fontSize: 30.0, color: Colors.black),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Card(
            color: Colors.orange[300],
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 2,
                color: Colors.orangeAccent,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: TextField(
              cursorRadius: Radius.circular(10),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: 'Search...',
                icon: Icon(
                  Icons.search,
                  size: 25.0,
                  color: Colors.black,
                ),
              ),
              onChanged: (text) {
                text = text.toLowerCase();
                setState(() {
                  restaurant = restaurant.where((element) {
                    var cityTitle = element.city.toLowerCase();
                    return cityTitle.contains(text);
                  }).toList();
                });
              },
            ),
          ),
          FutureBuilder(
            builder: (context, snapshot) {
              if (res.isEmpty) {
                return Container(
                  child: Column(
                    children: [
                      Text(
                        'Error to load restaurants page',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 5),
                  color: Colors.orangeAccent,
                  child: ListView.builder(
                    itemCount: res.length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: EdgeInsets.fromLTRB(5, 1, 5, 1),
                          child: Card(
                            color: Colors.orangeAccent[900],
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 2,
                                color: Colors.blue[50],
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      margin: EdgeInsets.fromLTRB(5, 3, 7, 3),
                                      padding: EdgeInsets.all(10),
                                      height: 100,
                                      width: 100,
                                      child: ClipRRect(
                                        child: Image.network(
                                          res[index].image,
                                          fit: BoxFit.fill,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      )),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(res[index].name,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                          res[index].city,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 25,
                                            ),
                                            Text(
                                              '${res[index].rating}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FlatButton(
                                        color: Colors.orangeAccent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons.menu,
                                                color: Colors.indigo[900],
                                              ),
                                            ],
                                          ),
                                        ),
                                        onPressed: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>  Header(),
                                              ));
                                        }
                                      ),
                                      FlatButton(
                                        color: Colors.orangeAccent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Text(
                                          'Rating',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.black),
                                        ),
                                        onPressed: () {
                                          _showMaterialDialog(res[index]);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ));
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  _showMaterialDialog(Restaurants rest) {
    showDialog(
        context: context,
        barrierDismissible: true,
        // set to false if you want to force a rating
        builder: (context) {
          return RatingDialog(
            icon: const Icon(Icons.star, size: 100, color: Colors.deepOrange),
            // set your own image/icon widget
            title: rest.name,
            description: "Tap a star to set your rating",
            submitButton: "SUBMIT",
            positiveComment: "We are so happy to hear :)",
            // optional
            negativeComment: "We're sad to hear :(",
            // optional
            accentColor: Colors.orangeAccent,
            // optional
            onSubmitPressed: (int rating) {
              print("onSubmitPressed: rating = $rating");
              rest.rating = (rating + rest.rating) ~/ 1.5;
              setState(() {});
            },
            onAlternativePressed: () {
              print("onAlternativePressed: do something");
            },
          );
        });
  }
}

