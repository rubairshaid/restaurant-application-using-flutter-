import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:talabat/Restaurants.dart';

class MainPage extends StatefulWidget {
  final List<Restaurants> restaurants;

  MainPage(this.restaurants);

  @override
  _MainPageState createState() => _MainPageState(restaurants);
}

class _MainPageState extends State<MainPage> {

  List<Restaurants> res ;

  _MainPageState(this.res);

  String fromName;
  String fromCity;
  String fromImage;
  int fromRate;
  int fromId;

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
          Text("kekekekkekekke"),
          Expanded(
            child: ListView.builder(

              itemCount: res.length,
              itemBuilder: (context, index) {
                if (res.length == null)
                print ("hehehehhehehehehehheeeeeeeeeeeeeeeeeeeeeeeeeeeee");
                print (res.length);
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
          ),
        ],
      ),
    );
  }
}
