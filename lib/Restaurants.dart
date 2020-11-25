import 'dart:convert';

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
  int rating;

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
    String img = json['image'];

    return Restaurants(
      id: json["id"],
      name: json["name"],
      city: json["city"],
      lat: json["lat"],
      lng: json["lng"],
      phone: json["phone"],
      image: 'http://appback.ppu.edu/static/$img',
      rating: json["rating"],
    );
  }
}
