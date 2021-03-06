import 'dart:convert';

import 'menu.dart';

class Restaurants {
  List<Restaurants> restaurantsFromJson(String str) {
    return List<Restaurants>.from(
        json.decode(str).map((x) => Restaurants.fromJson(x)));
  }

  int id;
  String name;
  String city;
  String lat;
  String lng;
  String phone;
  String image;
  double rating;
  List<Menu> menus;

  Restaurants({
    this.id,
    this.name,
    this.city,
    this.lat,
    this.lng,
    this.phone,
    this.image,
    this.rating,
  });

  factory Restaurants.fromJson(dynamic json) {
    return Restaurants(
      id: json["id"],
      name: json["name"],
      city: json["city"],
      lat: json["lat"],
      lng: json["lng"],
      phone: json["phone"],
      image: 'http://appback.ppu.edu/static/'+json["image"],
      rating: json["rating"].toDouble(),
    );
  }

  void setMenu(List<Menu> ll)
  {
    this.menus= ll ;
  }
}
