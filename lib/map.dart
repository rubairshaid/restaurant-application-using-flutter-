import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMap extends StatelessWidget {

  final String lat ;
  final String lng;
  CameraPosition _initialPosition;
  List<Marker> mark;
  MyMap(this.lat , this.lng)
  {
     _initialPosition = CameraPosition(target: LatLng(double.parse(this.lat), double.parse(lng))); 
    mark = [Marker(markerId: MarkerId('1') , position: LatLng(double.parse(this.lat), double.parse(this.lng)))];
  }
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Hello from the other side    ; )") , 
        backgroundColor: Colors.orangeAccent,
        leading: FlatButton(
                  onPressed: () {
                    Navigator.pop(context); // go back
                  },
                  child: Icon(
                    Icons.keyboard_backspace,
                    size: 30,
                    color: Colors.white,
                  )),
            ),
        body: GoogleMap(
          initialCameraPosition:  _initialPosition,
          mapType: MapType.normal,
          markers: mark.toSet(),

        ),
      ),
    );
    }
  }